package edu.uic.cs454.s25.a3.solution;

import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.locks.ReentrantReadWriteLock;
import java.util.concurrent.locks.Lock;

import edu.uic.cs454.s25.a3.Bus;

public class BusSolution implements Bus {
    private int capacity;
    private Set<TicketSolution> ticketsInTheBus;
    private static int running_id = 0; // for locks
    public final int id;

    private final ReentrantReadWriteLock rwLock = new ReentrantReadWriteLock();
    public final Lock lock = rwLock.readLock();
    public final Lock writeLock = rwLock.writeLock();

    public BusSolution(int capacity) {
        this.capacity = capacity;
        ticketsInTheBus = new HashSet<TicketSolution>();
        this.id = running_id;
        BusSolution.running_id++;
    }

    public Set<TicketSolution> getAllTicketsInTheBus() {
        return new HashSet<>(ticketsInTheBus); // Return a copy for thread safety
    }

    public boolean board(Set<TicketSolution> tickets) {
        // Edge case, a ticket that's already boarded is boarding again? Same person:
        Set<TicketSolution> intersection = new HashSet<>(ticketsInTheBus);
        intersection.retainAll(tickets);
        if (intersection.size() > 0) {
            return false;
        }

        if (ticketsInTheBus.size() + tickets.size() > capacity) {
            return false;
        }

        ticketsInTheBus.addAll(tickets);

        return true;
    } 

    public void removeTickets(Set<TicketSolution> tickets) {
        ticketsInTheBus.removeAll(tickets);
    }

}