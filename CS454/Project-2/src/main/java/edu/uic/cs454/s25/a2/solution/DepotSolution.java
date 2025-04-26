package edu.uic.cs454.s25.a2.solution;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import edu.uic.cs454.s25.a2.Action;
import edu.uic.cs454.s25.a2.Depot;
import edu.uic.cs454.s25.a2.Ticket.Status;

public class DepotSolution extends Depot<BusSolution, TicketSolution> {

    Set<Integer> issuedTickets;
    Set<BusSolution> allBusses;
    LockSolution allBussesLock;
    LockSolution issuedTicketsLock;
    LockSolution DepotLock; // this lock

    public DepotSolution() {
        issuedTickets = new HashSet<Integer>();
        allBusses = new HashSet<BusSolution>();
        allBussesLock = new LockSolution();
        DepotLock = new LockSolution();
        issuedTicketsLock = new LockSolution();
    }

    private boolean checkIfTicketsAreValid(Set<TicketSolution> tickets) {
        // None of the tickets should be EXPIRED or USED
        for (TicketSolution ticket : tickets) {
            if (ticket.getStatus() == Status.EXPIRED || ticket.getStatus() == Status.USED) {
                System.out.println("DEBUG: boarding failed - expired/used ticket");
                return false;
            }
        }
        return true;
    }

    private void updateTicketAudit(BusSolution bus, Set<TicketSolution> tickets, Action.Direction direction) {
        // For each ticket in tickets, add the bus there!
        for (TicketSolution ticket : tickets) {
            ticket.updateAudit(direction, bus);
        }
    }

    private void updateBussesAudit(BusSolution bus, Set<TicketSolution> tickets, Action.Direction direction) {
        // For each ticket in tickets, add it to bus' audit's.
        for (TicketSolution ticket : tickets) {
            bus.updateAudit(direction, ticket);
        }
    }

    @Override
    public BusSolution createBus(int capacity) {
        BusSolution newBus = new BusSolution(capacity);

        // Possible data race if the operation is not fast enough
        allBussesLock.lock();
        try {
            allBusses.add(newBus);
        } finally {
            allBussesLock.unlock();
        }

        return newBus;
    }   
    
    @Override
    public TicketSolution issueTicket(int id) {
   
        System.out.println("DEBUG: Issuing a ticket with id: " + id);
        if (issuedTickets.contains(id)) {
            throw new Error("Ticket that's been issued is requested");
        }
        TicketSolution newTicket = new TicketSolution(id, DepotLock);

        // Possible data race if the operation is not fast enough
        issuedTicketsLock.lock();
        try {
            issuedTickets.add(id);
        } finally {
            issuedTicketsLock.unlock();
        }

        return newTicket;
    }
    
    @Override
    public boolean boardBus(BusSolution bus, Set<TicketSolution> tickets) {
        DepotLock.lock();
        try {
            if (!checkIfTicketsAreValid(tickets)) return false;
            
            Set<TicketSolution> intersection = this.getTickets();
            intersection.retainAll(tickets);
            if (intersection.size() > 0) {
                System.out.println("DEBUG: boarding failed - ticket is already in a bus.");
                return false;
            }
            
            System.out.println("DEBUG boardBus: Size of the set is " + tickets.size());
            System.out.println("DEBUG boardBus: bus capacity is " + bus.getCapacity());
            
            if (!bus.board(tickets)) return false;
    
            for (TicketSolution ticket : tickets) {
                ticket.setStatus(Status.IN_CIRCULATION);
            }
            
            updateTicketAudit(bus, tickets, Action.Direction.IN_CIRCULATION);
            updateBussesAudit(bus, tickets, Action.Direction.IN_CIRCULATION);
    
            return true;
        } finally {
            DepotLock.unlock();
        }
    }
    
    @Override
    public boolean transferTickets(BusSolution from, BusSolution to, Set<TicketSolution> tickets) {
        DepotLock.lock();
        
        try {
            for (TicketSolution ticket : tickets) {
                if (!from.getAllTicketsInTheBus().contains(ticket)) {
                    System.out.println("Attempted transfer but some passengers are missing from the from bus.");
                    return false;
                }
            }
    
            if (!checkIfTicketsAreValid(tickets)) return false;
    
            if (!to.board(tickets)) return false;
    
            from.removeTicketsAndUpdateCapacity(tickets);
    
            updateTicketAudit(from, tickets, Action.Direction.MOVED_OUT);
            updateTicketAudit(to, tickets, Action.Direction.MOVED_IN);
            updateBussesAudit(from, tickets, Action.Direction.MOVED_OUT);
            updateBussesAudit(to, tickets, Action.Direction.MOVED_IN);

            return true;
        } finally {
            DepotLock.unlock();
        }
    }
    
    @Override
    public boolean useTickets(BusSolution bus, Set<TicketSolution> tickets) {  
        DepotLock.lock();
        
        try {
            for (TicketSolution ticket : tickets) {
                if (!bus.getAllTicketsInTheBus().contains(ticket)) {
                    System.out.println("DEBUG: useTickets, ticket was not found in bus");
                    return false;
                }
                System.out.println("DEBUG: useTickets " + ticket.getStatus());
                if (ticket.getStatus() == Status.USED) {
                    System.out.println("DEBUG: useTickets, a ticket was already used");
                    return false;
                }
            }
    
            for (TicketSolution ticket : tickets) {
                ticket.setStatus(Status.USED);
            }
    
            bus.removeTicketsAndUpdateCapacity(tickets);
    
            updateTicketAudit(bus, tickets, Action.Direction.USED);
            updateBussesAudit(bus, tickets, Action.Direction.USED);
    
            return true;
        } finally {
            DepotLock.unlock();
        }
    }
    
    @Override
    public boolean expireTickets(BusSolution bus, Set<TicketSolution> tickets) {
        DepotLock.lock();

        try {
            for (TicketSolution ticket : tickets) {
                if (!bus.getAllTicketsInTheBus().contains(ticket)) {
                    System.out.println("DEBUG: expireTickets, ticket was not found in bus");
                    return false;
                }
                System.out.println("DEBUG: expireTickets " + ticket.getStatus());
                if (ticket.getStatus() == Status.USED) {
                    System.out.println("DEBUG: expireTickets, a ticket was already expired");
                    return false;
                }
            }
    
            for (TicketSolution ticket : tickets) {
                ticket.setStatus(Status.EXPIRED);
            }
    
            bus.removeTicketsAndUpdateCapacity(tickets);
    
            updateTicketAudit(bus, tickets, Action.Direction.EXPIRED);
            updateBussesAudit(bus, tickets, Action.Direction.EXPIRED);
            return true;
        } finally {
            DepotLock.unlock();
        }
    }
    
    @Override
    public Set<TicketSolution> getTickets() {
        DepotLock.lock();

        try {
            Set<TicketSolution> tickets = new HashSet<>();
            for (BusSolution bus : allBusses) {
                tickets.addAll(bus.getAllTicketsInTheBus());
            }
            return tickets;
        } finally {
            DepotLock.unlock();
        }

    }
    
    @Override
    public Set<TicketSolution> getTickets(BusSolution bus) {
        DepotLock.lock();

        try {
            Set<TicketSolution> tickets = new HashSet<>();
            tickets.addAll(bus.getAllTicketsInTheBus());
            return tickets;
        } finally {
            DepotLock.unlock();
        }
    }
    
    @Override
    public List<Action<TicketSolution>> audit(BusSolution bus) {
            return bus.getAudit();
    }
    
    @Override
    public List<Action<BusSolution>> audit(TicketSolution ticket) {
            return ticket.getAudit();
    }
    
} 