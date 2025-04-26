package edu.uic.cs454.s25.a3.solution;

import edu.uic.cs454.s25.a3.Depot;
import edu.uic.cs454.s25.a3.Ticket.*;

import java.util.List;
import java.util.Set;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashSet;

public class DepotSolution extends Depot<BusSolution, TicketSolution> {

    Set<BusSolution> allBusses;

    public DepotSolution() {
        allBusses = new HashSet<BusSolution>();
    }

    @Override
    public BusSolution createBus(int capacity) {
        BusSolution newBus = new BusSolution(capacity);

        // Possible data race if the operation is not fast enough
        synchronized (allBusses) {
            allBusses.add(newBus);
        }
        return newBus;
    }
    
    @Override
    public TicketSolution issueTicket(int id) {
        // Issue a new ticket
        return new TicketSolution(id);
    }
    
    @Override
    public boolean boardBus(BusSolution bus, Set<TicketSolution> tickets) {
        // call lock() for each ticket in order
        List<TicketSolution> sortedTickets = new ArrayList<>(tickets);
        sortedTickets.sort(Comparator.comparingInt(ticket -> ticket.getId()));
        for (TicketSolution ticket : sortedTickets) ticket.lock.lock();
        // lock the bus
        bus.writeLock.lock();

        try {
            // Check if any ticket is already in a bus or invalid
            for (TicketSolution ticket : tickets) {
                if (ticket.currentBus != null || ticket.getStatus() == Status.USED || ticket.getStatus() == Status.EXPIRED) {
                    return false;
                }
            }
            
            // try boarding the bus, this is synchronized by bus
            if (!bus.board(tickets)) return false;
            
            // Update the status and the current bus for that ticket
            for (TicketSolution ticket : tickets) {
                ticket.currentBus = bus;
                ticket.setStatus(Status.IN_CIRCULATION);
            }
    
            return true;
        } finally {
            // call unlock() for each ticket in reverse order
            for (int i = sortedTickets.size() - 1; i >= 0; i--) {
                sortedTickets.get(i).lock.unlock();
            }
            bus.writeLock.unlock();
        }
    }
    
    @Override
    public boolean transferTickets(BusSolution from, BusSolution to, Set<TicketSolution> tickets) {
        // lock the tickets
        List<TicketSolution> sortedTickets = new ArrayList<>(tickets);
        sortedTickets.sort(Comparator.comparingInt(ticket -> ticket.getId()));
        for (TicketSolution ticket : sortedTickets) ticket.lock.lock();
        // lock the busses
        if (from.id < to.id) {
            from.writeLock.lock();
            to.writeLock.lock();
        } else {
            to.writeLock.lock();
            from.writeLock.lock();
        }

        try {
            // Check if that ticket already exists, then it wouldn't make sense
            Set<TicketSolution> fromTickets = from.getAllTicketsInTheBus();
            if (!fromTickets.containsAll(tickets)) {
                return false;
            }
            
            // Check whether each ticket is still valid
            for (TicketSolution ticket : tickets) {
                if (ticket.getStatus() == Status.EXPIRED || ticket.getStatus() == Status.USED) {
                    return false;
                }
            }
            
            // Board all tickets to "to"
            if (!to.board(tickets)) return false;

            // Remove all tickets from "from"
            from.removeTickets(tickets);

            // Update current bus for transferred tickets
            for (TicketSolution ticket : tickets) {
                ticket.currentBus = to;
            }

            return true;
        } finally {
            // call unlock() for each ticket in reverse order
            for (int i = sortedTickets.size() - 1; i >= 0; i--) {
                sortedTickets.get(i).lock.unlock();
            }
            // Unlock buses in reverse order
            if (from.id < to.id) {
                to.writeLock.unlock();
                from.writeLock.unlock();
            } else {
                from.writeLock.unlock();
                to.writeLock.unlock();
            }
        }
    }
    
