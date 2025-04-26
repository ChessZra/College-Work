
package edu.uic.cs454.s25.a4.solution;
import edu.uic.cs454.s25.a4.Ticket;

public class TicketSolution implements Ticket {

    private Status status;
    private int id;
    
    public TicketSolution(int id) {
        this.id = id;
        this.status = Status.ISSUED;
    }

    @Override
    public Status getStatus() {
        return status;
    }
    
    public void setStatus(Status status) {
        this.status = status;
    }
    
}