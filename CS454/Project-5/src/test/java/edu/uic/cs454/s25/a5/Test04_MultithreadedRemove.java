package edu.uic.cs454.s25.a5;

import org.junit.Assert;
import org.junit.Test;

import java.util.HashSet;
import java.util.Optional;
import java.util.Random;
import java.util.Set;

public class Test04_MultithreadedRemove {

    // Each thread (out of 10 threads) removes 100 tickets from depot with 1000 tickets
    @Test
    public void testRemove() {
        Depot depot = Depot.createDepot();

        Bus[] buses = new Bus[10];
        int size = 2_000;

        for (int i = 0; i < buses.length ; i++) {
            buses[i] = depot.createBus(size);
            Set<Ticket> tickets = new HashSet<>();
            for (int j = 0 ; j < size ; j++) {
                Ticket ticket = depot.issueTicket(i*size + j);
                tickets.add(ticket);
            }
            depot.boardBus(buses[i], tickets);
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
                        result = depot.useTickets(s, Set.of(tickets.get()));

                    if (result)
                        removed++;
                }
            });
        }

        Test03_MultithreadedAdd.runAllThreads(threads);

        Assert.assertEquals(0, depot.getTickets().size());
        Assert.assertEquals(Set.of(), depot.getTickets());

        for (int i = 0; i < buses.length ; i++)
            Assert.assertEquals(Set.of(), depot.getTickets(buses[i]));

    }
}