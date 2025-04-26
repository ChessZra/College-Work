package edu.uic.cs454.s25.a5.solution;

import edu.uic.cs454.s25.a5.Ticket;

public class TicketSolution implements Ticket {
    private final LFUniversal universal;
    public Status status;

    public TicketSolution(LFUniversal universal) {
        this.universal = universal;
        status = Ticket.Status.ISSUED;
    }

    @Override
    public Status getStatus() {
        return universal.getTicketStatus(this);
    }
}