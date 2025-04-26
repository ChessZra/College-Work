package edu.uic.cs454.s25.a3;

import org.junit.Assert;
import org.junit.Test;

import java.util.*;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicReference;

public class Test05_Get {
    @Test
    public void progressGetBus() {
        Depot depot = Depot.createDepot();
        Bus slow, fast;
        Ticket[] tickets = new Ticket[Test03_Progress.WORK];
        Set<Ticket> everything = new HashSet<>();

        // Set up
        {
            int slowCapacity = tickets.length - 1;
            slow = depot.createBus(slowCapacity);

            for (int i = 1 ; i < slowCapacity ; i++) {
                tickets[i] = depot.issueTicket(i);
                everything.add(tickets[i]);
            }

            Assert.assertTrue(depot.boardBus(slow, everything));

            fast = depot.createBus(1);
            tickets[0] = depot.issueTicket(0);
            Assert.assertTrue(depot.boardBus(fast, Set.of(tickets[0])));
            everything.add(tickets[0]);
        }


        for (int i = 0 ; i < 10 ; i++) {
            AtomicReference<Thread> firstToFinish = new AtomicReference<>(null);

            // Thread T1 gets all the tickets
            Thread t1 = new Thread(() -> {
                Set<Ticket> contents = depot.getTickets();
                firstToFinish.compareAndExchange(null, Thread.currentThread());
                Assert.assertEquals(everything, contents);
            });

            // Thread T2 gets all the tickets from fast
            Thread t2 = new Thread(() -> {
                Set<Ticket> contents = depot.getTickets(fast);
                firstToFinish.compareAndExchange(null, Thread.currentThread());
                Assert.assertEquals(Set.of(tickets[0]), contents);
            });

            Test03_Progress.runAllThreads(t1, t2);

            // Thread T2 started after T1 but finished first
            Assert.assertEquals(t2, firstToFinish.get());

            System.gc();
        }
    }
    @Test
    public void testSafeGet() {
        Depot depot = Depot.createDepot();
        Ticket[] tickets = new Ticket[10_000];
        Bus bus1 = depot.createBus(tickets.length/2);
        Bus bus2 = depot.createBus(tickets.length/2);
        Set<Ticket> allTickets = new HashSet<>();

        // Set up
        {
            for (int i = 0 ; i < tickets.length/2 ; i++) {
                tickets[i] = depot.issueTicket(i);

                depot.boardBus(bus1, Set.of(tickets[i]));
                allTickets.add(tickets[i]);
            }

            for (int i = tickets.length/2 ; i < tickets.length ; i++) {
                tickets[i] = depot.issueTicket(i);

                depot.boardBus(bus2, Set.of(tickets[i]));
                allTickets.add(tickets[i]);
            }
        }

        Thread t1 = new Thread(() -> {
            for (int i = 0 ; i < 100 ; i++)
                Assert.assertEquals(allTickets, depot.getTickets(List.of(bus1,bus2)));
        });

        Thread t2 = new Thread(() -> {
            for (int i = 0 ; i < 100 ; i++)
                Assert.assertEquals(allTickets, depot.getTickets(List.of(bus2,bus1)));
        });

        Thread t3 = new Thread(() -> {
            for (int i = 0 ; i < 100 ; i++)
                Assert.assertEquals(allTickets, depot.getTickets());
        });

        Test03_Progress.runAllThreads(t1, t2, t3);
    }

    @Test
    public void testGetIsLinearizabile() {
        Depot depot = Depot.createDepot();
        Bus[] buses = new Bus[10_000];
        Ticket[] tickets = new Ticket[buses.length];
        Set<Ticket> allTickets = new HashSet<>();

        // Set up
        {
            for (int i = 0 ; i < buses.length ; i++) {
                buses[i] = depot.createBus(buses.length);
                tickets[i] = depot.issueTicket(i);
                allTickets.add(tickets[i]);

                Assert.assertTrue(depot.boardBus(buses[i], Set.of(tickets[i])));
            }
        }

        AtomicBoolean done = new AtomicBoolean(false);

        // Thread 1, move
        Thread t1 = new Thread(() -> {
            for (int i = buses.length - 1 ; i > 0 ; i--) {
                Set<Ticket> s = Set.of(tickets[i]);
                Assert.assertTrue(depot.transferTickets(buses[i], buses[(i-1)], s));
            }

            done.set(true);
        });

        // Thread 2 ensures it always sees all tickets while Thread 1 moves tickets
        Thread t2 = new Thread(() -> {
            while (!done.get()) {
                Assert.assertEquals(allTickets, depot.getTickets());
            }
        });

        Test03_Progress.runAllThreads(t2, t1);

        // No coins were lost
        Assert.assertEquals(Set.of(tickets), depot.getTickets(Arrays.asList(buses)));
    }

    @Test
    public void testProgress() {
        new Test03_Progress().progressGetOneBus();
        new Test03_Progress().progressUseExpire();
    }

}
