package edu.uic.cs454.s25.a1.solution;

import edu.uic.cs454.s25.a1.Ticket;

public class TicketSolution implements Ticket {
    public int id;
    public Status status;
    DepotSolution depot;

    public TicketSolution(int id, DepotSolution depot) {
        this.id = id;
        status = Status.ISSUED;
        this.depot = depot;
    }

    @Override
    public synchronized Status getStatus() {
        synchronized (depot) {
            return status;
        }
    }

    public int getId() { 
        synchronized (depot) {
            return id;
        }
    }
}
