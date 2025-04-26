package edu.uic.cs454.s25.a2;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Random;
import java.util.Set;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.junit.Assert;
import org.junit.Test;

public class Test06_DepotTestsFromA1 {
    @Test
    public void test01Identity() {
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
    public void test01MaxCapacity() {
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
    public void test01Tickets() {
        int size = 10;
        List<Integer> sequentialIndexes = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList = IntStream.range(0, size).boxed().collect(Collectors.toList());

        Collections.shuffle(shuffledIndexesList);

        test01RemoveTickets(sequentialIndexes);
        test01RemoveTickets(shuffledIndexesList);
    }

    public void test01RemoveTickets(List<Integer> indexes) {

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
    public void test01RemoveFromEmptyBus() {
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
    public void test01Set() {
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
    public void test01RemoveTicketsNotInBus() {
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
    public void test02CapacityAdd() {
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
    public void test02CapacitySameDescription() {
        int size = 10;
        List<Integer> sequentialIndexes = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList = IntStream.range(0, size).boxed().collect(Collectors.toList());

        Collections.shuffle(shuffledIndexesList);

        test02CapacitySameDescription(sequentialIndexes);
        test02CapacitySameDescription(shuffledIndexesList);
    }

    @Test
    public void test02ModifiableSet() {
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

    public void test02CapacitySameDescription(List<Integer> indexes) {
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
    public void test02RemoveFromBus() {
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
    public void test02RemoveFromEmptyBus() {
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
    public void test02RemoveTicketNotInBus() {
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
    public void test02TicketChangesCorrectly() {
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

    @Test
    public void test03MaxCapacity() {
        Depot depot = Depot.createDepot();
        int test = 20;
        Bus[] buses = new Bus[10];

        for (int i = 0; i < buses.length ; i++)
            buses[i] = depot.createBus(i+1);

        int count = 0;

        for (int i = 0 ; i < test ; i++) {
            for (int j = 0; i < buses.length ; i++) {
                Bus bus = buses[j];
                Ticket ticket = depot.issueTicket(count++);
                Set<Ticket> toAdd = new HashSet<>();
                toAdd.add(ticket);

                if (i <= j)
                    Assert.assertTrue(depot.boardBus(bus, toAdd));
                else
                    Assert.assertFalse(depot.boardBus(bus, toAdd));
            }
        }
    }

    @Test
    public void moveTicketsEmptyBus() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(2);
        Bus bus2 = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);
        Ticket ticket3 = depot.issueTicket(3);
        Ticket ticket4 = depot.issueTicket(4);

        Set<Ticket> toAdd = Set.of(ticket1, ticket2);
        Assert.assertTrue(depot.boardBus(bus1, toAdd));

        Set<Ticket> toMove = Set.of(ticket1, ticket2);
        Assert.assertTrue(depot.transferTickets(bus1, bus2, toMove));
        Assert.assertFalse(depot.expireTickets(bus1, toMove));
        Assert.assertFalse(depot.useTickets(bus1, toMove));

        Set<Ticket> toAddMore = Set.of(ticket3, ticket4);
        Assert.assertTrue(depot.boardBus(bus1, toAddMore));
        Assert.assertTrue(depot.expireTickets(bus2, toMove));
    }

    @Test
    public void test03NoRoomInDestination() {
        Depot depot = Depot.createDepot();
        Bus from = depot.createBus(1);
        Bus to = depot.createBus(1);

        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

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

    }

    @Test
    public void test03RemoveFromBus() {
        int size = 10;
        List<Integer> sequentialIndexes = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList1 = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList2 = IntStream.range(0, size).boxed().collect(Collectors.toList());

        Collections.shuffle(shuffledIndexesList1);
        Collections.shuffle(shuffledIndexesList2);

        test03RemoveFromBus(sequentialIndexes, sequentialIndexes);
        test03RemoveFromBus(shuffledIndexesList1, shuffledIndexesList2);
    }

    public void test03RemoveFromBus(List<Integer> ticketIndexes, List<Integer> ticketsIndexes) {

        Depot depot = Depot.createDepot();
        int size = ticketIndexes.size();
        Bus[] buses = new Bus[ticketsIndexes.size()];

        for (int i = 0; i < buses.length ; i++)
            buses[i] = depot.createBus(size);

        Ticket[] tickets = new Ticket[size];
        for (int i = 0 ; i < size ; i++)
            tickets[i] = depot.issueTicket(i);

        for (int i : ticketIndexes) {
            Set<Ticket> toAdd = new HashSet<>();
            Bus bus1 = buses[ticketsIndexes.get(i)];
            Bus bus2 = buses[ticketsIndexes.get((i+1)%ticketsIndexes.size())];
            toAdd.add(tickets[i]);
            Assert.assertFalse(depot.expireTickets(bus1, toAdd));
            Assert.assertFalse(depot.useTickets(bus2, toAdd));

            Assert.assertTrue(depot.boardBus(bus1, toAdd));

            Assert.assertFalse(depot.expireTickets(bus2, toAdd));
            Assert.assertFalse(depot.useTickets(bus2, toAdd));

            switch (i%2) {
                case 0:
                    Assert.assertTrue(depot.useTickets(bus1, toAdd));
                    break;
                case 1:
                    Assert.assertTrue(depot.expireTickets(bus1, toAdd));
                    break;
                default:
                    throw new Error("Dead code");
            }
        }
    }

    @Test
    public void test03RemoveFromEmptyBus() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(2);
        Bus bus2 = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

        {
            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            tickets.add(ticket2);

            Assert.assertFalse(depot.expireTickets(bus1, tickets));
            Assert.assertFalse(depot.useTickets(bus1, tickets));
            Assert.assertFalse(depot.expireTickets(bus2, tickets));
            Assert.assertFalse(depot.useTickets(bus2, tickets));
        }

        {
            Assert.assertTrue(depot.boardBus(bus1, Set.of(ticket1)));
            Assert.assertTrue(depot.boardBus(bus2, Set.of(ticket2)));
            Assert.assertTrue(depot.expireTickets(bus1, Set.of(ticket1)));
            Assert.assertTrue(depot.useTickets(bus2, Set.of(ticket2)));

            Set<Ticket> tickets = new HashSet<>();
            tickets.add(ticket1);
            tickets.add(ticket2);

            Assert.assertFalse(depot.expireTickets(bus1, tickets));
            Assert.assertFalse(depot.useTickets(bus1, tickets));
            Assert.assertFalse(depot.expireTickets(bus2, tickets));
            Assert.assertFalse(depot.useTickets(bus2, tickets));

            tickets.clear();
            tickets.add(ticket1);
            Assert.assertFalse(depot.expireTickets(bus1, tickets));
            Assert.assertFalse(depot.useTickets(bus1, tickets));
            Assert.assertFalse(depot.expireTickets(bus2, tickets));
            Assert.assertFalse(depot.useTickets(bus2, tickets));

            tickets.clear();
            tickets.add(ticket2);
            Assert.assertFalse(depot.expireTickets(bus1, tickets));
            Assert.assertFalse(depot.useTickets(bus1, tickets));
            Assert.assertFalse(depot.expireTickets(bus2, tickets));
            Assert.assertFalse(depot.useTickets(bus2, tickets));
        }
    }

    @Test
    public void moveTicketToFullBus() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(2);
        Bus bus2 = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);
        Ticket ticket3 = depot.issueTicket(3);
        Ticket ticket4 = depot.issueTicket(4);

        Set<Ticket> toAdd = Set.of(ticket1, ticket2);
        Assert.assertTrue(depot.boardBus(bus1, toAdd));

        Set<Ticket> toAddMore = Set.of(ticket3, ticket4);
        Assert.assertTrue(depot.boardBus(bus2, toAddMore));

        Set<Ticket> toMove = Set.of(ticket1, ticket2);
        Assert.assertFalse(depot.transferTickets(bus1, bus2, toMove));


        Assert.assertTrue(depot.expireTickets(bus2, Set.of(ticket4)));
        Assert.assertFalse(depot.transferTickets(bus1, bus2, toMove));
        Assert.assertTrue(depot.transferTickets(bus1, bus2, Set.of(ticket1)));
    }


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
    public void test04CapacityDuplicatedTicket() {
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
    public void test04TicketAlreadyInBus() {
        int size = 10;
        List<Integer> sequentialIndexes = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList = IntStream.range(0, size).boxed().collect(Collectors.toList());

        Collections.shuffle(shuffledIndexesList);

        test04TicketAlreadyInBus(sequentialIndexes);
        test04TicketAlreadyInBus(shuffledIndexesList);
    }

    private void test04TicketAlreadyInBus(List<Integer> indexes) {
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
    public void test04CannotReuseTickets() {
        int size = 10;
        List<Integer> sequentialIndexes = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList = IntStream.range(0, size).boxed().collect(Collectors.toList());

        Collections.shuffle(shuffledIndexesList);

        test04CannotReuseTickets(sequentialIndexes);
        test04CannotReuseTickets(shuffledIndexesList);
    }

    public void test04CannotReuseTickets(List<Integer> indexes) {
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
    public void test04TicketAlreadyInDepot() {
        int size = 10;
        List<Integer> sequentialIndexes = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList1 = IntStream.range(0, size).boxed().collect(Collectors.toList());
        List<Integer> shuffledIndexesList2 = IntStream.range(0, size).boxed().collect(Collectors.toList());

        Collections.shuffle(shuffledIndexesList1);
        Collections.shuffle(shuffledIndexesList2);

        test04TicketAlreadyInDepot(sequentialIndexes, sequentialIndexes);
        test04TicketAlreadyInDepot(shuffledIndexesList1, shuffledIndexesList2);
    }

    private void test04TicketAlreadyInDepot(List<Integer> ticketsIndexes, List<Integer> busesIndexes) {
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
    public void test04CapacityAdd() {
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
    public void test04CapacityDuplicatedTickets() {
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
    public void test04RemoveFromBus() {
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
    public void test04RemoveFromEmptyBus() {
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
    public void test04RemoveTicketNotInBus() {
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

    @Test
    public void test05TicketAuditTicketsAdded() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(1);
        Bus bus2 = depot.createBus(1);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

        {
            Set<Ticket> toAdd = Set.of(ticket1);
            depot.boardBus(bus1, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(ticket2);
            depot.boardBus(bus2, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(ticket1);
            depot.boardBus(bus2, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(ticket2);
            depot.boardBus(bus1, toAdd);
        }

        Assert.assertEquals(List.of(new Action(Action.Direction.IN_CIRCULATION, bus1)), depot.audit(ticket1));
        Assert.assertEquals(List.of(new Action(Action.Direction.IN_CIRCULATION, bus2)), depot.audit(ticket2));
    }

    @Test
    public void test05TicketAuditTicketsAddedRemoved() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(1);
        Bus bus2 = depot.createBus(1);
        Bus bus3 = depot.createBus(1);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);
        Ticket ticket3 = depot.issueTicket(3);

        {
            Set<Ticket> toAdd = Set.of(ticket1);
            depot.boardBus(bus1, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(ticket2);
            depot.boardBus(bus2, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(ticket3);
            depot.boardBus(bus3, toAdd);
        }

        {
            Set<Ticket> toRemove = Set.of(ticket1);
            depot.useTickets(bus1, toRemove);
        }

        {
            Set<Ticket> toRemove = Set.of(ticket2);
            depot.expireTickets(bus2, toRemove);
        }

        Assert.assertEquals(
                List.of(
                        new Action(Action.Direction.IN_CIRCULATION,  bus1),
                        new Action(Action.Direction.USED, bus1)),
                depot.audit(ticket1));

        Assert.assertEquals(
                List.of(
                        new Action(Action.Direction.IN_CIRCULATION, bus2),
                        new Action(Action.Direction.EXPIRED, bus2)),
                depot.audit(ticket2));

        Assert.assertEquals(
                List.of(
                        new Action(Action.Direction.IN_CIRCULATION, bus3)),
                depot.audit(ticket3));
    }

    @Test
    public void test05TicketAuditTicketsAddedMoved() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(2);
        Bus bus2 = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

        {
            Set<Ticket> toAdd = Set.of(ticket1);
            depot.boardBus(bus1, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(ticket2);
            depot.boardBus(bus2, toAdd);
        }

        {
            Set<Ticket> toMove = Set.of(ticket1);
            depot.transferTickets(bus1, bus2, toMove);
        }

        {
            Set<Ticket> toMove = Set.of(ticket2);
            depot.transferTickets(bus2, bus1, toMove);
        }

        Assert.assertEquals(
                List.of(
                        new Action(Action.Direction.IN_CIRCULATION,   bus1),
                        new Action(Action.Direction.MOVED_OUT, bus1),
                        new Action(Action.Direction.MOVED_IN,  bus2)
                ),
                depot.audit(ticket1));

        Assert.assertEquals(
                Arrays.asList(
                        new Action(Action.Direction.IN_CIRCULATION,   bus2),
                        new Action(Action.Direction.MOVED_OUT, bus2),
                        new Action(Action.Direction.MOVED_IN,  bus1)
                ),
                depot.audit(ticket2));
    }

    @Test
    public void test05TicketAuditTicketAddedMovedRemoved() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(2);
        Bus bus2 = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

        {
            Set<Ticket> toAdd = Set.of(ticket1);
            depot.boardBus(bus1, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(ticket2);
            depot.boardBus(bus2, toAdd);
        }

        {
            Set<Ticket> toMove = Set.of(ticket1);
            depot.transferTickets(bus1, bus2, toMove);
        }

        {
            Set<Ticket> toMove = Set.of(ticket2);
            depot.transferTickets(bus2, bus1, toMove);
        }

        {
            Set<Ticket> toRemove = Set.of(ticket1);
            depot.useTickets(bus2, toRemove);
        }

        {
            Set<Ticket> toRemove = Set.of(ticket2);
            depot.expireTickets(bus1, toRemove);
        }

        Assert.assertEquals(
                Arrays.asList(
                        new Action(Action.Direction.IN_CIRCULATION,      bus1),
                        new Action(Action.Direction.MOVED_OUT,    bus1),
                        new Action(Action.Direction.MOVED_IN,     bus2),
                        new Action(Action.Direction.USED, bus2)
                ),
                depot.audit(ticket1));

        Assert.assertEquals(
                Arrays.asList(
                        new Action(Action.Direction.IN_CIRCULATION,   bus2),
                        new Action(Action.Direction.MOVED_OUT, bus2),
                        new Action(Action.Direction.MOVED_IN,  bus1),
                        new Action(Action.Direction.EXPIRED, bus1)
                ),
                depot.audit(ticket2));
    }

    @Test
    public void test05BusesAuditTicketsAdded() {
        Depot l = Depot.createDepot();
        Bus w1 = l.createBus(1);
        Bus w2 = l.createBus(1);
        Ticket c1 = l.issueTicket(1);
        Ticket c2 = l.issueTicket(2);

        {
            Set<Ticket> toAdd = Set.of(c1);
            l.boardBus(w1, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(c2);
            l.boardBus(w2, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(c1);
            l.boardBus(w2, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(c2);
            l.boardBus(w1, toAdd);
        }

        Assert.assertEquals(List.of(new Action(Action.Direction.IN_CIRCULATION, c1)), l.audit(w1));
        Assert.assertEquals(List.of(new Action(Action.Direction.IN_CIRCULATION, c2)), l.audit(w2));
    }

    @Test
    public void test05BusesAuditTicketsAddedRemoved() {
        Depot l = Depot.createDepot();
        Bus w1 = l.createBus(1);
        Bus w2 = l.createBus(1);
        Ticket c1 = l.issueTicket(1);
        Ticket c2 = l.issueTicket(2);

        {
            Set<Ticket> toAdd = Set.of(c1);
            l.boardBus(w1, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(c2);
            l.boardBus(w2, toAdd);
        }

        {
            Set<Ticket> toRemove = Set.of(c1);
            l.useTickets(w1, toRemove);
        }

        {
            Set<Ticket> toRemove = Set.of(c2);
            l.expireTickets(w2, toRemove);
        }

        Assert.assertEquals(
                List.of(
                        new Action(Action.Direction.IN_CIRCULATION,      c1),
                        new Action(Action.Direction.USED, c1)),
                l.audit(w1));

        Assert.assertEquals(
                List.of(
                        new Action(Action.Direction.IN_CIRCULATION,   c2),
                        new Action(Action.Direction.EXPIRED, c2)),
                l.audit(w2));
    }

    @Test
    public void test05BusesAuditTicketsAddedMoved() {
        Depot l = Depot.createDepot();
        Bus w1 = l.createBus(10);
        Bus w2 = l.createBus(10);
        Ticket c1 = l.issueTicket(1);
        Ticket c2 = l.issueTicket(2);

        {
            Set<Ticket> toAdd = Set.of(c1);
            l.boardBus(w1, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(c2);
            l.boardBus(w2, toAdd);
        }

        {
            Set<Ticket> toMove = Set.of(c1);
            l.transferTickets(w1, w2, toMove);
        }

        {
            Set<Ticket> toMove = Set.of(c2);
            l.transferTickets(w2, w1, toMove);
        }

        Assert.assertEquals(
                List.of(
                        new Action(Action.Direction.IN_CIRCULATION,   c1),
                        new Action(Action.Direction.MOVED_OUT, c1),
                        new Action(Action.Direction.MOVED_IN,  c2)
                ),
                l.audit(w1));

        Assert.assertEquals(
                List.of(
                        new Action(Action.Direction.IN_CIRCULATION,   c2),
                        new Action(Action.Direction.MOVED_IN,  c1),
                        new Action(Action.Direction.MOVED_OUT, c2)
                ),
                l.audit(w2));
    }


    @Test
    public void test05BusesAuditTicketsAddedMovedNotEnoughRoom() {
        Depot l = Depot.createDepot();
        Bus w1 = l.createBus(2);
        Bus w2 = l.createBus(1);
        Ticket c1 = l.issueTicket(1);
        Ticket c2 = l.issueTicket(2);

        {
            Set<Ticket> toAdd = Set.of(c1);
            l.boardBus(w1, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(c2);
            l.boardBus(w2, toAdd);
        }

        {
            Set<Ticket> toMove = Set.of(c1);
            l.transferTickets(w1, w2, toMove);
        }

        {
            Set<Ticket> toMove = Set.of(c2);
            l.transferTickets(w2, w1, toMove);
        }

        Assert.assertEquals(
                List.of(
                        new Action(Action.Direction.IN_CIRCULATION,   c1),
                        new Action(Action.Direction.MOVED_IN,  c2)
                ),
                l.audit(w1));

        Assert.assertEquals(
                List.of(
                        new Action(Action.Direction.IN_CIRCULATION,   c2),
                        new Action(Action.Direction.MOVED_OUT, c2)
                ),
                l.audit(w2));
    }

    @Test
    public void test05BusesAuditTicketsAddedMovedRemoved() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(2);
        Bus bus2 = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

        {
            Set<Ticket> toAdd = Set.of(ticket1);
            depot.boardBus(bus1, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(ticket2);
            depot.boardBus(bus2, toAdd);
        }

        {
            Set<Ticket> toMove = Set.of(ticket1);
            depot.transferTickets(bus1, bus2, toMove);
        }

        {
            Set<Ticket> toMove = Set.of(ticket2);
            depot.transferTickets(bus2, bus1, toMove);
        }

        {
            Set<Ticket> toRemove = Set.of(ticket1);
            depot.useTickets(bus2, toRemove);
        }

        {
            Set<Ticket> toRemove = Set.of(ticket2);
            depot.expireTickets(bus1, toRemove);
        }

        Assert.assertEquals(
                Arrays.asList(
                        new Action(Action.Direction.IN_CIRCULATION,   ticket1),
                        new Action(Action.Direction.MOVED_OUT, ticket1),
                        new Action(Action.Direction.MOVED_IN,  ticket2),
                        new Action(Action.Direction.EXPIRED, ticket2)
                ),
                depot.audit(bus1));

        Assert.assertEquals(
                Arrays.asList(
                        new Action(Action.Direction.IN_CIRCULATION,      ticket2),
                        new Action(Action.Direction.MOVED_IN,     ticket1),
                        new Action(Action.Direction.MOVED_OUT,    ticket2),
                        new Action(Action.Direction.USED, ticket1)
                ),
                depot.audit(bus2));
    }

    @Test
    public void test06Add() {
        Depot depot = Depot.createDepot();

        Bus[] buses = new Bus[10];
        int size = 100;

        for (int i = 0; i < buses.length ; i++)
            buses[i] = depot.createBus(size);

        Thread[] threads = new Thread[10];
        Set<Ticket>[] allTickets = new Set[threads.length];

        for (int i = 0 ; i < threads.length ; i++) {
            int threadID = i;
            allTickets[i] = new HashSet<>();
            threads[i] = new Thread(() -> {
                Random rnd = new Random();
                for (int j = 0 ; j < size ; j++) {
                    Ticket tickets = depot.issueTicket(threadID*size + j);
                    Set<Ticket> ticketss = Set.of(tickets);
                    allTickets[threadID].add(tickets);
                    while (true) {
                        // Pick a bus at random
                        Bus bus = buses[rnd.nextInt(buses.length)];
                        // TestingSite is full or add failed
                        if (depot.getTickets(bus).size() == size || !depot.boardBus(bus, ticketss))
                            // Try again on another bus
                            continue;
                        break;
                    }
                }
            });
        }

        runAllThreads(threads);

        Assert.assertEquals(size* buses.length, depot.getTickets().size());

        Set<Ticket> expectedAllTickets = new HashSet<>();
        for (int i = 0 ; i < threads.length ; i++)
            expectedAllTickets.addAll(allTickets[i]);

        Assert.assertEquals(expectedAllTickets, depot.getTickets());

        Set<Ticket> ticketsOnBuses = new HashSet<>();
        for (int i = 0; i < buses.length ; i++)
            ticketsOnBuses.addAll(depot.getTickets(buses[i]));

        Assert.assertEquals(expectedAllTickets, ticketsOnBuses);
    }

    // Each thread (out of 10 threads) removes 100 tickets from depot with 1000 tickets
    @Test
    public void test06Remove() {
        Depot depot = Depot.createDepot();

        Bus[] buses = new Bus[10];
        int size = 100;

        for (int i = 0; i < buses.length ; i++) {
            buses[i] = depot.createBus(size);
            Set<Ticket> ticketss = new HashSet<>();
            for (int j = 0 ; j < size ; j++) {
                Ticket tickets = depot.issueTicket(i*size + j);
                ticketss.add(tickets);
            }
            depot.boardBus(buses[i], ticketss);
        }

        Thread[] threads = new Thread[10];
        Set<Ticket>[] allTickets = new Set[threads.length];

        for (int i = 0 ; i < threads.length ; i++) {
            int threadID = i;
            allTickets[i] = new HashSet<>();
            threads[i] = new Thread(() -> {
                Random rnd = new Random();
                int removed = 0;
                while (removed < size) {
                    Bus s = buses[rnd.nextInt(buses.length)];
                    // Get any tickets
                    Optional<Ticket> tickets = depot.getTickets(s).stream().findAny();
                    if (!tickets.isPresent())
                        continue;

                    boolean result;
                    if (removed%2 == 0)
                        result = depot.useTickets(s, Set.of(tickets.get()));
                    else
                        result = depot.expireTickets(s, Set.of(tickets.get()));

                    if (result)
                        removed++;
                }
            });
        }

        runAllThreads(threads);

        Assert.assertEquals(0, depot.getTickets().size());
        Assert.assertEquals(Set.of(), depot.getTickets());

        for (int i = 0; i < buses.length ; i++)
            Assert.assertEquals(Set.of(), depot.getTickets(buses[i]));

    }

    /*default*/ static void runAllThreads(Thread[] threads) {

        AtomicBoolean exceptionThrown = new AtomicBoolean(false);

        // Uncaught exceptions cause tests to fail
        for (int i = 0 ; i < threads.length ; i++) {
            threads[i].setUncaughtExceptionHandler((t,ex) -> {
                System.err.println(ex.getMessage());
                ex.printStackTrace();
                exceptionThrown.set(true);
            });
        }

        // Start all threads
        for (int i = 0 ; i < threads.length ; i++)
            threads[i].start();

        // Wait for all threads to finish
        for (int i = 0 ; i < threads.length ; i++) {
            while (threads[i].isAlive()) {
                try {
                    threads[i].join();
                } catch (InterruptedException e) {
                    continue;
                }
            }
        }

        // Make sure no thread threw an exception
        Assert.assertFalse(exceptionThrown.get());
    }

    @Test
    public void test07Move() {
        int n = 5;
        Depot depot = Depot.createDepot();

        Thread[] threads = new Thread[8];

        Bus[] buses = new Bus[10];
        int size = 2 * n;

        Ticket[] tickets = new Ticket[buses.length * n];

        for (int i = 0; i < buses.length ; i++) {
            buses[i] = depot.createBus(size);
            for (int j = 0 ; j < n ; j++) {
                int ticketNo = i * n + j;
                Ticket ticket = depot.issueTicket(ticketNo);
                tickets[ticketNo] = ticket;
                depot.boardBus(buses[i], Set.of(ticket));
            }
        }

        for (int i = 0 ; i < threads.length ; i++) {
            threads[i] = new Thread(() -> {
                Random r = new Random();
                for (int j = 0 ; j < 10_000 ; j++) {
                    int from = r.nextInt(buses.length);
                    int to   = r.nextInt(buses.length);
                    Optional<Ticket> ticketsToMove = depot.getTickets(buses[from]).stream().findAny();
                    if (ticketsToMove.isPresent())
                        depot.transferTickets(buses[from], buses[to], Set.of(ticketsToMove.get()));
                }
            });
        }


        Set<Ticket> expectedAllTickets = new HashSet<>(Set.of(tickets));
        Assert.assertEquals(expectedAllTickets, depot.getTickets());

        runAllThreads(threads);

        // Everything that was in the depot is still there
        Assert.assertEquals(expectedAllTickets, depot.getTickets());

        for (Bus s : buses) {
            for (Object i : depot.getTickets(s)) {
                // Each ticket is in only one bus
                Assert.assertTrue(expectedAllTickets.remove(i));
            }
        }

        // The contents of all tickets are everything that las in the depot
        Assert.assertTrue(expectedAllTickets.isEmpty());
    }

}
