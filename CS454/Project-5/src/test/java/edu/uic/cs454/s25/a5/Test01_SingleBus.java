package edu.uic.cs454.s25.a5;

import org.junit.Assert;
import org.junit.Test;

import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Test01_SingleBus {
    @Test
    public void testBusIdentity() {
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
        Bus bus = depot.createBus(size);

        for (int i = 0 ; i < test ; i++) {
            Ticket ticket = depot.issueTicket(i);

            if (i < size)
                Assert.assertTrue(depot.boardBus(bus, Set.of(ticket)));
            else
                Assert.assertFalse(depot.boardBus(bus, Set.of(ticket)));
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
    public void testSetIdentity() {
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

    @Test
    public void testCapacityAdd() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(1);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);


        {
            depot.boardBus(bus, Set.of(ticket1, ticket2));

            Set<Ticket> expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));
        }

        {
            Set<Ticket> toAdd = new HashSet<>();
            toAdd.add(ticket1);
            depot.boardBus(bus, toAdd);
            toAdd.clear();
            toAdd.add(ticket2);
            depot.boardBus(bus, toAdd);

            Set<Ticket> expected = Set.of(ticket1);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));
        }
    }

    @Test
    public void testCapacitySameDescription() {
        int size = 10;
        List<Integer> sequentialIndexes = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList = IntStream.range(0, size).boxed().collect(Collectors.toList());

        Collections.shuffle(shuffledIndexesList);

        testCapacitySameDescription(sequentialIndexes);
        testCapacitySameDescription(shuffledIndexesList);
    }

    @Test
    public void testUsingOwnSet() {
        Depot depot = Depot.createDepot();
        int size = 10;
        Bus bus = depot.createBus(size);
        Ticket[] tickets = new Ticket[size];

        for (int i = 0 ; i < size ; i++) {
            tickets[i] = depot.issueTicket(i);
            Set<Ticket> toAdd = new HashSet<>();
            toAdd.add(tickets[i]);
            depot.boardBus(bus, toAdd);

            Assert.assertNotSame(toAdd, depot.getTickets());
            Assert.assertNotSame(toAdd, depot.getTickets(bus));

            toAdd.clear();

            Set<Ticket> expected = new HashSet<>();
            for (int j = 0 ; j <= i ; j++)
                expected.add(tickets[j]);

            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));

            depot.getTickets().clear();
            depot.getTickets(bus).clear();

            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));
        }
    }

    public void testCapacitySameDescription(List<Integer> indexes) {
        int size = indexes.size();
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(size);
        Ticket[] tickets = new Ticket[size];
        Set<Ticket> toAdd = new HashSet<>();
        Set<Ticket> expected = new HashSet<>();

        for (int i : indexes) {
            tickets[i] = depot.issueTicket(i);
            toAdd.add(tickets[i]);
            expected.add(tickets[i]);
        }

        depot.boardBus(bus, toAdd);

        Assert.assertEquals(size, expected.size());
        Assert.assertEquals(expected, depot.getTickets());
        depot.getTickets().clear();
        Assert.assertEquals(size, expected.size());
        Assert.assertEquals(expected, depot.getTickets());

        Assert.assertEquals(size, depot.getTickets(bus).size());
        Assert.assertEquals(expected, depot.getTickets(bus));
        depot.getTickets(bus).clear();
        Assert.assertEquals(size, depot.getTickets(bus).size());
        Assert.assertEquals(expected, depot.getTickets(bus));
    }

    @Test
    public void testRemoveFromBus() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(2);

        {
            Ticket ticket1 = depot.issueTicket(0);
            Ticket ticket2 = depot.issueTicket(1);

            Set<Ticket> items = Set.of(ticket1, ticket2);
            depot.boardBus(bus, items);
            depot.expireTickets(bus, items);

            Set<Ticket> expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));
        }

        {
            Ticket ticket1 = depot.issueTicket(2);
            Ticket ticket2 = depot.issueTicket(3);

            Set<Ticket> items = new HashSet<>();
            items.add(ticket1);
            depot.boardBus(bus, items);
            items.clear();
            items.add(ticket2);
            depot.boardBus(bus, items);


            items.clear();
            items.add(ticket1);
            depot.useTickets(bus, items);

            Set<Ticket> expected = Set.of(ticket2);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));

            items.clear();
            items.add(ticket2);
            depot.useTickets(bus, items);

            expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));
        }
    }

    @Test
    public void testRemoveFromNowEmptyBus() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);

        {
            Set<Ticket> items = Set.of(ticket1, ticket2);

            depot.expireTickets(bus, items);

            Set<Ticket> expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));
        }

        {
            Set<Ticket> items = new HashSet<>();
            items.add(ticket1);
            items.add(ticket2);

            depot.boardBus(bus, items);

            Set<Ticket> expected = Set.of(ticket1, ticket2);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));

            depot.useTickets(bus, items);
            depot.expireTickets(bus, items);

            expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));

            items.clear();
            items.add(ticket1);
            depot.expireTickets(bus, items);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));

            items.clear();
            items.add(ticket2);
            depot.useTickets(bus, items);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));
        }
    }

    @Test
    public void testRemoveTicketNotInBus() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(1);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);

        {
            Set<Ticket> items = new HashSet<>();
            items.add(ticket1);
            depot.boardBus(bus, Set.of(ticket1));

            items.clear();
            items.add(ticket2);
            depot.useTickets(bus, items);

            Set<Ticket> expected = Set.of(ticket1);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));

            depot.getTickets().clear();
            depot.getTickets(bus).clear();

            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));
        }
    }

}