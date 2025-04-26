package edu.uic.cs454.s25.a4;

import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.junit.Assert;
import org.junit.Test;

public class Test03_AsyncProgress {

    @Test
    public void testMaxCapacityAsync() {
        Depot depot = Depot.createDepot();
        int size = 100;
        int test = 200;
        Bus bus = depot.createBus(size);


        Result<Boolean>[] rs = new Result[test];
        Set<Ticket> expected = new HashSet<>();

        for (int i = 0 ; i < test ; i++) {
            Ticket ticket = depot.issueTicket(i);
            rs[i] = depot.boardBusAsync(bus, Set.of(ticket));
            if (i < size)
                expected.add(ticket);

        }

        bus.startThread();

        for (int i = 0 ; i < test ; i++) {
            if (i < size)
                Assert.assertTrue(rs[i].getResult());
            else
                Assert.assertFalse(rs[i].getResult());
        }

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(expected, bus.getContents());
    }

    @Test
    public void testTicketAlreadyInBusAsync() {
        int size = 1_000;
        List<Integer> sequentialIndexes = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList = IntStream.range(0, size).boxed().collect(Collectors.toList());

        Collections.shuffle(shuffledIndexesList);

        testTicketAlreadyInBusAsync(sequentialIndexes);
        testTicketAlreadyInBusAsync(shuffledIndexesList);
    }

    private void testTicketAlreadyInBusAsync(List<Integer> indexes) {
        int size = indexes.size();
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(size);

        Ticket[] tickets = new Ticket[size];
        for (int i = 0 ; i < size ; i++) {
            tickets[i] = depot.issueTicket(i);
        }

        List<Result<Boolean>> trueResults  = new LinkedList<>();
        List<Result<Boolean>> falseResults = new LinkedList<>();

        for (int i : indexes) {
            {
                Set<Ticket> toAdd = new HashSet<>();
                toAdd.add(tickets[i]);
                trueResults.add(depot.boardBusAsync(bus, toAdd));
                falseResults.add(depot.boardBusAsync(bus, toAdd));
                falseResults.add(depot.boardBusAsync(bus, Set.of(tickets[i])));
            }

            if (i > 0) {
                Set<Ticket> toAdd = new HashSet<>();
                toAdd.add(tickets[i]);
                toAdd.add(tickets[i-1]);
                falseResults.add(depot.boardBusAsync(bus, toAdd));
                falseResults.add(depot.boardBusAsync(bus, Set.of(tickets[i], tickets[i-1])));
            }

            {
                Set<Ticket> toAdd = new HashSet<>();
                toAdd.add(tickets[i]);
                Ticket anotherTicket = depot.issueTicket(size+i);
                toAdd.add(anotherTicket);
                falseResults.add(depot.boardBusAsync(bus, toAdd));
                falseResults.add(depot.boardBusAsync(bus, Set.of(tickets[i], anotherTicket)));
            }

        }

        bus.startThread();

        for (Result<Boolean> r : trueResults)
            Assert.assertTrue(r.getResult());

        for (Result<Boolean> r : falseResults)
            Assert.assertFalse(r.getResult());

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(Set.of(tickets), bus.getContents());
    }

    @Test
    public void testCapacityAddAsync() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(1);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);

        Map<Result<Set<Ticket>>, Set<Ticket>> expected = new HashMap<>();

        {
            depot.boardBusAsync(bus, Set.of(ticket1, ticket2));

            expected.put(depot.getTicketsAsync(bus), Set.of());
        }

        {
            depot.boardBusAsync(bus, Set.of(ticket1));
            depot.boardBusAsync(bus, Set.of(ticket2));

            expected.put(depot.getTicketsAsync(bus), Set.of(ticket1));
        }

        bus.startThread();

        for (Map.Entry<Result<Set<Ticket>>, Set<Ticket>> entry : expected.entrySet()) {
            Assert.assertEquals(entry.getValue(), entry.getKey().getResult());
        }

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(Set.of(ticket1), bus.getContents());
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

        for (int i : indexes) {
            tickets[i] = depot.issueTicket(i);
            toAdd.add(tickets[i]);
            expected.add(tickets[i]);
        }

        depot.boardBusAsync(bus, toAdd);

        bus.startThread();

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