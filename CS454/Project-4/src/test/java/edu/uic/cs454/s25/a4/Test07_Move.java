package edu.uic.cs454.s25.a4;

import java.util.AbstractMap;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.Set;

import org.junit.Assert;
import org.junit.Test;

public class Test07_Move {

    @Test
    public void moveTicketToEmptyBus() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(2);
        Bus bus2 = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);
        Ticket ticket3 = depot.issueTicket(3);
        Ticket ticket4 = depot.issueTicket(4);

        bus1.startThread();
        bus2.startThread();

        Set<Ticket> toAdd = Set.of(ticket1, ticket2);
        Assert.assertTrue(depot.boardBus(bus1, toAdd));

        Set<Ticket> toMove = Set.of(ticket1, ticket2);
        Assert.assertTrue(depot.transferTickets(bus1, bus2, toMove));
        Assert.assertFalse(depot.useTickets(bus1, toMove));
        Assert.assertFalse(depot.expireTickets(bus1, toMove));

        Set<Ticket> toAddMore = Set.of(ticket3, ticket4);
        Assert.assertTrue(depot.boardBus(bus1, toAddMore));
        Assert.assertTrue(depot.expireTickets(bus2, toMove));

        bus1.stopThread();
        bus2.stopThread();

        Assert.assertFalse(bus1.didThrowException());
        Assert.assertFalse(bus2.didThrowException());

        Assert.assertEquals(Set.of(ticket3, ticket4), bus1.getContents());
        Assert.assertEquals(Set.of(), bus2.getContents());
    }

    @Test
    public void moveTicketToEmptyBusAsync() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(2);
        Bus bus2 = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);
        Ticket ticket3 = depot.issueTicket(3);
        Ticket ticket4 = depot.issueTicket(4);

        LinkedList<Map.Entry<Result<Boolean>, Boolean>> expected = new LinkedList<>();

        Set<Ticket> toAdd = Set.of(ticket1, ticket2);
        expected.addLast(new AbstractMap.SimpleEntry<>(depot.boardBusAsync(bus1, toAdd), true));

        Set<Ticket> toMove = Set.of(ticket1, ticket2);
        expected.addLast(new AbstractMap.SimpleEntry<>(depot.transferTicketsAsync(bus1, bus2, toMove), true));
        expected.addLast(new AbstractMap.SimpleEntry<>(depot.useTicketsAsync(bus1, toMove), false));
        expected.addLast(new AbstractMap.SimpleEntry<>(depot.expireTicketsAsync(bus1, toMove), false));

        Set<Ticket> toAddMore = Set.of(ticket3, ticket4);
        expected.addLast(new AbstractMap.SimpleEntry<>(depot.boardBusAsync(bus1, toAddMore), true));

        bus1.startThread();
        bus2.startThread();

        for (Map.Entry<Result<Boolean>, Boolean> entry : expected) {
            Assert.assertEquals(entry.getValue(), entry.getKey().getResult());
        }

        bus1.stopThread();

        Assert.assertEquals(depot.expireTicketsAsync(bus2, toMove).getResult(), true);

        bus2.stopThread();

        Assert.assertFalse(bus1.didThrowException());
        Assert.assertFalse(bus2.didThrowException());

        Assert.assertEquals(Set.of(ticket3, ticket4), bus1.getContents());
        Assert.assertEquals(Set.of(), bus2.getContents());
    }

    @Test
    public void moveToFullBus() {
        Depot depot = Depot.createDepot();
        Bus from = depot.createBus(1);
        Bus to = depot.createBus(1);

        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

        from.startThread();
        to.startThread();

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

        from.stopThread();
        to.stopThread();

        Assert.assertFalse(from.didThrowException());
        Assert.assertFalse(to.didThrowException());

        Assert.assertEquals(Set.of(ticket1), from.getContents());
        Assert.assertEquals(Set.of(ticket2), to.getContents());
    }

    @Test
    public void moveToFullBusAsync() {
        Depot depot = Depot.createDepot();
        Bus from = depot.createBus(1);
        Bus to = depot.createBus(1);

        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

        Map<Result<Set<Ticket>>, Set<Ticket>> expected = new HashMap<>();
        Result<Boolean> moveResult;

        depot.boardBusAsync(from, Set.of(ticket1));
        depot.boardBusAsync(to, Set.of(ticket2));

        expected.put(depot.getTicketsAsync(from), Set.of(ticket1));
        expected.put(depot.getTicketsAsync(to), Set.of(ticket2));

        moveResult = depot.transferTicketsAsync(from, to, Set.of(ticket1));

        from.startThread();
        to.startThread();

        Assert.assertFalse(moveResult.getResult());

        expected.put(depot.getTicketsAsync(from), Set.of(ticket1));
        expected.put(depot.getTicketsAsync(to), Set.of(ticket2));
        expected.put(depot.getTicketsAsync(), Set.of(ticket1, ticket2));

        for (Map.Entry<Result<Set<Ticket>>, Set<Ticket>> entry : expected.entrySet()) {
            Assert.assertEquals(entry.getValue(), entry.getKey().getResult());
        }

        from.stopThread();
        to.stopThread();

        Assert.assertFalse(from.didThrowException());
        Assert.assertFalse(to.didThrowException());

        Assert.assertEquals(Set.of(ticket1), from.getContents());
        Assert.assertEquals(Set.of(ticket2), to.getContents());
    }


    @Test
    public void moveInvalidTicket() {
        Depot depot = Depot.createDepot();
        Bus from = depot.createBus(1);
        Bus to = depot.createBus(1);

        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

        from.startThread();
        to.startThread();

        depot.boardBus(from, Set.of(ticket1));

        {
            Set<Ticket> expected = Set.of(ticket1);
            Assert.assertEquals(expected, depot.getTickets(from));
        }

        {
            Set<Ticket> expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets(to));
        }

        Assert.assertFalse(depot.transferTickets(from, to, Set.of(ticket2)));

        {
            Set<Ticket> expected = Set.of(ticket1);
            Assert.assertEquals(expected, depot.getTickets(from));
        }

        {
            Set<Ticket> expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets(to));
        }

        from.stopThread();
        to.stopThread();

        Assert.assertFalse(from.didThrowException());
        Assert.assertFalse(to.didThrowException());

        Assert.assertEquals(Set.of(ticket1), from.getContents());
        Assert.assertEquals(Set.of(), to.getContents());
    }

    @Test
    public void moveInvalidTicketAsync() {
        Depot depot = Depot.createDepot();
        Bus from = depot.createBus(1);
        Bus to = depot.createBus(1);

        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

        Map<Result<Set<Ticket>>, Set<Ticket>> expected = new HashMap<>();
        Result<Boolean> moveResult;

        depot.boardBusAsync(from, Set.of(ticket1));

        expected.put(depot.getTicketsAsync(from), Set.of(ticket1));
        expected.put(depot.getTicketsAsync(to), Set.of());

        moveResult = depot.transferTicketsAsync(from, to, Set.of(ticket2));

        from.startThread();
        to.startThread();

        Assert.assertFalse(moveResult.getResult());

        expected.put(depot.getTicketsAsync(from), Set.of(ticket1));
        expected.put(depot.getTicketsAsync(to), Set.of());
        expected.put(depot.getTicketsAsync(), Set.of(ticket1));

        for (Map.Entry<Result<Set<Ticket>>, Set<Ticket>> entry : expected.entrySet()) {
            Assert.assertEquals(entry.getValue(), entry.getKey().getResult());
        }

        from.stopThread();
        to.stopThread();

        Assert.assertFalse(from.didThrowException());
        Assert.assertFalse(to.didThrowException());

        Assert.assertEquals(Set.of(ticket1), from.getContents());
        Assert.assertEquals(Set.of(), to.getContents());
    }

    @Test
    public void moveInvalidTicketToFullBus() {
        Depot depot = Depot.createDepot();
        Bus from = depot.createBus(1);
        Bus to = depot.createBus(1);

        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);
        Ticket ticket3 = depot.issueTicket(3);

        from.startThread();
        to.startThread();

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

        Assert.assertFalse(depot.transferTickets(from, to, Set.of(ticket3)));

        {
            Set<Ticket> expected = Set.of(ticket1);
            Assert.assertEquals(expected, depot.getTickets(from));
        }

        {
            Set<Ticket> expected = Set.of(ticket2);
            Assert.assertEquals(expected, depot.getTickets(to));
        }

        from.stopThread();
        to.stopThread();

        Assert.assertFalse(from.didThrowException());
        Assert.assertFalse(to.didThrowException());

        Assert.assertEquals(Set.of(ticket1), from.getContents());
        Assert.assertEquals(Set.of(ticket2), to.getContents());
    }

    @Test
    public void moveInvalidTicketToFullBusAsync() {
        Depot depot = Depot.createDepot();
        Bus from = depot.createBus(1);
        Bus to = depot.createBus(1);

        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);
        Ticket ticket3 = depot.issueTicket(3);

        Map<Result<Set<Ticket>>, Set<Ticket>> expected = new HashMap<>();
        Result<Boolean> moveResult;

        depot.boardBusAsync(from, Set.of(ticket1));
        depot.boardBusAsync(to, Set.of(ticket2));

        expected.put(depot.getTicketsAsync(from), Set.of(ticket1));
        expected.put(depot.getTicketsAsync(to), Set.of(ticket2));
        expected.put(depot.getTicketsAsync(), Set.of(ticket1, ticket2));

        moveResult = depot.transferTicketsAsync(from, to, Set.of(ticket3));

        from.startThread();
        to.startThread();

        Assert.assertFalse(moveResult.getResult());

        expected.put(depot.getTicketsAsync(from), Set.of(ticket1));
        expected.put(depot.getTicketsAsync(to), Set.of(ticket2));
        expected.put(depot.getTicketsAsync(), Set.of(ticket1, ticket2));

        for (Map.Entry<Result<Set<Ticket>>, Set<Ticket>> entry : expected.entrySet()) {
            Assert.assertEquals(entry.getValue(), entry.getKey().getResult());
        }

        from.stopThread();
        to.stopThread();

        Assert.assertFalse(from.didThrowException());
        Assert.assertFalse(to.didThrowException());

        Assert.assertEquals(Set.of(ticket1), from.getContents());
        Assert.assertEquals(Set.of(ticket2), to.getContents());
    }
}
