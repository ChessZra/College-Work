package edu.uic.cs454.s25.a4;

import org.junit.Assert;
import org.junit.Test;

import java.util.HashSet;
import java.util.Optional;
import java.util.Random;
import java.util.Set;
import java.util.concurrent.atomic.AtomicBoolean;

public class Test05_MultipleClientThreads {

    @Test
    public void testAdd() {
        Depot depot = Depot.createDepot();

        Bus[] buses = new Bus[10];
        int size = 1_000;

        for (int i = 0; i < buses.length ; i++) {
            buses[i] = depot.createBus(size);
        }

        Thread[] threads = new Thread[10];
        Set<Ticket>[] allTickets = new Set[threads.length];

        for (int i = 0 ; i < threads.length ; i++) {
            int threadID = i;
            allTickets[i] = new HashSet<>();
            threads[i] = new Thread(() -> {
                Random rnd = new Random();
                for (int j = 0 ; j < size ; j++) {
                    Ticket ticket = depot.issueTicket(threadID*size + j);
                    Set<Ticket> tickets = Set.of(ticket);
                    allTickets[threadID].add(ticket);
                    while (true) {
                        // Pick a bus at random
                        Bus bus = buses[rnd.nextInt(buses.length)];
                        // Bus is full or add failed
                        if (depot.getTickets(bus).size() == size || !depot.boardBus(bus, tickets)) {
                            // Try again on another bus
                            bus.allowedThread.interrupt();
                            continue;
                        }
                        break;
                    }
                }
            });
        }

        AtomicBoolean exceptionThrown = startAllThreads(threads);

        for (Bus c : buses) {
            c.startThread();
        }

        joinAllThreads(threads);
        Assert.assertFalse(exceptionThrown.get());

        Assert.assertEquals(size* buses.length, depot.getTickets().size());

        Set<Ticket> expectedAllTickets = new HashSet<>();
        for (int i = 0 ; i < threads.length ; i++)
            expectedAllTickets.addAll(allTickets[i]);

        Assert.assertEquals(expectedAllTickets, depot.getTickets());

        Set<Ticket> ticketsOnBuses = new HashSet<>();
        for (int i = 0; i < buses.length ; i++)
            ticketsOnBuses.addAll(depot.getTickets(buses[i]));

        Assert.assertEquals(expectedAllTickets, ticketsOnBuses);

        Set<Ticket> contents = new HashSet<>();
        for (Bus c : buses) {
            c.stopThread();

            Assert.assertFalse(c.didThrowException());
            contents.addAll(c.getContents());
        }

        Assert.assertEquals(expectedAllTickets, contents);
    }

    // Each thread (out of 10 threads) removes 100 tickets from blockchain with 1000 tickets
    @Test
    public void testRemove() {
        Depot depot = Depot.createDepot();

        Bus[] buses = new Bus[10];
        int size = 100;

        for (int i = 0; i < buses.length ; i++) {
            buses[i] = depot.createBus(size);
            Set<Ticket> tickets = new HashSet<>();
            for (int j = 0 ; j < size ; j++) {
                Ticket ticket = depot.issueTicket(i*size + j);
                tickets.add(ticket);
            }
            depot.boardBusAsync(buses[i], tickets);
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
                    Bus bus = buses[rnd.nextInt(buses.length)];
                    // Get any ticket
                    Optional<Ticket> ticket = depot.getTickets(bus).stream().findAny();
                    if (!ticket.isPresent()) {
                        bus.allowedThread.interrupt();
                        continue;
                    }

                    boolean result;
                    if (removed%2 == 0)
                        result = depot.useTickets(bus, Set.of(ticket.get()));
                    else
                        result = depot.expireTickets(bus, Set.of(ticket.get()));

                    if (result)
                        removed++;
                }
            });
        }

        AtomicBoolean exceptionThrown = startAllThreads(threads);

        for (Bus c : buses)
            c.startThread();

        joinAllThreads(threads);
        Assert.assertFalse(exceptionThrown.get());

        Assert.assertEquals(0, depot.getTickets().size());
        Assert.assertEquals(Set.of(), depot.getTickets());

        for (int i = 0; i < buses.length ; i++)
            Assert.assertEquals(Set.of(), depot.getTickets(buses[i]));

        for (Bus c : buses) {
            c.stopThread();
            Assert.assertFalse(c.didThrowException());
            Assert.assertEquals(Set.of(), c.getContents());
        }

    }

    /*default*/ static AtomicBoolean startAllThreads(Thread[] threads) {

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

        return exceptionThrown;
    }

    /*default*/ static void joinAllThreads(Thread[] threads) {

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
    }
}