    @Override
    public boolean useTickets(BusSolution bus, Set<TicketSolution> tickets) {  
        // call lock() for each ticket in order
        List<TicketSolution> sortedTickets = new ArrayList<>(tickets);
        sortedTickets.sort(Comparator.comparingInt(ticket -> ticket.getId()));
        for (TicketSolution ticket : sortedTickets) ticket.lock.lock();
        // lock the bus
        bus.writeLock.lock();

        try {   
            // main algorithm
            Set<TicketSolution> busTickets = bus.getAllTicketsInTheBus();
            if (!busTickets.containsAll(tickets)) {
                return false;
            }
        
            for (TicketSolution ticket : tickets) {
                if (ticket.getStatus() == Status.USED) {
                    return false;
                }
            }
    
            for (TicketSolution ticket : tickets) {
                ticket.setStatus(Status.USED);
                ticket.currentBus = null;
            }
    
            bus.removeTickets(tickets);
    
            return true;
        } finally {
            // call unlock() for each ticket in reverse order
            for (int i = sortedTickets.size() - 1; i >= 0; i--) {
                sortedTickets.get(i).lock.unlock();
            }
            bus.writeLock.unlock();
        }
    }
    
    @Override
    public boolean expireTickets(BusSolution bus, Set<TicketSolution> tickets) {
        // call lock() for each ticket in order
        List<TicketSolution> sortedTickets = new ArrayList<>(tickets);
        sortedTickets.sort(Comparator.comparingInt(ticket -> ticket.getId()));
        for (TicketSolution ticket : sortedTickets) ticket.lock.lock();
        // lock the bus
        bus.writeLock.lock();

        try {
            // main algorithm
            Set<TicketSolution> busTickets = bus.getAllTicketsInTheBus();
            if (!busTickets.containsAll(tickets)) {
                return false;
            }
        
            for (TicketSolution ticket : tickets) {
                if (ticket.getStatus() == Status.USED) {
                    return false;
                }
            }
        
            for (TicketSolution ticket : tickets) {
                ticket.setStatus(Status.EXPIRED);
                ticket.currentBus = null;
            }
       
            bus.removeTickets(tickets);
    
            return true;
        } finally {
            // Unlock it in reverse order
            for (int i = sortedTickets.size() - 1; i >= 0; i--) {
                sortedTickets.get(i).lock.unlock();
            }
            bus.writeLock.unlock();
        }
    }
    
    @Override 
    public Set<TicketSolution> getTickets() {
        // lock() each bus that exists (in order)
        List<BusSolution> sortedBusses = new ArrayList<>(allBusses);
        sortedBusses.sort(Comparator.comparingInt(bus -> bus.id));
        for (BusSolution bus : sortedBusses) bus.lock.lock();

        try {
            Set<TicketSolution> tickets = new HashSet<>();
            for (BusSolution bus : allBusses) {
                tickets.addAll(bus.getAllTicketsInTheBus());
            }
            return tickets;
        } finally {
            // Unlock it in reverse order
            for (int i = sortedBusses.size() - 1; i >= 0; i--) {
                sortedBusses.get(i).lock.unlock();
            }
        }
    }
    
    @Override
    public Set<TicketSolution> getTickets(BusSolution bus) {
        bus.lock.lock(); // Acquire read lock
        try {
            return new HashSet<>(bus.getAllTicketsInTheBus());
        } finally {
            bus.lock.unlock();
        }
    }
    
    @Override
    public Set<TicketSolution> getTickets(List<BusSolution> buses) {
        // lock() each bus that exists (in order)
        List<BusSolution> sortedBusses = new ArrayList<>(buses);
        sortedBusses.sort(Comparator.comparingInt(bus -> bus.id));
        for (BusSolution bus : sortedBusses) bus.lock.lock();

        try {
            Set<TicketSolution> tickets = new HashSet<>();
            for (BusSolution bus : buses) {
                tickets.addAll(bus.getAllTicketsInTheBus());
            }
            return tickets;
        } finally {
            // Unlock it in reverse order
            for (int i = sortedBusses.size() - 1; i >= 0; i--) {
                sortedBusses.get(i).lock.unlock();
            }
        }
    }
    
} 