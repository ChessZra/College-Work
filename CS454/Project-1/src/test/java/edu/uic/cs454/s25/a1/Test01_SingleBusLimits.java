package edu.uic.cs454.s25.a1;

import org.junit.Assert;
import org.junit.Test;

import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Test01_SingleBusLimits {
    @Test
    public void testIdentity() {
        Depot depot = Depot.createDepot();

        int size = 10;
        Ticket[] tickets = new Ticket[size];

        Set<Ticket> toAdd = new HashSet<>();
        for (int i = 0 ; i < size ; i++) {
            tickets[i] = depot.issueTicket(i);
            toAdd.add(tickets[i]);
        }

        Assert.assertEquals(size, toAdd.size());
        Assert.assertEquals(toAdd, Set.of(tickets));
    }

    @Test
    public void testMaxCapacity() {
        Depot depot = Depot.createDepot();
        int size = 10;
        int test = 20;
        Bus c = depot.createBus(size);

        for (int i = 0 ; i < test ; i++) {
            Ticket v = depot.issueTicket(i);

            if (i < size)
                Assert.assertTrue(depot.boardBus(c, Set.of(v)));
            else
                Assert.assertFalse(depot.boardBus(c, Set.of(v)));
        }
    }

    @Test
    public void testTickets() {
        int size = 10;
        List<Integer> sequentialIndexes = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList = IntStream.range(0, size).boxed().collect(Collectors.toList());

        Collections.shuffle(shuffledIndexesList);

        testRemoveTickets(sequentialIndexes);
        testRemoveTickets(shuffledIndexesList);
    }

    public void testRemoveTickets(List<Integer> indexes) {

        Depot depot = Depot.createDepot();
        int size = indexes.size();
        Bus bus = depot.createBus(size);

        Ticket[] tickets = new Ticket[size];
        for (int i = 0 ; i < size ; i++) {
            tickets[i] = depot.issueTicket(i);
        }

        for (int i : indexes) {
            Set<Ticket> toAdd = new HashSet<>();
            toAdd.add(tickets[i]);
            Assert.assertTrue(depot.boardBus(bus, toAdd));
            switch (i%2) {
                case 0:
                    Assert.assertTrue(depot.expireTickets(bus, toAdd));
                    break;
                case 1:
                    Assert.assertTrue(depot.useTickets(bus, toAdd));
                    break;
                default:
                    throw new Error("Dead code");
            }
        }

        {
            for (int i = 0 ; i < size ; i++) {
                tickets[i] = depot.issueTicket(size+i);
            }

            Set<Ticket> toAdd = new HashSet<>();
            for (int i : indexes) {
                toAdd.add(tickets[i]);
            }

            Assert.assertTrue(depot.boardBus(bus, toAdd));
            Assert.assertTrue(depot.expireTickets(bus, toAdd));
        }

        {
            for (int i = 0 ; i < size ; i++) {
                tickets[i] = depot.issueTicket((size*2)+i);
            }

            Set<Ticket> toAdd = new HashSet<>();
            for (int i : indexes) {
                toAdd.add(tickets[i]);
            }

            Assert.assertTrue(depot.boardBus(bus, toAdd));
            Assert.assertTrue(depot.useTickets(bus, toAdd));
        }
    }

    @Test
    public void testRemoveFromEmptyBus() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);

        {
            Assert.assertFalse(depot.expireTickets(bus, Set.of(ticket1)));
            Assert.assertFalse(depot.expireTickets(bus, Set.of(ticket2)));
            Assert.assertFalse(depot.expireTickets(bus, Set.of(ticket1, ticket2)));

            Assert.assertFalse(depot.useTickets(bus, Set.of(ticket1)));
            Assert.assertFalse(depot.useTickets(bus, Set.of(ticket2)));
            Assert.assertFalse(depot.useTickets(bus, Set.of(ticket1, ticket2)));
        }
    }

    @Test
    public void testSet() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);

        Set<Ticket> tickets = new HashSet<>();
        tickets.add(ticket1);
        tickets.add(ticket2);

        {
            Assert.assertTrue(depot.boardBus(bus, tickets));
            Assert.assertTrue(depot.expireTickets(bus, tickets));
            Assert.assertFalse(depot.expireTickets(bus, tickets));
            Assert.assertFalse(depot.useTickets(bus, tickets));
        }

        {
            tickets.clear();
            tickets.add(ticket1);
            Assert.assertFalse(depot.useTickets(bus, tickets));
            Assert.assertFalse(depot.expireTickets(bus, tickets));
        }

        {
            tickets.clear();
            tickets.add(ticket2);
            Assert.assertFalse(depot.useTickets(bus, tickets));
            Assert.assertFalse(depot.expireTickets(bus, tickets));
        }
    }

    @Test
    public void testRemoveTicketsNotInBus() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(1);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);

        {
            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            Assert.assertTrue(depot.boardBus(bus, tickets));

            tickets.clear();
            tickets.add(ticket2);
            Assert.assertFalse(depot.useTickets(bus, tickets));
            Assert.assertFalse(depot.expireTickets(bus, tickets));
        }
    }
}