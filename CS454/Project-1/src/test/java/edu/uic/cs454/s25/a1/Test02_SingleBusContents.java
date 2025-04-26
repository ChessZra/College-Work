package edu.uic.cs454.s25.a1;

import org.junit.Assert;
import org.junit.Test;

import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Test02_SingleBusContents {
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
    public void testModifiableSet() {
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

            Set<Ticket> tickets = Set.of(ticket1, ticket2);
            depot.boardBus(bus, tickets);
            depot.expireTickets(bus, tickets);

            Set<Ticket> expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));
        }

        {
            Ticket ticket1 = depot.issueTicket(2);
            Ticket ticket2 = depot.issueTicket(3);

            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            depot.boardBus(bus, tickets);
            tickets.clear();
            tickets.add(ticket2);
            depot.boardBus(bus, tickets);


            tickets.clear();
            tickets.add(ticket1);
            depot.useTickets(bus, tickets);

            Set<Ticket> expected = Set.of(ticket2);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));

            tickets.clear();
            tickets.add(ticket2);
            depot.useTickets(bus, tickets);

            expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));
        }
    }

    @Test
    public void testRemoveFromEmptyBus() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);

        {
            Set<Ticket> tickets = Set.of(ticket1, ticket2);

            depot.expireTickets(bus, tickets);

            Set<Ticket> expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));
        }

        {
            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            tickets.add(ticket2);

            depot.boardBus(bus, tickets);

            Set<Ticket> expected = Set.of(ticket1, ticket2);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));

            depot.useTickets(bus, tickets);
            depot.expireTickets(bus, tickets);

            expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));

            tickets.clear();
            tickets.add(ticket1);
            depot.expireTickets(bus, tickets);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));

            tickets.clear();
            tickets.add(ticket2);
            depot.useTickets(bus, tickets);
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
            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            depot.boardBus(bus, Set.of(ticket1));

            tickets.clear();
            tickets.add(ticket2);
            depot.useTickets(bus, tickets);

            Set<Ticket> expected = Set.of(ticket1);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));

            depot.getTickets().clear();
            depot.getTickets(bus).clear();

            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus));
        }
    }

    @Test
    public void testTicketChangesCorrectly() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(3);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);
        Ticket ticket3 = depot.issueTicket(2);

        {
            Assert.assertEquals(Ticket.Status.ISSUED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket3.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket1));

            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket3.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket2));

            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket3.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket3));

            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket3.getStatus());
        }

        {
            depot.useTickets(bus, Set.of(ticket1));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket3.getStatus());
        }

        {
            depot.expireTickets(bus, Set.of(ticket1));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket3.getStatus());
        }

        {
            depot.expireTickets(bus, Set.of(ticket2));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket3.getStatus());
        }

        {
            depot.useTickets(bus, Set.of(ticket2));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket3.getStatus());
        }

        {
            depot.useTickets(bus, Set.of(ticket3));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.USED, ticket3.getStatus());
        }

        {
            depot.expireTickets(bus, Set.of(ticket3));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.USED, ticket3.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket1));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.USED, ticket3.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket2));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.USED, ticket3.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket3));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.USED, ticket3.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket1, ticket2, ticket3));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.USED, ticket3.getStatus());
        }


    }
}
