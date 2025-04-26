package edu.uic.cs454.s25.a4;

import org.junit.Assert;
import org.junit.Test;

import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Test06_ManyBuses {

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
            Assert.assertEquals(expected, depot.getTickets());
            bus.allowedThread.interrupt();
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
            bus.allowedThread.interrupt();
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

        Result<Set<Ticket>> r1, r2;

        {
            depot.boardBusAsync(bus, Set.of(ticket1, ticket2));

            r1 = depot.getTicketsAsync();
        }

        {
            depot.boardBusAsync(bus, Set.of(ticket1));
            depot.boardBusAsync(bus, Set.of(ticket2));

            r2 = depot.getTicketsAsync();
        }

        bus.startThread();

        bus.allowedThread.interrupt();
        Assert.assertEquals(Set.of(),   r1.getResult());
        bus.allowedThread.interrupt();
        Assert.assertEquals(Set.of(ticket1), r2.getResult());
        bus.allowedThread.interrupt();

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
            bus.allowedThread.interrupt();
        }

        depot.boardBus(bus, toAdd);

        Assert.assertEquals(size, depot.getTickets().size());
        Assert.assertEquals(expected, depot.getTickets());
        depot.getTickets(bus).clear();
        Assert.assertEquals(size, depot.getTickets().size());
        Assert.assertEquals(expected, depot.getTickets());

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

        for (int i : indexes) {
            tickets[i] = depot.issueTicket(i);
            toAdd.add(tickets[i]);
            expected.add(tickets[i]);
        }

        depot.boardBusAsync(bus, toAdd);

        bus.startThread();

        Result<Set<Ticket>> r1 = depot.getTicketsAsync();

        Assert.assertEquals(size, r1.getResult().size());
        Assert.assertEquals(expected, r1.getResult());
        bus.allowedThread.interrupt();
        depot.getTickets(bus).clear();
        Assert.assertEquals(size, depot.getTickets().size());
        Assert.assertEquals(expected, depot.getTickets());

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(expected, bus.getContents());
    }

    @Test
    public void testRemoveFromBus() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(2);

        bus.startThread();

        {
            bus.allowedThread.interrupt();
            Ticket c1 = depot.issueTicket(0);
            Ticket c2 = depot.issueTicket(1);

            Set<Ticket> items = Set.of(c1, c2);
            depot.boardBus(bus, items);
            depot.useTickets(bus, items);

            Set<Ticket> expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets());
            bus.allowedThread.interrupt();
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
            bus.allowedThread.interrupt();


            items.clear();
            items.add(ticket1);
            depot.expireTickets(bus, items);

            Set<Ticket> expected = Set.of(ticket2);
            Assert.assertEquals(expected, depot.getTickets());

            items.clear();
            items.add(ticket2);
            depot.expireTickets(bus, items);

            expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets());
            bus.allowedThread.interrupt();
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

            Set<Ticket> items = Set.of(ticket1, ticket2);
            depot.boardBusAsync(bus, items);
            depot.expireTicketsAsync(bus, items);

            expected.put(depot.getTicketsAsync(), Set.of());
        }

        {
            Ticket ticket1 = depot.issueTicket(2);
            Ticket ticket2 = depot.issueTicket(3);

            depot.boardBusAsync(bus, Set.of(ticket1));
            depot.boardBusAsync(bus, Set.of(ticket2));


            depot.useTicketsAsync(bus, Set.of(ticket1));
            expected.put(depot.getTicketsAsync(), Set.of(ticket2));

            depot.expireTicketsAsync(bus, Set.of(ticket2));

            expected.put(depot.getTicketsAsync(), Set.of());
        }

        bus.startThread();

        for (Map.Entry<Result<Set<Ticket>>, Set<Ticket>> entry : expected.entrySet()) {
            bus.allowedThread.interrupt();
            Assert.assertEquals(entry.getValue(), entry.getKey().getResult());
            bus.allowedThread.interrupt();
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

            depot.useTickets(bus, items);

            Set<Ticket> expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets());
        }

        {
            Set<Ticket> items = new HashSet<>();
            items.add(ticket1);
            items.add(ticket2);

            depot.boardBus(bus, items);

            Set<Ticket> expected = Set.of(ticket1, ticket2);
            Assert.assertEquals(expected, depot.getTickets());

            depot.useTickets(bus, items);
            depot.expireTickets(bus, items);

            expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets());

            items.clear();
            items.add(ticket1);
            depot.useTickets(bus, items);
            Assert.assertEquals(expected, depot.getTickets());

            items.clear();
            items.add(ticket2);
            depot.expireTickets(bus, items);
            Assert.assertEquals(expected, depot.getTickets());
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
            Set<Ticket> items = Set.of(ticket1, ticket2);

            depot.expireTicketsAsync(bus, items);

            expected.put(depot.getTicketsAsync(bus), Set.of());
        }

        {
            depot.boardBusAsync(bus, Set.of(ticket1, ticket2));

            expected.put(depot.getTicketsAsync(), Set.of(ticket1, ticket2));

            depot.useTicketsAsync(bus, Set.of(ticket1, ticket2));
            depot.expireTicketsAsync(bus, Set.of(ticket1, ticket2));

//            expected = Set.of();
            expected.put(depot.getTicketsAsync(), Set.of());

            depot.useTicketsAsync(bus, Set.of(ticket1));
            expected.put(depot.getTicketsAsync(), Set.of());

            depot.expireTicketsAsync(bus, Set.of(ticket2));
            expected.put(depot.getTicketsAsync(), Set.of());
        }

        bus.startThread();

        for (Map.Entry<Result<Set<Ticket>>, Set<Ticket>> entry : expected.entrySet()) {
            Assert.assertEquals(entry.getValue(), entry.getKey().getResult());
        }

        bus.stopThread();

        Assert.assertFalse(bus.didThrowException());
        Assert.assertEquals(Set.of(), bus.getContents());
    }

    @Test
    public void testRemoveTicketsNotInBus() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(1);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);

        bus.startThread();

        {
            Set<Ticket> items = new HashSet<>();
            items.add(ticket1);
            depot.boardBus(bus, Set.of(ticket1));

            items.clear();
            items.add(ticket2);
            depot.useTickets(bus, items);

            Set<Ticket> expected = Set.of(ticket1);
            Assert.assertEquals(expected, depot.getTickets());

            depot.getTickets(bus).clear();

            Assert.assertEquals(expected, depot.getTickets());
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
            depot.expireTickets(bus, items);

            expected.put(depot.getTicketsAsync(), Set.of(ticket1));

            ((Set<Ticket>)depot.getTicketsAsync().getResult()).clear();

            expected.put(depot.getTicketsAsync(), Set.of(ticket1));
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
    public void testMaxCapacityBus() {
        Depot depot = Depot.createDepot();
        int n = 90;
        Bus[] buses = new Bus[n];
        Set<Ticket>[] expected = new Set[buses.length];
        Set<Ticket> everything = new HashSet<>();

        for (int i = 0 ; i < buses.length ; i++) {
            buses[i] = depot.createBus(i + 1);
            expected[i] = new HashSet<>();
        }

        for (Bus bus : buses)
            bus.startThread();

        int count = 0;


        for (int i = 0 ; i < n ; i++) {
            for (int j = 0 ; j < buses.length ; j++) {
                Bus bus = buses[j];
                Ticket ticket = depot.issueTicket(count++);
                Set<Ticket> toAdd = new HashSet<>();
                toAdd.add(ticket);

                Assert.assertEquals(everything, depot.getTickets());

                if (i <= j) {
                    Assert.assertTrue(depot.boardBus(bus, toAdd));
                    expected[j].add(ticket);
                    everything.add(ticket);
                } else {
                    Assert.assertFalse(depot.boardBus(bus, toAdd));
                }
            }
        }


        for (Bus w : buses)
            w.stopThread();

        for (int i = 0 ; i < buses.length ; i++) {
            Bus w = buses[i];
            Assert.assertFalse(w.didThrowException());
            Assert.assertEquals(expected[i], w.getContents());
        }

    }

    @Test
    public void testMaxCapacityBusAsync() {
        Depot depot = Depot.createDepot();
        int n = 90;
        Bus[] buses = new Bus[n];
        Set<Ticket>[] expected = new Set[buses.length];
        Set<Ticket> everything = new HashSet<>();

        for (int i = 0 ; i < buses.length ; i++) {
            buses[i] = depot.createBus(i + 1);
            expected[i] = new HashSet<>();
        }

        int count = 0;

        Map<Result<Boolean>, Boolean> expectedResults = new HashMap<>();
        Map<Result<Set<Ticket>>, Set<Ticket>> expectedContents = new HashMap<>();

        for (int i = 0 ; i < n ; i++) {
            for (int j = 0 ; j < buses.length ; j++) {
                Bus bus = buses[j];
                Ticket ticket = depot.issueTicket(count++);
                Set<Ticket> toAdd = new HashSet<>();
                toAdd.add(ticket);

                expectedContents.put(depot.getTicketsAsync(), new HashSet<>(everything));

                if (i <= j) {
                    expectedResults.put(depot.boardBusAsync(bus, toAdd), true);
                    expected[j].add(ticket);
                    everything.add(ticket);
                } else {
                    expectedResults.put(depot.boardBusAsync(bus, toAdd), false);
                }
            }
        }

        for (Bus bus : buses)
            bus.startThread();

        for (Map.Entry<Result<Boolean>, Boolean> entry : expectedResults.entrySet()) {
            Assert.assertEquals(entry.getValue(), entry.getKey().getResult());
        }

        for (Bus bus : buses) {
            bus.allowedThread.interrupt();
            bus.stopThread();
        }

        for (Map.Entry<Result<Set<Ticket>>, Set<Ticket>> entry : expectedContents.entrySet()) {
            Assert.assertEquals(entry.getValue(), entry.getKey().getResult());
        }

        for (int i = 0 ; i < buses.length ; i++) {
            Bus bus = buses[i];
            Assert.assertFalse(bus.didThrowException());
            Assert.assertEquals(expected[i], bus.getContents());
        }

    }

    @Test
    public void testRemoveFromLab() {
        int size = 1_000;
        List<Integer> sequentialIndexes = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList1 = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList2 = IntStream.range(0, size).boxed().collect(Collectors.toList());

        Collections.shuffle(shuffledIndexesList1);
        Collections.shuffle(shuffledIndexesList2);

        testRemoveFromBus(sequentialIndexes, sequentialIndexes);
        testRemoveFromBus(shuffledIndexesList1, shuffledIndexesList2);
    }

    public void testRemoveFromBus(List<Integer> testIndexes, List<Integer> shelfIndexes) {

        Depot depot = Depot.createDepot();
        int size = testIndexes.size();
        Bus[] buses = new Bus[shelfIndexes.size()];

        for (int i = 0 ; i < buses.length ; i++)
            buses[i] = depot.createBus(size);

        Ticket[] tickets = new Ticket[size];
        for (int i = 0 ; i < size ; i++)
            tickets[i] = depot.issueTicket(i);

        for (Bus bus : buses)
            bus.startThread();

        for (int i : testIndexes) {
            Set<Ticket> toAdd = new HashSet<>();
            Bus bus1 = buses[shelfIndexes.get(i)];
            Bus bus2 = buses[shelfIndexes.get((i+1)%shelfIndexes.size())];
            toAdd.add(tickets[i]);
            Assert.assertFalse(depot.expireTickets(bus1, toAdd));
            Assert.assertFalse(depot.useTickets(bus2, toAdd));

            Assert.assertTrue(depot.boardBus(bus1, toAdd));

            Assert.assertFalse(depot.expireTickets(bus2, toAdd));
            Assert.assertFalse(depot.useTickets(bus2, toAdd));

            if (i%2 == 0)
                Assert.assertTrue(depot.useTickets(bus1, toAdd));
            else
                Assert.assertTrue(depot.expireTickets(bus1, toAdd));
        }

        for (Bus bus : buses) {
            bus.stopThread();

            Assert.assertFalse(bus.didThrowException());
            Assert.assertEquals(Set.of(), bus.getContents());
        }
    }

    @Test
    public void testRemoveFromLabAsync() {
        int size = 1_000;
        List<Integer> sequentialIndexes = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList1 = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList2 = IntStream.range(0, size).boxed().collect(Collectors.toList());

        Collections.shuffle(shuffledIndexesList1);
        Collections.shuffle(shuffledIndexesList2);

        testRemoveFromBusAsync(sequentialIndexes, sequentialIndexes);
        testRemoveFromBusAsync(shuffledIndexesList1, shuffledIndexesList2);
    }

    public void testRemoveFromBusAsync(List<Integer> testIndexes, List<Integer> shelfIndexes) {

        Depot depot = Depot.createDepot();
        int size = testIndexes.size();
        Bus[] buses = new Bus[shelfIndexes.size()];

        for (int i = 0 ; i < buses.length ; i++)
            buses[i] = depot.createBus(size);

        Ticket[] tickets = new Ticket[size];
        for (int i = 0 ; i < size ; i++)
            tickets[i] = depot.issueTicket(i);

        Map<Result<Boolean>, Boolean> expected = new HashMap<>();

        for (int i : testIndexes) {
            Set<Ticket> toAdd = new HashSet<>();
            Bus bus1 = buses[shelfIndexes.get(i)];
            Bus bus2 = buses[shelfIndexes.get((i+1)%shelfIndexes.size())];
            toAdd.add(tickets[i]);
            expected.put(depot.useTicketsAsync(bus1, toAdd), false);
            expected.put(depot.expireTicketsAsync(bus2, toAdd), false);

            expected.put(depot.boardBusAsync(bus1, toAdd), true);

            expected.put(depot.expireTicketsAsync(bus2, toAdd), false);
            expected.put(depot.useTicketsAsync(bus2, toAdd), false);

            if (i%2 == 0)
                expected.put(depot.expireTicketsAsync(bus1, toAdd), true);
            else
                expected.put(depot.useTicketsAsync(bus1, toAdd), true);
        }

        for (Bus w : buses)
            w.startThread();

        for (Map.Entry<Result<Boolean>, Boolean> entry : expected.entrySet()) {
            Assert.assertEquals(entry.getValue(), entry.getKey().getResult());
        }

        for (Bus w : buses) {
            w.stopThread();

            Assert.assertFalse(w.didThrowException());
            Assert.assertEquals(Set.of(), w.getContents());
        }
    }

    @Test
    public void testRemoveFromEmptyBuss() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(2);
        Bus bus2 = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

        bus1.startThread();
        bus2.startThread();

        {
            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            tickets.add(ticket2);

            Assert.assertFalse(depot.useTickets(bus1, tickets));
            Assert.assertFalse(depot.expireTickets(bus1, tickets));
            Assert.assertFalse(depot.useTickets(bus2, tickets));
            Assert.assertFalse(depot.expireTickets(bus2, tickets));
        }

        {
            Assert.assertTrue(depot.boardBus(bus1, Set.of(ticket1)));
            Assert.assertTrue(depot.boardBus(bus2, Set.of(ticket2)));
            Assert.assertTrue(depot.useTickets(bus1, Set.of(ticket1)));
            Assert.assertTrue(depot.expireTickets(bus2, Set.of(ticket2)));

            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            tickets.add(ticket2);

            Assert.assertFalse(depot.useTickets(bus1, tickets));
            Assert.assertFalse(depot.expireTickets(bus1, tickets));
            Assert.assertFalse(depot.useTickets(bus2, tickets));
            Assert.assertFalse(depot.expireTickets(bus2, tickets));

            tickets.clear();
            tickets.add(ticket1);
            Assert.assertFalse(depot.useTickets(bus1, tickets));
            Assert.assertFalse(depot.expireTickets(bus1, tickets));
            Assert.assertFalse(depot.useTickets(bus2, tickets));
            Assert.assertFalse(depot.expireTickets(bus2, tickets));

            tickets.clear();
            tickets.add(ticket2);
            Assert.assertFalse(depot.useTickets(bus1, tickets));
            Assert.assertFalse(depot.expireTickets(bus1, tickets));
            Assert.assertFalse(depot.useTickets(bus2, tickets));
            Assert.assertFalse(depot.expireTickets(bus2, tickets));
        }

        bus1.stopThread();
        bus2.stopThread();

        Assert.assertFalse(bus1.didThrowException());
        Assert.assertEquals(Set.of(), bus1.getContents());

        Assert.assertFalse(bus2.didThrowException());
        Assert.assertEquals(Set.of(), bus2.getContents());
    }

    @Test
    public void testRemoveFromEmptyBussAsync() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(2);
        Bus bus2 = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

        Map<Result<Boolean>, Boolean> expected = new HashMap<>();

        {
            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            tickets.add(ticket2);

            expected.put(depot.useTicketsAsync(bus1, tickets), false);
            expected.put(depot.expireTicketsAsync(bus1, tickets), false);
            expected.put(depot.useTicketsAsync(bus2, tickets), false);
            expected.put(depot.expireTicketsAsync(bus2, tickets), false);
        }

        {
            expected.put(depot.boardBusAsync(bus1, Set.of(ticket1)), true);
            expected.put(depot.boardBusAsync(bus2, Set.of(ticket2)), true);
            expected.put(depot.useTicketsAsync(bus1, Set.of(ticket1)), true);
            expected.put(depot.expireTicketsAsync(bus2, Set.of(ticket2)), true);

            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            tickets.add(ticket2);

            expected.put(depot.useTicketsAsync(bus1, tickets), false);
            expected.put(depot.expireTicketsAsync(bus1, tickets), false);
            expected.put(depot.useTicketsAsync(bus2, tickets), false);
            expected.put(depot.expireTicketsAsync(bus2, tickets), false);
        }

        {
            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            expected.put(depot.useTicketsAsync(bus1, tickets), false);
            expected.put(depot.expireTicketsAsync(bus1, tickets), false);
            expected.put(depot.useTicketsAsync(bus2, tickets), false);
            expected.put(depot.expireTicketsAsync(bus2, tickets), false);
        }
        {

            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket2);
            expected.put(depot.useTicketsAsync(bus1, tickets), false);
            expected.put(depot.expireTicketsAsync(bus1, tickets), false);
            expected.put(depot.useTicketsAsync(bus2, tickets), false);
            expected.put(depot.expireTicketsAsync(bus2, tickets), false);
        }

        bus1.startThread();
        bus2.startThread();

        for (Map.Entry<Result<Boolean>, Boolean> entry : expected.entrySet()) {
            Assert.assertEquals(entry.getValue(), entry.getKey().getResult());
        }

        bus1.stopThread();
        bus2.stopThread();

        Assert.assertFalse(bus1.didThrowException());
        Assert.assertEquals(Set.of(), bus1.getContents());

        Assert.assertFalse(bus2.didThrowException());
        Assert.assertEquals(Set.of(), bus2.getContents());
    }



}
