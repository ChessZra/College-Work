package edu.uic.cs454.s25.a3;

import org.junit.Assert;
import org.junit.Test;

import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicReference;

public class Test03_Progress {

    public static final int WORK = 500_000;

    @Test
    public void progressGetOneBus() {
        Depot depot = Depot.createDepot();
        Bus slow, fast;
        Ticket[] tickets = new Ticket[WORK];
        Set<Ticket> slowContents = new HashSet<>();

        // Set up
        {
            int slowCapacity = tickets.length - 1;
            slow = depot.createBus(slowCapacity);

            for (int i = 1 ; i < slowCapacity ; i++) {
                tickets[i] = depot.issueTicket(i);
                slowContents.add(tickets[i]);
            }

            Assert.assertTrue(depot.boardBus(slow, slowContents));

            fast = depot.createBus(1);
            tickets[0] = depot.issueTicket(0);
            Assert.assertTrue(depot.boardBus(fast, Set.of(tickets[0])));
        }

        for (int i = 0 ; i < 10 ; i++) {
            AtomicReference<Thread> firstToFinish = new AtomicReference<>(null);

            // Thread T1 gets all the tickets from slow
            Thread t1 = new Thread(() -> {
                Set<Ticket> contents = depot.getTickets(slow);
                firstToFinish.compareAndExchange(null, Thread.currentThread());
                Assert.assertEquals(slowContents, contents);
            });

            // Thread T2 gets all the tickets from fast
            Thread t2 = new Thread(() -> {
                Set<Ticket> contents = depot.getTickets(fast);
                firstToFinish.compareAndExchange(null, Thread.currentThread());
                Assert.assertEquals(Set.of(tickets[0]), contents);
            });

            runAllThreads(t1, t2);

            // Thread T2 started after T1 but finished first
            Assert.assertEquals(t2, firstToFinish.get());
                
            System.gc();
        }
    }

    @Test
    public void progressUseExpire() {
        for (int lucky = 0 ; lucky < 10 ; lucky++) {
            {
                Depot depot = Depot.createDepot();
                Bus slow, fast;
                Ticket[] tickets = new Ticket[WORK];
                Set<Ticket> slowContents = new HashSet<>();

                // Set up
                {
                    int slowCapacity = tickets.length - 1;
                    slow = depot.createBus(slowCapacity);

                    for (int i = 1; i < slowCapacity; i++) {
                        tickets[i] = depot.issueTicket(i);
                        slowContents.add(tickets[i]);
                    }

                    Assert.assertTrue(depot.boardBus(slow, slowContents));

                    fast = depot.createBus(1);
                    tickets[0] = depot.issueTicket(0);
                    Assert.assertTrue(depot.boardBus(fast, Set.of(tickets[0])));
                }

                AtomicReference<Thread> firstToFinish = new AtomicReference<>(null);

                // Thread T1 uses all the tickets from slow
                Thread t1 = new Thread(() -> {
                    boolean result = depot.useTickets(slow, slowContents);
                    firstToFinish.compareAndExchange(null, Thread.currentThread());
                    Assert.assertTrue(result);
                    Assert.assertEquals(depot.getTickets(slow), Set.of());
                });

                // Thread T2 uses all the tickets from fast
                Thread t2 = new Thread(() -> {
                    boolean result = depot.expireTickets(fast, Set.of(tickets[0]));
                    firstToFinish.compareAndExchange(null, Thread.currentThread());
                    Assert.assertTrue(result);
                    Assert.assertEquals(depot.getTickets(fast), Set.of());
                });

                runAllThreads(t1, t2);

                // Thread T2 started after T1 but finished first
                Assert.assertEquals(t2, firstToFinish.get());

                Assert.assertEquals(Set.of(), depot.getTickets());
            }

            System.gc();
        }
    }

    /*default*/ static void runAllThreads(Thread ... threads) {

        AtomicBoolean exceptionThrown = new AtomicBoolean(false);

        // Uncaught exceptions cause tests to fail
        for (int i = 0 ; i < threads.length ; i++) {
            threads[i].setUncaughtExceptionHandler((t,ex) -> {
                System.err.println(ex.getMessage());
                ex.printStackTrace();
                exceptionThrown.set(true);
            });
        }

        // Start all threads
        for (int i = 0 ; i < threads.length ; i++)
            threads[i].start();

        // Wait for all threads to finish
        for (int i = 0 ; i < threads.length ; i++) {
            while (threads[i].isAlive()) {
                try {
                    threads[i].join();
                } catch (InterruptedException e) {
                    continue;
                }
            }
        }

        // Make sure no thread threw an exception
        Assert.assertFalse(exceptionThrown.get());
    }
}
