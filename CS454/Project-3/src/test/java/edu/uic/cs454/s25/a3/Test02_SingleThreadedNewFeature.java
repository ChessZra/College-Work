package edu.uic.cs454.s25.a3;

import org.junit.Assert;
import org.junit.Test;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Test02_SingleThreadedNewFeature {

    @Test
    public void testNoRoomInDestination() {
        Depot depot = Depot.createDepot();
        Bus from = depot.createBus(1);
        Bus to = depot.createBus(1);

        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

        depot.boardBus(from, Set.of(ticket1));
        depot.boardBus(to, Set.of(ticket2));

        {
            Set<Ticket> expected = Set.of(ticket1,ticket2);
            Assert.assertEquals(expected, depot.getTickets(List.of(to, from)));
        }

        Assert.assertFalse(depot.transferTickets(from, to, Set.of(ticket1)));

        {
            Set<Ticket> expected = Set.of(ticket1, ticket2);
            Assert.assertEquals(expected, depot.getTickets(List.of(from, to)));
        }

    }

    @Test
    public void testCapacityAdd() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(1);
        Bus bus2 = depot.createBus(10);
        Bus bus3 = depot.createBus(1);
        Bus bus4 = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);
        Ticket ticket3 = depot.issueTicket(3);
        Ticket ticket4 = depot.issueTicket(4);
        Ticket ticket5 = depot.issueTicket(5);

        {
            depot.boardBus(bus3, Set.of(ticket3));
            depot.boardBus(bus4, Set.of(ticket4));
            depot.boardBus(bus4, Set.of(ticket5));
        }

        {
            Set<Ticket> toAdd = Set.of(ticket1,ticket2);
            depot.boardBus(bus1, toAdd);

            Set<Ticket> expected = Set.of(ticket3, ticket4, ticket5);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(Set.of(), depot.getTickets(bus1));
            Assert.assertEquals(Set.of(), depot.getTickets(bus2));
        }

        {
            Set<Ticket> toAdd = new HashSet<>();
            toAdd.add(ticket1);
            depot.boardBus(bus1, toAdd);
            toAdd.clear();
            toAdd.add(ticket2);
            depot.boardBus(bus1, toAdd);

            Assert.assertEquals(Set.of(ticket1), depot.getTickets(bus1));
            Assert.assertEquals(Set.of(), depot.getTickets(bus2));
            Assert.assertEquals(Set.of(ticket1,ticket3), depot.getTickets(List.of(bus1,bus2,bus3)));
            Assert.assertEquals(Set.of(ticket1,ticket3,ticket4,ticket5), depot.getTickets(List.of(bus1,bus2,bus3,bus4)));
            Assert.assertEquals(Set.of(ticket3,ticket4,ticket5), depot.getTickets(List.of(bus2,bus3,bus4)));
            Assert.assertEquals(Set.of(ticket1,ticket3,ticket4,ticket5), depot.getTickets(List.of(bus3,bus4,bus1)));
            Assert.assertEquals(Set.of(ticket3,ticket4,ticket5), depot.getTickets(List.of(bus4,bus3)));
            Assert.assertEquals(Set.of(ticket1,ticket3,ticket4,ticket5), depot.getTickets());
        }
    }

    @Test
    public void testCapacityDuplicatedTicket() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(10);
        Bus bus2 = depot.createBus(10);
        Bus bus3 = depot.createBus(10);
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
            Assert.assertEquals(expected, depot.getTickets(List.of(bus2, bus1)));
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
            Assert.assertEquals(expected, depot.getTickets(List.of(bus2,bus1)));
            Assert.assertEquals(expected, depot.getTickets(List.of(bus2,bus1,bus3)));
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
            Assert.assertEquals(expected, depot.getTickets(List.of(bus1,bus2)));
            Assert.assertEquals(expected, depot.getTickets(List.of(bus3,bus1,bus2)));
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
            depot.expireTickets(bus1, tickets);

            Set<Ticket> expected = Set.of();
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus1));
            Assert.assertEquals(expected, depot.getTickets(bus2));
            Assert.assertEquals(expected, depot.getTickets(List.of(bus1,bus2)));
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
            Assert.assertEquals(Set.of(ticket3,ticket2), depot.getTickets(List.of(bus2,bus1)));

            tickets.clear();
            tickets.add(ticket2);
            depot.expireTickets(bus2, tickets);

            expected = Set.of(ticket3);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus1));
            Assert.assertEquals(Set.of(), depot.getTickets(bus2));
            Assert.assertEquals(expected, depot.getTickets(List.of(bus2,bus1)));
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
            Assert.assertEquals(expected, depot.getTickets(List.of(bus2,bus1)));
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
            Assert.assertEquals(expected, depot.getTickets(List.of(bus1,bus2)));

            tickets.clear();
            tickets.add(ticket2);
            depot.expireTickets(bus1, tickets);
            depot.useTickets(bus2, tickets);
            Assert.assertEquals(expected, depot.getTickets());
            Assert.assertEquals(expected, depot.getTickets(bus1));
            Assert.assertEquals(expected, depot.getTickets(bus2));
            Assert.assertEquals(expected, depot.getTickets(List.of(bus1,bus2)));
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
            Assert.assertEquals(expected, depot.getTickets(List.of(bus2,bus1)));
        }
    }
}
