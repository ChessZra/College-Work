package edu.uic.cs454.s25.a1;

import org.junit.Assert;
import org.junit.Test;

import java.util.HashSet;
import java.util.Optional;
import java.util.Random;
import java.util.Set;
import java.util.concurrent.atomic.AtomicBoolean;

public class Test06_MultithreadedAddRemove {

    // Each thread adds 100 tickets, final depot should have 1000 tickets

    @Test
    public void testAdd() {
        Depot depot = Depot.createDepot();

        Bus[] buses = new Bus[10];
        int size = 100;
        
        for (int i = 0; i < buses.length ; i++)
            buses[i] = depot.createBus(size);

        Thread[] threads = new Thread[10];
        Set<Ticket>[] allTickets = new Set[threads.length];

        for (int i = 0 ; i < threads.length ; i++) {
            int threadID = i;
            allTickets[i] = new HashSet<>();
            threads[i] = new Thread(() -> {
                Random rnd = new Random();
                for (int j = 0 ; j < size ; j++) {
                    Ticket tickets = depot.issueTicket(threadID*size + j);
                    Set<Ticket> ticketss = Set.of(tickets);
                    allTickets[threadID].add(tickets);
                    while (true) {
                        // Pick a bus at random
                        Bus bus = buses[rnd.nextInt(buses.length)];
                        // Bus is full or add failed
                        if (depot.getTickets(bus).size() == size || !depot.boardBus(bus, ticketss))
                            // Try again on another bus
                            continue;
                        break;
                    }
                }
            });
        }

        runAllThreads(threads);

        Assert.assertEquals(size* buses.length, depot.getTickets().size());

        Set<Ticket> expectedAllTickets = new HashSet<>();
        for (int i = 0 ; i < threads.length ; i++)
            expectedAllTickets.addAll(allTickets[i]);

        Assert.assertEquals(expectedAllTickets, depot.getTickets());

        Set<Ticket> ticketsOnBuses = new HashSet<>();
        for (int i = 0; i < buses.length ; i++)
            ticketsOnBuses.addAll(depot.getTickets(buses[i]));

        Assert.assertEquals(expectedAllTickets, ticketsOnBuses);
    }

    // Each thread (out of 10 threads) removes 100 tickets from depot with 1000 tickets
    @Test
    public void testRemove() {
        Depot depot = Depot.createDepot();

        Bus[] buses = new Bus[10];
        int size = 100;

        for (int i = 0; i < buses.length ; i++) {
            buses[i] = depot.createBus(size);
            Set<Ticket> ticketss = new HashSet<>();
            for (int j = 0 ; j < size ; j++) {
                Ticket tickets = depot.issueTicket(i*size + j);
                ticketss.add(tickets);
            }
            depot.boardBus(buses[i], ticketss);
        }

        Thread[] threads = new Thread[10];
        Set<Ticket>[] allTickets = new Set[threads.length];

        for (int i = 0 ; i < threads.length ; i++) {
            int threadID = i;
            allTickets[i] = new HashSet<>();
            threads[i] = new Thread(() -> {
                Random rnd = new Random();
                int removed = 0;
                while (removed < size) {
                    Bus s = buses[rnd.nextInt(buses.length)];
                    // Get any tickets
                    Optional<Ticket> tickets = depot.getTickets(s).stream().findAny();
                    if (!tickets.isPresent())
                        continue;

                    boolean result;
                    if (removed%2 == 0)
                        result = depot.useTickets(s, Set.of(tickets.get()));
                    else
                        result = depot.expireTickets(s, Set.of(tickets.get()));

                    if (result)
                        removed++;
                }
            });
        }

        Test06_MultithreadedAddRemove.runAllThreads(threads);

        Assert.assertEquals(0, depot.getTickets().size());
        Assert.assertEquals(Set.of(), depot.getTickets());

        for (int i = 0; i < buses.length ; i++)
            Assert.assertEquals(Set.of(), depot.getTickets(buses[i]));

    }

    /*default*/ static void runAllThreads(Thread[] threads) {

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
