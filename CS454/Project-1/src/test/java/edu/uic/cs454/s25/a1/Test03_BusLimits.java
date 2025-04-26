package edu.uic.cs454.s25.a1;

import org.junit.Assert;
import org.junit.Test;

import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Test03_BusLimits {

    @Test
    public void testMaxCapacity() {
        Depot depot = Depot.createDepot();
        int test = 20;
        Bus[] buses = new Bus[10];

        for (int i = 0; i < buses.length ; i++)
            buses[i] = depot.createBus(i+1);

        int count = 0;

        for (int i = 0 ; i < test ; i++) {
            for (int j = 0; i < buses.length ; i++) {
                Bus bus = buses[j];
                Ticket ticket = depot.issueTicket(count++);
                Set<Ticket> toAdd = new HashSet<>();
                toAdd.add(ticket);

                if (i <= j)
                    Assert.assertTrue(depot.boardBus(bus, toAdd));
                else
                    Assert.assertFalse(depot.boardBus(bus, toAdd));
            }
        }
    }

    @Test
    public void moveTicketsEmptyBus() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(2);
        Bus bus2 = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);
        Ticket ticket3 = depot.issueTicket(3);
        Ticket ticket4 = depot.issueTicket(4);

        Set<Ticket> toAdd = Set.of(ticket1, ticket2);
        Assert.assertTrue(depot.boardBus(bus1, toAdd));

        Set<Ticket> toMove = Set.of(ticket1, ticket2);
        Assert.assertTrue(depot.transferTickets(bus1, bus2, toMove));
        Assert.assertFalse(depot.expireTickets(bus1, toMove));
        Assert.assertFalse(depot.useTickets(bus1, toMove));

        Set<Ticket> toAddMore = Set.of(ticket3, ticket4);
        Assert.assertTrue(depot.boardBus(bus1, toAddMore));
        Assert.assertTrue(depot.expireTickets(bus2, toMove));
    }

    @Test
    public void testNoRoomInDestination() {
        Depot depot = Depot.createDepot();
        Bus from = depot.createBus(1);
        Bus to = depot.createBus(1);

        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

        depot.boardBus(from, Set.of(ticket1));
        depot.boardBus(to, Set.of(ticket2));

        {
            Set<Ticket> expected = Set.of(ticket1);
            Assert.assertEquals(expected, depot.getTickets(from));
        }

        {
            Set<Ticket> expected = Set.of(ticket2);
            Assert.assertEquals(expected, depot.getTickets(to));
        }

        Assert.assertFalse(depot.transferTickets(from, to, Set.of(ticket1)));

        {
            Set<Ticket> expected = Set.of(ticket1);
            Assert.assertEquals(expected, depot.getTickets(from));
        }

        {
            Set<Ticket> expected = Set.of(ticket2);
            Assert.assertEquals(expected, depot.getTickets(to));
        }

    }

    @Test
    public void testRemoveFromBus() {
        int size = 10;
        List<Integer> sequentialIndexes = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList1 = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList2 = IntStream.range(0, size).boxed().collect(Collectors.toList());

        Collections.shuffle(shuffledIndexesList1);
        Collections.shuffle(shuffledIndexesList2);

        testRemoveFromBus(sequentialIndexes, sequentialIndexes);
        testRemoveFromBus(shuffledIndexesList1, shuffledIndexesList2);
    }

    public void testRemoveFromBus(List<Integer> ticketIndexes, List<Integer> ticketsIndexes) {

        Depot depot = Depot.createDepot();
        int size = ticketIndexes.size();
        Bus[] buses = new Bus[ticketsIndexes.size()];

        for (int i = 0; i < buses.length ; i++)
            buses[i] = depot.createBus(size);

        Ticket[] tickets = new Ticket[size];
        for (int i = 0 ; i < size ; i++)
            tickets[i] = depot.issueTicket(i);

        for (int i : ticketIndexes) {
            Set<Ticket> toAdd = new HashSet<>();
            Bus bus1 = buses[ticketsIndexes.get(i)];
            Bus bus2 = buses[ticketsIndexes.get((i+1)%ticketsIndexes.size())];
            toAdd.add(tickets[i]);
            Assert.assertFalse(depot.expireTickets(bus1, toAdd));
            Assert.assertFalse(depot.useTickets(bus2, toAdd));

            Assert.assertTrue(depot.boardBus(bus1, toAdd));

            Assert.assertFalse(depot.expireTickets(bus2, toAdd));
            Assert.assertFalse(depot.useTickets(bus2, toAdd));

            switch (i%2) {
                case 0:
                    Assert.assertTrue(depot.useTickets(bus1, toAdd));
                    break;
                case 1:
                    Assert.assertTrue(depot.expireTickets(bus1, toAdd));
                    break;
                default:
                    throw new Error("Dead code");
            }
        }
    }

    @Test
    public void testRemoveFromEmptyBus() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(2);
        Bus bus2 = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

        {
            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            tickets.add(ticket2);

            Assert.assertFalse(depot.expireTickets(bus1, tickets));
            Assert.assertFalse(depot.useTickets(bus1, tickets));
            Assert.assertFalse(depot.expireTickets(bus2, tickets));
            Assert.assertFalse(depot.useTickets(bus2, tickets));
        }

        {
            Assert.assertTrue(depot.boardBus(bus1, Set.of(ticket1)));
            Assert.assertTrue(depot.boardBus(bus2, Set.of(ticket2)));
            Assert.assertTrue(depot.expireTickets(bus1, Set.of(ticket1)));
            Assert.assertTrue(depot.useTickets(bus2, Set.of(ticket2)));

            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            tickets.add(ticket2);

            Assert.assertFalse(depot.expireTickets(bus1, tickets));
            Assert.assertFalse(depot.useTickets(bus1, tickets));
            Assert.assertFalse(depot.expireTickets(bus2, tickets));
            Assert.assertFalse(depot.useTickets(bus2, tickets));

            tickets.clear();
            tickets.add(ticket1);
            Assert.assertFalse(depot.expireTickets(bus1, tickets));
            Assert.assertFalse(depot.useTickets(bus1, tickets));
            Assert.assertFalse(depot.expireTickets(bus2, tickets));
            Assert.assertFalse(depot.useTickets(bus2, tickets));

            tickets.clear();
            tickets.add(ticket2);
            Assert.assertFalse(depot.expireTickets(bus1, tickets));
            Assert.assertFalse(depot.useTickets(bus1, tickets));
            Assert.assertFalse(depot.expireTickets(bus2, tickets));
            Assert.assertFalse(depot.useTickets(bus2, tickets));
        }
    }

    @Test
    public void moveTicketToFullBus() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(2);
        Bus bus2 = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);
        Ticket ticket3 = depot.issueTicket(3);
        Ticket ticket4 = depot.issueTicket(4);

        Set<Ticket> toAdd = Set.of(ticket1, ticket2);
        Assert.assertTrue(depot.boardBus(bus1, toAdd));

        Set<Ticket> toAddMore = Set.of(ticket3, ticket4);
        Assert.assertTrue(depot.boardBus(bus2, toAddMore));

        Set<Ticket> toMove = Set.of(ticket1, ticket2);
        Assert.assertFalse(depot.transferTickets(bus1, bus2, toMove));


        Assert.assertTrue(depot.expireTickets(bus2, Set.of(ticket4)));
        Assert.assertFalse(depot.transferTickets(bus1, bus2, toMove));
        Assert.assertTrue(depot.transferTickets(bus1, bus2, Set.of(ticket1)));
    }
}