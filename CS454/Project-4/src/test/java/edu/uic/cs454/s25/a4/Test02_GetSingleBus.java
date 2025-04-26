package edu.uic.cs454.s25.a4;

import org.junit.Assert;
import org.junit.Test;

import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Test02_GetSingleBus {

    @Test
    public void testCapacityAdd() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(1);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);

        bus.startThread();

        {
            depot.boardBus(bus, Set.of(ticket1, ticket2));

            Set<Ticket> expected = Set.of();
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
            Assert.assertEquals(expected, depot.getTickets(bus));
        }

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(Set.of(ticket1), bus.getContents());
    }

    @Test
    public void testCapacityAddAsync() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(1);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);

        bus.startThread();

        {
            depot.boardBusAsync(bus, Set.of(ticket1, ticket2));

            Set<Ticket> expected = Set.of();
            Result<Set<Ticket>> r = depot.getTicketsAsync(bus);

            Assert.assertEquals(expected, r.getResult());
        }

        {
            Set<Ticket> toAdd = new HashSet<>();
            toAdd.add(ticket1);
            depot.boardBusAsync(bus, toAdd).getResult();
            toAdd.clear();
            toAdd.add(ticket2);
            depot.boardBusAsync(bus, toAdd);

            Set<Ticket> expected = Set.of(ticket1);
            Result<Set<Ticket>> r = depot.getTicketsAsync(bus);
            Assert.assertEquals(expected, r.getResult());
        }

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(Set.of(ticket1), bus.getContents());
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

    public void testCapacitySameDescription(List<Integer> indexes) {
        int size = indexes.size();
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(size);
        Ticket[] tickets = new Ticket[size];
        Set<Ticket> toAdd = new HashSet<>();
        Set<Ticket> expected = new HashSet<>();

        bus.startThread();

        for (int i : indexes) {
            tickets[i] = depot.issueTicket(i);
            toAdd.add(tickets[i]);
            expected.add(tickets[i]);
        }

        depot.boardBus(bus, toAdd);

        Assert.assertEquals(size, depot.getTickets(bus).size());
        Assert.assertEquals(expected, depot.getTickets(bus));
        depot.getTickets(bus).clear();
        Assert.assertEquals(size, depot.getTickets(bus).size());
        Assert.assertEquals(expected, depot.getTickets(bus));

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(expected, bus.getContents());
    }


    @Test
    public void testCapacitySameDescriptionAsync() {
        int size = 10;
        List<Integer> sequentialIndexes = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList = IntStream.range(0, size).boxed().collect(Collectors.toList());

        Collections.shuffle(shuffledIndexesList);

        testCapacitySameDescriptionAsync(sequentialIndexes);
        testCapacitySameDescriptionAsync(shuffledIndexesList);
    }

    public void testCapacitySameDescriptionAsync(List<Integer> indexes) {
        int size = indexes.size();
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(size);
        Ticket[] tickets = new Ticket[size];
        Set<Ticket> toAdd = new HashSet<>();
        Set<Ticket> expected = new HashSet<>();

        bus.startThread();

        for (int i : indexes) {
            tickets[i] = depot.issueTicket(i);
            toAdd.add(tickets[i]);
            expected.add(tickets[i]);
        }

        depot.boardBusAsync(bus, toAdd);

        Result<Set<Ticket>> r1 = depot.getTicketsAsync(bus);

        Assert.assertEquals(size, r1.getResult().size());
        Assert.assertEquals(expected, r1.getResult());
        depot.getTickets(bus).clear();
        Assert.assertEquals(size, depot.getTickets(bus).size());
        Assert.assertEquals(expected, depot.getTickets(bus));

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(expected, bus.getContents());
    }

}
