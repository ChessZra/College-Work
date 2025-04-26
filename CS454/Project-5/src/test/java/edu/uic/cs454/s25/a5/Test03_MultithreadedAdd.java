package edu.uic.cs454.s25.a5;

import org.junit.Assert;
import org.junit.Test;

import java.util.HashSet;
import java.util.Random;
import java.util.Set;
import java.util.concurrent.atomic.AtomicBoolean;

public class Test03_MultithreadedAdd {

    // Each thread adds 100 tickets, final depot should have 1000 tickets
    @Test
    public void testAdd() {
        Depot depot = Depot.createDepot();

        Bus[] buses = new Bus[10];
        int size = 5_000;

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
                    Set<Ticket> ticketsses = Set.of(tickets);
                    allTickets[threadID].add(tickets);
                    while (true) {
                        // Pick a bus at random
                        Bus c = buses[rnd.nextInt(buses.length)];
                        // Bus is full or add failed
                        if (depot.getTickets(c).size() == size || !depot.boardBus(c, ticketsses))
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