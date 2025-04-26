package edu.uic.cs454.s25.a1;

import org.junit.Assert;
import org.junit.Test;

import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Test04_BusesContents {
    @Test
    public void moveTicketFromEmptyBus() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(10);
        Bus bus2 = depot.createBus(10);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);
        Ticket ticket3 = depot.issueTicket(3);
        Ticket ticket4 = depot.issueTicket(4);

        Set<Ticket> toAdd = Set.of(ticket1, ticket2);
        Assert.assertTrue(depot.boardBus(bus1, toAdd));

        Set<Ticket> toMove = Set.of(ticket3, ticket4);
        Assert.assertFalse(depot.transferTickets(bus2, bus1, toMove));
    }

    @Test
    public void testCapacityDuplicatedTicket() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(10);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);

        {
            depot.boardBus(bus, Set.of(ticket1));
            depot.boardBus(bus, Set.of(ticket1));

            Set<Ticket> expected = Set.of(ticket1);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));
        }

        {
            depot.boardBus(bus, Set.of(ticket1, ticket2));

            Set<Ticket> expected = Set.of(ticket1);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));
        }

        {
            depot.boardBus(bus, Set.of(ticket2));
            depot.boardBus(bus, Set.of(ticket2));

            Set<Ticket> expected = Set.of(ticket1, ticket2);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));
        }
    }

    @Test
    public void testTicketAlreadyInBus() {
        int size = 10;
        List<Integer> sequentialIndexes = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList = IntStream.range(0, size).boxed().collect(Collectors.toList());

        Collections.shuffle(shuffledIndexesList);

        testTicketAlreadyInBus(sequentialIndexes);
        testTicketAlreadyInBus(shuffledIndexesList);
    }

    private void testTicketAlreadyInBus(List<Integer> indexes) {
        int size = indexes.size();
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(size);

        Ticket[] tickets = new Ticket[size];
        for (int i = 0 ; i < size ; i++) {
            tickets[i] = depot.issueTicket(i);
        }

        for (int i : indexes) {
            {
                Set<Ticket> toAdd = new HashSet<>();
                toAdd.add(tickets[i]);
                Assert.assertTrue(depot.boardBus(bus, toAdd));
                Assert.assertFalse(depot.boardBus(bus, toAdd));
                Assert.assertFalse(depot.boardBus(bus, Set.of(tickets[i])));
            }

            if (i > 0) {
                Set<Ticket> toAdd = new HashSet<>();
                toAdd.add(tickets[i]);
                toAdd.add(tickets[i-1]);
                Assert.assertFalse(depot.boardBus(bus, toAdd));
                Assert.assertFalse(depot.boardBus(bus, Set.of(tickets[i], tickets[i-1])));
            }

            {
                Set<Ticket> toAdd = new HashSet<>();
                toAdd.add(tickets[i]);
                Ticket anotherTicket = depot.issueTicket(size+i);
                toAdd.add(anotherTicket);
                Assert.assertFalse(depot.boardBus(bus, toAdd));
                Assert.assertFalse(depot.boardBus(bus, Set.of(tickets[i], anotherTicket)));
            }
        }
    }

    @Test
    public void testCannotReuseTickets() {
        int size = 10;
        List<Integer> sequentialIndexes = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList = IntStream.range(0, size).boxed().collect(Collectors.toList());

        Collections.shuffle(shuffledIndexesList);

        testCannotReuseTickets(sequentialIndexes);
        testCannotReuseTickets(shuffledIndexesList);
    }

    public void testCannotReuseTickets(List<Integer> indexes) {
        Depot depot = Depot.createDepot();
        int size = indexes.size();
        Bus bus = depot.createBus(size);

        Ticket[] tickets = new Ticket[size];
        for (int i = 0 ; i < size ; i++) {
            tickets[i] = depot.issueTicket(i);
            Set<Ticket> toAdd = new HashSet<>();
            toAdd.add(tickets[i]);
            Assert.assertTrue(depot.boardBus(bus, toAdd));
        }

        for (int i : indexes) {
            Set<Ticket> ticketsSet = Set.of(tickets[i]);
            switch (i%2) {
                case 0:
                    Assert.assertTrue(depot.expireTickets(bus, ticketsSet));
                    break;
                case 1:
                    Assert.assertTrue(depot.useTickets(bus, ticketsSet));
                    break;
                default:
                    throw new Error("Dead code");
            }

            Assert.assertFalse(depot.boardBus(bus, ticketsSet));
            Assert.assertFalse(depot.expireTickets(bus, ticketsSet));
        }
    }

    @Test
    public void testTicketAlreadyInDepot() {
        int size = 10;
        List<Integer> sequentialIndexes = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList1 = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList2 = IntStream.range(0, size).boxed().collect(Collectors.toList());

        Collections.shuffle(shuffledIndexesList1);
        Collections.shuffle(shuffledIndexesList2);

        testTicketAlreadyInDepot(sequentialIndexes, sequentialIndexes);
        testTicketAlreadyInDepot(shuffledIndexesList1, shuffledIndexesList2);
    }

    private void testTicketAlreadyInDepot(List<Integer> ticketsIndexes, List<Integer> busesIndexes) {
        int size = ticketsIndexes.size();
        Depot depot = Depot.createDepot();
        Bus[] buses = new Bus[size];

        for (int i = 0 ; i < size ; i++)
            buses[i] = depot.createBus(size);

        int count = 0;

        Ticket[] tickets = new Ticket[size];
        for (int i = 0 ; i < size ; i++) {
            tickets[i] = depot.issueTicket(count++);
        }


        for (int i : ticketsIndexes) {
            Bus bus1  = buses[busesIndexes.get(i)];
            Bus bus2 = buses[busesIndexes.get((i+1)%size)];

            {
                Set<Ticket> toAdd = new HashSet<>();
                toAdd.add(tickets[i]);
                Assert.assertTrue(depot.boardBus(bus1, toAdd));
                Assert.assertFalse(depot.boardBus(bus1, toAdd));
                Assert.assertFalse(depot.boardBus(bus1, Set.of(tickets[i])));

                Assert.assertFalse(depot.boardBus(bus2, toAdd));
                Assert.assertFalse(depot.boardBus(bus2, Set.of(tickets[i])));
            }

            if (i > 0) {
                Set<Ticket> toAdd = new HashSet<>();
                toAdd.add(tickets[i]);
                toAdd.add(tickets[i-1]);
                Assert.assertFalse(depot.boardBus(bus1, toAdd));
                Assert.assertFalse(depot.boardBus(bus1, Set.of(tickets[i], tickets[i-1])));
            }


            {
                Set<Ticket> toAdd = new HashSet<>();
                toAdd.add(tickets[i]);
                Ticket anotherTicket = depot.issueTicket(count++);
                toAdd.add(anotherTicket);
                Assert.assertFalse(depot.boardBus(bus1, toAdd));
                Assert.assertFalse(depot.boardBus(bus1, Set.of(tickets[i], anotherTicket)));

                Assert.assertFalse(depot.boardBus(bus2, toAdd));
                Assert.assertFalse(depot.boardBus(bus2, Set.of(tickets[i])));
            }
        }
    }



    @Test
    public void testCapacityAdd() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(1);
        Bus bus2 = depot.createBus(10);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

        {
            Set<Ticket> toAdd = Set.of(ticket1,ticket2);
            depot.boardBus(bus1, toAdd);

            Set<Ticket> expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus1));
            Assert.assertEquals(expected, depot.getTickets(bus2));
        }

        {
            Set<Ticket> toAdd = new HashSet<>();
            toAdd.add(ticket1);
            depot.boardBus(bus1, toAdd);
            toAdd.clear();
            toAdd.add(ticket2);
            depot.boardBus(bus1, toAdd);

            Set<Ticket> expected = Set.of(ticket1);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus1));
            Assert.assertEquals(Set.of(), depot.getTickets(bus2));
        }
    }

    @Test
    public void testCapacityDuplicatedTickets() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(10);
        Bus bus2 = depot.createBus(10);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

        {
            Set<Ticket> toAdd = new HashSet<>();
            toAdd.add(ticket1);
            depot.boardBus(bus1, toAdd);
            depot.boardBus(bus2, toAdd);

            Set<Ticket> expected = Set.of(ticket1);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus1));
            Assert.assertEquals(Set.of(), depot.getTickets(bus2));
        }

        {
            Set<Ticket> toAdd = Set.of(ticket2);
            depot.boardBus(bus2, toAdd);

            Set<Ticket> expected = Set.of(ticket1);
            Assert.assertEquals(expected, depot.getTickets(bus1));

            expected = Set.of(ticket2);
            Assert.assertEquals(expected, depot.getTickets(bus2));

            expected = Set.of(ticket1, ticket2);
            Assert.assertEquals(expected, depot.getTickets());
        }

        {
            Set<Ticket> toAdd = Set.of(ticket2);
            depot.boardBus(bus1, toAdd);
            depot.boardBus(bus2, toAdd);

            Set<Ticket> expected = Set.of(ticket1);
            Assert.assertEquals(expected, depot.getTickets(bus1));

            expected = Set.of(ticket2);
            Assert.assertEquals(expected, depot.getTickets(bus2));

            expected = Set.of(ticket1, ticket2);
            Assert.assertEquals(expected, depot.getTickets());
        }
    }

    @Test
    public void testRemoveFromBus() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(2);
        Bus bus2 = depot.createBus(2);

        int count = 0;

        {
            Ticket ticket1 = depot.issueTicket(count++);
            Ticket ticket2 = depot.issueTicket(count++);

            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            tickets.add(ticket2);
            depot.boardBus(bus1, tickets);
            depot.useTickets(bus2, tickets);
            depot.useTickets(bus1, tickets);

            Set<Ticket> expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus1));
            Assert.assertEquals(expected, depot.getTickets(bus2));
        }

        {
            Ticket ticket1 = depot.issueTicket(count++);
            Ticket ticket2 = depot.issueTicket(count++);
            Ticket ticket3 = depot.issueTicket(count++);

            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            tickets.add(ticket3);
            depot.boardBus(bus1, tickets);
            tickets.clear();
            tickets.add(ticket2);
            depot.boardBus(bus2, tickets);


            tickets.clear();
            tickets.add(ticket1);
            depot.useTickets(bus1, tickets);
            depot.boardBus(bus2, tickets);
            depot.boardBus(bus1, tickets);

            Set<Ticket> expected = Set.of(ticket2, ticket3);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(Set.of(ticket2), depot.getTickets(bus2));
            Assert.assertEquals(Set.of(ticket3), depot.getTickets(bus1));

            tickets.clear();
            tickets.add(ticket2);
            depot.expireTickets(bus2, tickets);

            expected = Set.of(ticket3);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus1));
            Assert.assertEquals(Set.of(), depot.getTickets(bus2));
        }
    }

    @Test
    public void testRemoveFromEmptyBus() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(2);
        Bus bus2 = depot.createBus(2);

        int count = 0;

        {
            Ticket ticket1 = depot.issueTicket(count++);
            Ticket ticket2 = depot.issueTicket(count++);

            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            tickets.add(ticket2);

            depot.useTickets(bus1, tickets);
            depot.useTickets(bus2, tickets);

            Set<Ticket> expected = new HashSet<>();
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus1));
            Assert.assertEquals(expected, depot.getTickets(bus2));
        }

        {
            Ticket ticket1 = depot.issueTicket(count++);
            Ticket ticket2 = depot.issueTicket(count++);

            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            tickets.add(ticket2);

            depot.boardBus(bus1, tickets);
            depot.useTickets(bus1, tickets);
            depot.useTickets(bus2, tickets);

            Set<Ticket> expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus1));
            Assert.assertEquals(expected, depot.getTickets(bus2));

            tickets.clear();
            tickets.add(ticket1);
            depot.expireTickets(bus1, tickets);
            depot.expireTickets(bus2, tickets);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus1));
            Assert.assertEquals(expected, depot.getTickets(bus2));

            tickets.clear();
            tickets.add(ticket2);
            depot.expireTickets(bus1, tickets);
            depot.useTickets(bus2, tickets);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus1));
            Assert.assertEquals(expected, depot.getTickets(bus2));
        }
    }

    @Test
    public void testRemoveTicketNotInBus() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(1);
        Bus bus2 = depot.createBus(1);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

        {
            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            depot.boardBus(bus1, tickets);

            tickets.clear();
            tickets.add(ticket2);
            depot.useTickets(bus2, tickets);

            Set<Ticket> expected = Set.of(ticket1);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus1));
            Assert.assertEquals(Set.of(), depot.getTickets(bus2));
        }
    }
}