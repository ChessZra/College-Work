package edu.uic.cs454.s25.a1.solution;

import edu.uic.cs454.s25.a1.Action;
import edu.uic.cs454.s25.a1.Depot;
import edu.uic.cs454.s25.a1.Ticket.Status;

import java.util.List;
import java.util.Set;
import java.util.HashSet;
import java.util.LinkedList;

public class DepotSolution extends Depot<BusSolution, TicketSolution> {

    private LinkedList<Action<BusTicket>> auditLog = new LinkedList<>();

    @Override
    public BusSolution createBus(int capacity) {
        BusSolution newBus = new BusSolution(capacity);
        return newBus;
    }
    
    @Override
    public TicketSolution issueTicket(int id) {
        TicketSolution newTicket = new TicketSolution(id, this);
        return newTicket;
    }
    
    @Override
    public synchronized boolean boardBus(BusSolution bus, Set<TicketSolution> tickets) {
        if (tickets.size() + bus.contents.size() > bus.capacity)
            return false;

        for (TicketSolution ticket : tickets) 
            if (ticket.status != Status.ISSUED) 
                return false;

        bus.contents.addAll(tickets);

        for (TicketSolution ticket : tickets) {
            ticket.status = Status.IN_CIRCULATION;
            BusTicket bt = new BusTicket(bus, ticket);
            auditLog.addLast(new Action<>(Action.Direction.IN_CIRCULATION, bt));
        }
        
        return true;
    }
    
    @Override
    public synchronized boolean transferTickets(BusSolution from, BusSolution to, Set<TicketSolution> tickets) {
        if (!from.contents.containsAll(tickets))
            return false;

        if (tickets.size() + to.contents.size() > to.capacity)
            return false;
 
        from.contents.removeAll(tickets);
        to.contents.addAll(tickets);

        for (TicketSolution ticket : tickets) {
            BusTicket bt = new BusTicket(from, ticket);
            auditLog.addLast(new Action<>(Action.Direction.MOVED_OUT, bt));      
        }

        for (TicketSolution ticket : tickets) {
            BusTicket bt = new BusTicket(to, ticket);
            auditLog.addLast(new Action<>(Action.Direction.MOVED_IN, bt));      
        }

        return true;
    }
    
    @Override
    public synchronized boolean useTickets(BusSolution bus, Set<TicketSolution> tickets) {  
        if (!bus.contents.containsAll(tickets))
            return false;
        
        for (TicketSolution ticket : tickets) {
            ticket.status = Status.USED;

            BusTicket bt = new BusTicket(bus, ticket);
            auditLog.addLast(new Action<>(Action.Direction.USED, bt));
        }

        bus.contents.removeAll(tickets);
        return true;
    }
    
    @Override
    public synchronized boolean expireTickets(BusSolution bus, Set<TicketSolution> tickets) {
        if (!bus.contents.containsAll(tickets))
            return false;
        
        for (TicketSolution ticket : tickets) {
            ticket.status = Status.EXPIRED;
            
            BusTicket bt = new BusTicket(bus, ticket);
            auditLog.addLast(new Action<>(Action.Direction.EXPIRED, bt));
        }

        bus.contents.removeAll(tickets);
        return true;
    }
    
    @Override
    public synchronized Set<TicketSolution> getTickets() {
        HashSet<TicketSolution> ret = new HashSet<>();
        for (Action<BusTicket> a : auditLog) {    
            switch (a.getDirection()) {
                case IN_CIRCULATION:
                case MOVED_IN:
                    ret.add(a.get().ticket);
                    break;
                case MOVED_OUT:
                case EXPIRED:
                case USED:
                    ret.remove(a.get().ticket);
                    break; 
                default:
                    throw new Error("Dead code");
            }
        }

        return ret;
    }
    
    @Override
    public synchronized Set<TicketSolution> getTickets(BusSolution bus) {
        HashSet<TicketSolution> ret = new HashSet<>();

        for (Action<BusTicket> a : auditLog) {
            if (a.get().bus == bus) {
                switch (a.getDirection()) {
                    case IN_CIRCULATION:
                    case MOVED_IN:
                        ret.add(a.get().ticket);
                        break;
                    case MOVED_OUT:
                    case EXPIRED:
                    case USED:
                        ret.remove(a.get().ticket);
                        break; 
                    default:
                        throw new Error("Dead code");
                }
            }
        }

        return ret;
    }

    @Override
    public List<Action<TicketSolution>> audit(BusSolution bus) {
        LinkedList<Action<TicketSolution>> ret = new LinkedList<>();

        for (Action<BusTicket> a : auditLog) 
            if (a.get().bus == bus) 
                ret.addLast(new Action<>(a.getDirection(), a.get().ticket));
            
        return ret;
    }

    @Override
    public List<Action<BusSolution>> audit(TicketSolution ticket) {
        LinkedList<Action<BusSolution>> ret = new LinkedList<>();

        for (Action<BusTicket> a : auditLog) 
            if (a.get().ticket == ticket) 
                ret.addLast(new Action<>(a.getDirection(), a.get().bus));
            
        return ret;
    }
} 
