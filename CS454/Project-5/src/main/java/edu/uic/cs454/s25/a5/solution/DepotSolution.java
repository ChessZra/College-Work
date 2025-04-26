package edu.uic.cs454.s25.a5.solution;

import edu.uic.cs454.s25.a5.Action;
import edu.uic.cs454.s25.a5.Depot;
import edu.uic.cs454.s25.a5.Ticket;

import java.util.HashSet;
import java.util.Set;

public class DepotSolution extends Depot<BusSolution, TicketSolution> {
    
    public LFUniversal log = new LFUniversal();

    @Override
    public BusSolution createBus(int capacity) {
        BusSolution newBus = new BusSolution(capacity);
        return newBus;
    }

    @Override
    public TicketSolution issueTicket(int id) { // id not used
        TicketSolution newTicket = new TicketSolution(log);
        return newTicket;
    }

    @Override
    public boolean boardBus(BusSolution bus, Set<TicketSolution> tickets) {
        int index = 0;
        while (true) {
            HashSet<TicketSolution> contents = new HashSet<>();
            Log value = log.getLog();
    
            // First, get all the data we need
            for (int i = index; i < value.contents.size(); i++) {
                index++;
                Action<BusTicket> a = value.contents.get(i);
                if (a.get().bus == bus) {
                    switch (a.getDirection()) {
                        case IN_CIRCULATION:
                        case MOVED_IN:
                            contents.add(a.get().ticket);
                            break;
                        case MOVED_OUT:
                        case EXPIRED:
                        case USED:
                            contents.remove(a.get().ticket);
                            break; 
                        default:
                            throw new Error("Dead code");
                    }
                }
            }

            // Validate
            {
                if (tickets.size() + contents.size() > bus.capacity)
                    return false;
    
                for (TicketSolution ticket : tickets) 
                    if (ticket.status != Ticket.Status.ISSUED) 
                        return false;
            }
        
            // Make the changes
            {
                Invocation invoc = new Invocation();
                invoc.message = "board";
                invoc.tickets.addAll(tickets);
                invoc.bus = bus;
                invoc.currentHead = value.currentHead;
                if (!log.apply(invoc)) continue;
            }
            
            return true;  
        }
    }

    @Override
    public boolean transferTickets(BusSolution from, BusSolution to, Set<TicketSolution> tickets) {
        int index = 0;
        while (true) {
            HashSet<TicketSolution> from_contents = new HashSet<>();
            HashSet<TicketSolution> to_contents = new HashSet<>();
            Log value = log.getLog();
            
            // First, get all the data we need
            for (int i = index; i < value.contents.size(); i++) {
                index++;
                Action<BusTicket> a = value.contents.get(i);
                if (a.get().bus == from) {
                    switch (a.getDirection()) {
                        case IN_CIRCULATION:
                        case MOVED_IN:
                            from_contents.add(a.get().ticket);
                            break;
                        case MOVED_OUT:
                        case EXPIRED:
                        case USED:
                            from_contents.remove(a.get().ticket);
                            break; 
                        default:
                            throw new Error("Dead code");
                    }
                } else if (a.get().bus == to) {
                    switch (a.getDirection()) {
                        case IN_CIRCULATION:
                        case MOVED_IN:
                            to_contents.add(a.get().ticket);
                            break;
                        case MOVED_OUT:
                        case EXPIRED:
                        case USED:
                            to_contents.remove(a.get().ticket);
                            break; 
                        default:
                            throw new Error("Dead code");
                    }
                }
            }
            
            // Validate
            {
                if (!from_contents.containsAll(tickets))
                    return false;
    
                if (tickets.size() + to_contents.size() > to.capacity)
                    return false;
            }
    
            // Make the changes
            {
                Invocation invoc = new Invocation();
                invoc.message = "transfer";
                invoc.tickets.addAll(tickets);
                invoc.from = from;
                invoc.to = to;
                invoc.currentHead = value.currentHead;
                if (!log.apply(invoc)) continue;
            }
    
            return true;  
        }
    }

    @Override
    public boolean useTickets(BusSolution bus, Set<TicketSolution> tickets) {
        int index = 0;
        while (true) {
            HashSet<TicketSolution> contents = new HashSet<>();
            Log value = log.getLog();

            // First, get all the data we need
            for (int i = index; i < value.contents.size(); i++) {
                index++;
                Action<BusTicket> a = value.contents.get(i);
                if (a.get().bus == bus) {
                    switch (a.getDirection()) {
                        case IN_CIRCULATION:
                        case MOVED_IN:
                            contents.add(a.get().ticket);
                            break;
                        case MOVED_OUT:
                        case EXPIRED:
                        case USED:
                            contents.remove(a.get().ticket);
                            break; 
                        default:
                            throw new Error("Dead code");
                    }
                }
            }
    
            // Validate
            {
                if (!contents.containsAll(tickets))
                    return false;
            }
    
            // Make the changes
            {
                Invocation invoc = new Invocation();
                invoc.message = "use";
                invoc.tickets.addAll(tickets);
                invoc.bus = bus;
                invoc.currentHead = value.currentHead;
                if (!log.apply(invoc)) continue;
            }
    
            return true;  
        }
    }

    @Override
    public boolean expireTickets(BusSolution bus, Set<TicketSolution> tickets) {
        int index = 0;
        while (true) {
            HashSet<TicketSolution> contents = new HashSet<>();
            Log value = log.getLog();

            // First, get all the data we need
            for (int i = index; i < value.contents.size(); i++) {
                index++;
                Action<BusTicket> a = value.contents.get(i);
                if (a.get().bus == bus) {
                    switch (a.getDirection()) {
                        case IN_CIRCULATION:
                        case MOVED_IN:
                            contents.add(a.get().ticket);
                            break;
                        case MOVED_OUT:
                        case EXPIRED:
                        case USED:
                            contents.remove(a.get().ticket);
                            break; 
                        default:
                            throw new Error("Dead code");
                    }
                }
            }
    
            // Validate
            {
                if (!contents.containsAll(tickets))
                    return false;
            }
    
            // Make the changes
            {
                Invocation invoc = new Invocation();
                invoc.message = "expire";
                invoc.tickets.addAll(tickets);
                invoc.bus = bus;
                invoc.currentHead = value.currentHead;
                if (!log.apply(invoc)) continue;
            }
    
            return true;  
        }
    }

    @Override
    public Set<TicketSolution> getTickets() {
        HashSet<TicketSolution> ret = new HashSet<>();
        for (Action<BusTicket> a : log.getLog().contents) {    
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
    public Set<TicketSolution> getTickets(BusSolution bus) {
        HashSet<TicketSolution> ret = new HashSet<>();
        for (Action<BusTicket> a : log.getLog().contents) {
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
}