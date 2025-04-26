package edu.uic.cs454.s25.a1;

import org.junit.Assert;
import org.junit.Test;

import java.util.HashSet;
import java.util.Optional;
import java.util.Random;
import java.util.Set;

public class Test07_MultithreadedMove {
    @Test
    public void testMove() {
        int n = 5;
        Depot depot = Depot.createDepot();

        Thread[] threads = new Thread[8];

        Bus[] buses = new Bus[10];
        int size = 2 * n;

        Ticket[] tickets = new Ticket[buses.length * n];

        for (int i = 0; i < buses.length ; i++) {
            buses[i] = depot.createBus(size);
            for (int j = 0 ; j < n ; j++) {
                int ticketNo = i * n + j;
                Ticket ticket = depot.issueTicket(ticketNo);
                tickets[ticketNo] = ticket;
                depot.boardBus(buses[i], Set.of(ticket));
            }
        }

        for (int i = 0 ; i < threads.length ; i++) {
            threads[i] = new Thread(() -> {
                Random r = new Random();
                for (int j = 0 ; j < 10_000 ; j++) {
                    int from = r.nextInt(buses.length);
                    int to   = r.nextInt(buses.length);
                    Optional<Ticket> ticketsToMove = depot.getTickets(buses[from]).stream().findAny();
                    if (ticketsToMove.isPresent())
                        depot.transferTickets(buses[from], buses[to], Set.of(ticketsToMove.get()));
                }
            });
        }


        Set<Ticket> expectedAllTickets = new HashSet<>(Set.of(tickets));
        Assert.assertEquals(expectedAllTickets, depot.getTickets());

        Test06_MultithreadedAddRemove.runAllThreads(threads);

        // Everything that was in the depot is still there
        Assert.assertEquals(expectedAllTickets, depot.getTickets());

        for (Bus s : buses) {
            for (Object i : depot.getTickets(s)) {
                // Each ticket is in only one bus
                Assert.assertTrue(expectedAllTickets.remove(i));
            }
        }

        // The contents of all tickets are everything that las in the depot
        Assert.assertTrue(expectedAllTickets.isEmpty());
    }
}