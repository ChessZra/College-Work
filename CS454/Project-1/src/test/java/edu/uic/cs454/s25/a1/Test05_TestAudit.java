package edu.uic.cs454.s25.a1;

import org.junit.Assert;
import org.junit.Test;

import java.util.Arrays;
import java.util.List;
import java.util.Set;

public class Test05_TestAudit {

    // The audit order for multiple items in the same operation is undefined

    @Test
    public void testTicketAuditTicketsAdded() {
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
    public void testTicketAuditTicketsAddedRemoved() {
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
    public void testTicketAuditTicketsAddedMoved() {
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
    public void testTicketAuditTicketAddedMovedRemoved() {
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
    public void testBusesAuditTicketsAdded() {
        Depot l = Depot.createDepot();
        Bus bus1 = l.createBus(1);
        Bus bus2 = l.createBus(1);
        Ticket c1 = l.issueTicket(1);
        Ticket c2 = l.issueTicket(2);

        {
            Set<Ticket> toAdd = Set.of(c1);
            l.boardBus(bus1, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(c2);
            l.boardBus(bus2, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(c1);
            l.boardBus(bus2, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(c2);
            l.boardBus(bus1, toAdd);
        }

        Assert.assertEquals(List.of(new Action(Action.Direction.IN_CIRCULATION, c1)), l.audit(bus1));
        Assert.assertEquals(List.of(new Action(Action.Direction.IN_CIRCULATION, c2)), l.audit(bus2));
    }

    @Test
    public void testBusesAuditTicketsAddedRemoved() {
        Depot l = Depot.createDepot();
        Bus bus1 = l.createBus(1);
        Bus bus2 = l.createBus(1);
        Ticket c1 = l.issueTicket(1);
        Ticket c2 = l.issueTicket(2);

        {
            Set<Ticket> toAdd = Set.of(c1);
            l.boardBus(bus1, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(c2);
            l.boardBus(bus2, toAdd);
        }

        {
            Set<Ticket> toRemove = Set.of(c1);
            l.useTickets(bus1, toRemove);
        }

        {
            Set<Ticket> toRemove = Set.of(c2);
            l.expireTickets(bus2, toRemove);
        }

        Assert.assertEquals(
                List.of(
                        new Action(Action.Direction.IN_CIRCULATION,      c1),
                        new Action(Action.Direction.USED, c1)),
                l.audit(bus1));

        Assert.assertEquals(
                List.of(
                        new Action(Action.Direction.IN_CIRCULATION,   c2),
                        new Action(Action.Direction.EXPIRED, c2)),
                l.audit(bus2));
    }

    @Test
    public void testBusesAuditTicketsAddedMoved() {
        Depot l = Depot.createDepot();
        Bus bus1 = l.createBus(10);
        Bus bus2 = l.createBus(10);
        Ticket c1 = l.issueTicket(1);
        Ticket c2 = l.issueTicket(2);

        {
            Set<Ticket> toAdd = Set.of(c1);
            l.boardBus(bus1, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(c2);
            l.boardBus(bus2, toAdd);
        }

        {
            Set<Ticket> toMove = Set.of(c1);
            l.transferTickets(bus1, bus2, toMove);
        }

        {
            Set<Ticket> toMove = Set.of(c2);
            l.transferTickets(bus2, bus1, toMove);
        }

        Assert.assertEquals(
                List.of(
                        new Action(Action.Direction.IN_CIRCULATION,   c1),
                        new Action(Action.Direction.MOVED_OUT, c1),
                        new Action(Action.Direction.MOVED_IN,  c2)
                ),
                l.audit(bus1));

        Assert.assertEquals(
                List.of(
                        new Action(Action.Direction.IN_CIRCULATION,   c2),
                        new Action(Action.Direction.MOVED_IN,  c1),
                        new Action(Action.Direction.MOVED_OUT, c2)
                ),
                l.audit(bus2));
    }


    @Test
    public void testBusesAuditTicketsAddedMovedNotEnoughRoom() {
        Depot l = Depot.createDepot();
        Bus bus1 = l.createBus(2);
        Bus bus2 = l.createBus(1);
        Ticket c1 = l.issueTicket(1);
        Ticket c2 = l.issueTicket(2);

        {
            Set<Ticket> toAdd = Set.of(c1);
            l.boardBus(bus1, toAdd);
        }

        {
            Set<Ticket> toAdd = Set.of(c2);
            l.boardBus(bus2, toAdd);
        }

        {
            Set<Ticket> toMove = Set.of(c1);
            l.transferTickets(bus1, bus2, toMove);
        }

        {
            Set<Ticket> toMove = Set.of(c2);
            l.transferTickets(bus2, bus1, toMove);
        }

        Assert.assertEquals(
                List.of(
                        new Action(Action.Direction.IN_CIRCULATION,   c1),
                        new Action(Action.Direction.MOVED_IN,  c2)
                ),
                l.audit(bus1));

        Assert.assertEquals(
                List.of(
                        new Action(Action.Direction.IN_CIRCULATION,   c2),
                        new Action(Action.Direction.MOVED_OUT, c2)
                ),
                l.audit(bus2));
    }

    @Test
    public void testBusesAuditTicketsAddedMovedRemoved() {
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
}