package edu.uic.cs454.s25.a4;

import org.junit.Assert;
import org.junit.Test;

import java.util.Collections;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Test01_AddSingleBus {
    @Test
    public void testMaxCapacity() {
        Depot depot = Depot.createDepot();
        int size = 10;
        int test = 20;
        Bus bus = depot.createBus(size);

        bus.startThread();

        Set<Ticket> expected = new HashSet<>();

        for (int i = 0 ; i < test ; i++) {
            Ticket ticket = depot.issueTicket(i);

            if (i < size) {
                expected.add(ticket);
                Assert.assertTrue(depot.boardBus(bus, Set.of(ticket)));
            } else {
                Assert.assertFalse(depot.boardBus(bus, Set.of(ticket)));
            }
        }

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(expected, bus.getContents());
    }

    @Test
    public void testMaxCapacityAsync() {
        Depot depot = Depot.createDepot();
        int size = 10;
        int test = 20;
        Bus bus = depot.createBus(size);

        bus.startThread();

        Result<Boolean>[] rs = new Result[test];
        Set<Ticket> expected = new HashSet<>();

        for (int i = 0 ; i < test ; i++) {
            Ticket ticket = depot.issueTicket(i);
            rs[i] = depot.boardBusAsync(bus, Set.of(ticket));
            if (i < size)
                expected.add(ticket);

        }

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

        bus.startThread();

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

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(Set.of(tickets), bus.getContents());
    }

    @Test
    public void testTicketAlreadyInBusAsync() {
        int size = 10;
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

        bus.startThread();

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

        for (Result<Boolean> r : trueResults)
            Assert.assertTrue(r.getResult());

        for (Result<Boolean> r : falseResults)
            Assert.assertFalse(r.getResult());

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(Set.of(tickets), bus.getContents());
    }


}
