package edu.uic.cs454.s25.a3.solution;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import edu.uic.cs454.s25.a3.Ticket;

public class TicketSolution implements Ticket {
    private int id;
    private Status status;
    public volatile BusSolution currentBus; // Track current bus
    public Lock lock = new ReentrantLock();

    public TicketSolution(int id) {
        this.id = id;
        status = Status.ISSUED;
        currentBus = null; // Initialize as not in any bus
    }

    @Override
    public Status getStatus() {
        lock.lock();
        try {
            return status;
        } finally {
            lock.unlock();
        }
    }

    public int getId() { 
        return id;
    }

    public void setStatus(Status status) { 
        // Assumes the ticket's lock is already held by the caller (Depot methods)
        this.status = status;
    }

}