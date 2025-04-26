package edu.uic.cs454.s25.a4;

import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.junit.Assert;
import org.junit.Test;

public class Test04_UseExpireSingleBus {

    @Test
    public void testRemoveFromBus() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(2);

        bus.startThread();

        {
            Ticket ticket1 = depot.issueTicket(0);
            Ticket ticket2 = depot.issueTicket(1);

            Set<Ticket> items = Set.of(ticket1, ticket2);
            depot.boardBus(bus, items);
            depot.expireTickets(bus, items);

            Set<Ticket> expected = Set.of();
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
            Assert.assertEquals(expected, depot.getTickets(bus));

            tickets.clear();
            tickets.add(ticket2);
            depot.expireTickets(bus, tickets);

            expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets(bus));
        }

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(Set.of(), bus.getContents());
    }

    @Test
    public void testRemoveFromBusAsync() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(2);

        Map<Result<Set<Ticket>>, Set<Ticket>> expected = new HashMap<>();

        {
            Ticket ticket1 = depot.issueTicket(0);
            Ticket ticket2 = depot.issueTicket(1);

            Set<Ticket> tickets = Set.of(ticket1, ticket2);
            depot.boardBusAsync(bus, tickets);
            depot.expireTicketsAsync(bus, tickets);

            expected.put(depot.getTicketsAsync(bus), Set.of());
        }

        {
            Ticket ticket1 = depot.issueTicket(2);
            Ticket ticket2 = depot.issueTicket(3);

            depot.boardBusAsync(bus, Set.of(ticket1));
            depot.boardBusAsync(bus, Set.of(ticket2));


            depot.expireTicketsAsync(bus, Set.of(ticket1));
            expected.put(depot.getTicketsAsync(bus), Set.of(ticket2));

            depot.useTicketsAsync(bus, Set.of(ticket2));

            expected.put(depot.getTicketsAsync(bus), Set.of());
        }

        bus.startThread();

        for (Map.Entry<Result<Set<Ticket>>, Set<Ticket>> entry : expected.entrySet()) {
            bus.allowedThread.interrupt();
            Assert.assertEquals(entry.getValue(), entry.getKey().getResult());
        }

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(Set.of(), bus.getContents());
    }


    @Test
    public void testRemoveFromEmptyBus() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);

        bus.startThread();

        {
            Set<Ticket> items = Set.of(ticket1, ticket2);

            depot.expireTickets(bus, items);

            Set<Ticket> expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets(bus));
        }

        {
            Set<Ticket> items = new HashSet<>();
            items.add(ticket1);
            items.add(ticket2);

            depot.boardBus(bus, items);

            Set<Ticket> expected = Set.of(ticket1, ticket2);
            Assert.assertEquals(expected, depot.getTickets(bus));

            depot.boardBus(bus, items);
            depot.expireTickets(bus, items);

            expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets(bus));

            items.clear();
            items.add(ticket1);
            depot.expireTickets(bus, items);
            Assert.assertEquals(expected, depot.getTickets(bus));

            items.clear();
            items.add(ticket2);
            depot.boardBus(bus, items);
            Assert.assertEquals(expected, depot.getTickets(bus));
        }

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(Set.of(), bus.getContents());
    }

    @Test
    public void testRemoveFromEmptyBusAsync() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);

        Map<Result<Set<Ticket>>, Set<Ticket>> expected = new HashMap<>();

        {
            Set<Ticket> tickets = Set.of(ticket1, ticket2);

            depot.expireTicketsAsync(bus, tickets);

            expected.put(depot.getTicketsAsync(bus), Set.of());
        }

        {
            depot.boardBusAsync(bus, Set.of(ticket1, ticket2));

            expected.put(depot.getTicketsAsync(bus), Set.of(ticket1, ticket2));

            depot.boardBusAsync(bus, Set.of(ticket1, ticket2));
            depot.expireTicketsAsync(bus, Set.of(ticket1, ticket2));

            expected.put(depot.getTicketsAsync(bus), Set.of());

            depot.expireTicketsAsync(bus, Set.of(ticket1));
            expected.put(depot.getTicketsAsync(bus), Set.of());

            depot.boardBusAsync(bus, Set.of(ticket2));
            expected.put(depot.getTicketsAsync(bus), Set.of());
        }

        bus.startThread();

        for (Map.Entry<Result<Set<Ticket>>, Set<Ticket>> entry : expected.entrySet()) {
            bus.allowedThread.interrupt();
            Assert.assertEquals(entry.getValue(), entry.getKey().getResult());
        }

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(Set.of(), bus.getContents());
    }

    @Test
    public void testRemoveTicketNotInBus() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(1);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);

        bus.startThread();

        {
            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            depot.boardBus(bus, Set.of(ticket1));

            tickets.clear();
            tickets.add(ticket2);
            depot.boardBus(bus, tickets);

            Set<Ticket> expected = Set.of(ticket1);
            Assert.assertEquals(expected, depot.getTickets(bus));

            depot.getTickets(bus).clear();

            Assert.assertEquals(expected, depot.getTickets(bus));
        }

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(Set.of(ticket1), bus.getContents());
    }

    @Test
    public void testRemoveTicketNotInBusAsync() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(1);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);

        bus.startThread();

        Map<Result<Set<Ticket>>, Set<Ticket>> expected = new HashMap<>();

        {
            Set<Ticket> items = new HashSet<>();
            items.add(ticket1);
            depot.boardBus(bus, Set.of(ticket1));

            items.clear();
            items.add(ticket2);
            depot.boardBus(bus, items);

            expected.put(depot.getTicketsAsync(bus), Set.of(ticket1));

            ((Set<Ticket>)depot.getTicketsAsync(bus).getResult()).clear();

            expected.put(depot.getTicketsAsync(bus), Set.of(ticket1));
        }

        for (Map.Entry<Result<Set<Ticket>>, Set<Ticket>> entry : expected.entrySet()) {
            bus.allowedThread.interrupt();
            Assert.assertEquals(entry.getValue(), entry.getKey().getResult());
        }

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(Set.of(ticket1), bus.getContents());
    }

    @Test
    public void testTicketChangesCorrectly() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);

        bus.startThread();

        {
            depot.boardBus(bus, Set.of(ticket1));

            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket2.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket2));

            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket2.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket1));

            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket2.getStatus());
        }

        {
            depot.expireTickets(bus, Set.of(ticket1));

            Assert.assertEquals(Ticket.Status.EXPIRED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket2.getStatus());
        }

        {
            depot.expireTickets(bus, Set.of(ticket2));

            Assert.assertEquals(Ticket.Status.EXPIRED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket2));

            Assert.assertEquals(Ticket.Status.EXPIRED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket1));

            Assert.assertEquals(Ticket.Status.EXPIRED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket2));

            Assert.assertEquals(Ticket.Status.EXPIRED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket1, ticket2));

            Assert.assertEquals(Ticket.Status.EXPIRED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
        }

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(Set.of(), bus.getContents());


    }

    @Test
    public void testTicketChangesCorrectlyAsync() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);

        Result<Boolean> last;

        {
            depot.boardBusAsync(bus, Set.of(ticket1));

            Assert.assertEquals(Ticket.Status.ISSUED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket2.getStatus());
        }

        {
            depot.boardBusAsync(bus, Set.of(ticket2));

            Assert.assertEquals(Ticket.Status.ISSUED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket2.getStatus());
        }

        {
            depot.boardBusAsync(bus, Set.of(ticket1));

            Assert.assertEquals(Ticket.Status.ISSUED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket2.getStatus());
        }

        {
            depot.expireTicketsAsync(bus, Set.of(ticket1));

            Assert.assertEquals(Ticket.Status.ISSUED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket2.getStatus());
        }

        {
            depot.useTicketsAsync(bus, Set.of(ticket2));

            Assert.assertEquals(Ticket.Status.ISSUED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket2.getStatus());
        }

        {
            depot.boardBusAsync(bus, Set.of(ticket2));

            Assert.assertEquals(Ticket.Status.ISSUED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket2.getStatus());
        }

        {
            depot.boardBusAsync(bus, Set.of(ticket1));

            Assert.assertEquals(Ticket.Status.ISSUED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket2.getStatus());
        }

        {
            depot.boardBusAsync(bus, Set.of(ticket2));

            Assert.assertEquals(Ticket.Status.ISSUED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket2.getStatus());
        }

        {
            last = depot.boardBusAsync(bus, Set.of(ticket1, ticket2));

            Assert.assertEquals(Ticket.Status.ISSUED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket2.getStatus());
        }

        bus.startThread();

        bus.allowedThread.interrupt();

        // Once we get the last result, we know that all the previous async operations have completed
        last.getResult();

        bus.allowedThread.interrupt();

        bus.stopThread();

        Assert.assertEquals(Ticket.Status.EXPIRED, ticket1.getStatus());
        Assert.assertEquals(Ticket.Status.USED, ticket2.getStatus());

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(Set.of(), bus.getContents());


    }

    @Test
    public void testCannotReuseTickets() {
        int size = 1_000;
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

        bus.startThread();

        Ticket[] tickets = new Ticket[size];
        for (int i = 0 ; i < size ; i++) {
            tickets[i] = depot.issueTicket(i);
            Set<Ticket> toAdd = new HashSet<>();
            toAdd.add(tickets[i]);
            Assert.assertTrue(depot.boardBus(bus, toAdd));
        }

        for (int i : indexes) {
            Set<Ticket> ticketSet = Set.of(tickets[i]);
            if (i%2 == 0) {
                Assert.assertTrue(depot.expireTickets(bus, ticketSet));
            } else {
                Assert.assertTrue(depot.useTickets(bus, ticketSet));
            }

            Assert.assertFalse(depot.boardBus(bus, ticketSet));
            Assert.assertFalse(depot.expireTickets(bus, ticketSet));
        }

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(Set.of(), bus.getContents());
    }

    @Test
    public void testCannotReuseTicketsAsync() {
        int size = 1_000;
        List<Integer> sequentialIndexes = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList = IntStream.range(0, size).boxed().collect(Collectors.toList());

        Collections.shuffle(shuffledIndexesList);

        testCannotReuseTicketsAsync(sequentialIndexes);
        testCannotReuseTicketsAsync(shuffledIndexesList);
    }

    public void testCannotReuseTicketsAsync(List<Integer> indexes) {
        Depot depot = Depot.createDepot();
        int size = indexes.size();
        Bus bus = depot.createBus(size);


        Map<Result<Boolean>, Boolean> expected = new HashMap<>();

        Ticket[] tickets = new Ticket[size];
        for (int i = 0 ; i < size ; i++) {
            tickets[i] = depot.issueTicket(i);
            Set<Ticket> toAdd = new HashSet<>();
            toAdd.add(tickets[i]);
            expected.put(depot.boardBusAsync(bus, toAdd), true);
        }

        for (int i : indexes) {
            Set<Ticket> ticketSet = Set.of(tickets[i]);
            if (i%2 == 0) {
                expected.put(depot.expireTicketsAsync(bus, ticketSet), true);
            } else {
                expected.put(depot.useTicketsAsync(bus, ticketSet), true);
            }

            expected.put(depot.useTicketsAsync(bus, ticketSet), false);
            expected.put(depot.expireTicketsAsync(bus, ticketSet), false);
        }

        bus.startThread();

        for (Map.Entry<Result<Boolean>, Boolean> entry : expected.entrySet()) {
            Assert.assertEquals(entry.getValue(), entry.getKey().getResult());
            bus.allowedThread.interrupt();
        }

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(Set.of(), bus.getContents());
    }

}
