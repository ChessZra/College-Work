package edu.uic.cs454.s25.a2.solution;

import java.util.ArrayList;
import java.util.List;

import edu.uic.cs454.s25.a2.Action;
import edu.uic.cs454.s25.a2.Ticket;

public class TicketSolution implements Ticket {
    private int id;
    private Status status;
    private List<Action<BusSolution>> audit; // a list of busses which this ticket has been to
    LockSolution DepotLock;
    LockSolution TicketLock;

    public TicketSolution(int id, LockSolution depotLock) {
        this.id = id;
        this.status = Status.ISSUED;
        this.audit = new ArrayList<>();
        this.DepotLock = depotLock;
        this.TicketLock = new LockSolution();
    }

    @Override
    public Status getStatus() {
        DepotLock.lock();
        TicketLock.lock();

        try {
            return status;
        } finally {
            DepotLock.unlock();
            TicketLock.unlock();    
        }
    }

    public int getId() { 
        DepotLock.lock();
        try {
            return id;
        } finally {
            DepotLock.unlock();
        }
    }

    public void setStatus(Status status) {
        DepotLock.lock();
        TicketLock.lock();

        try {
            this.status = status;
        } finally {
            DepotLock.unlock();
            TicketLock.unlock();
        }
        
    }

    public void updateAudit(Action.Direction direction, BusSolution bus) {
        Action<BusSolution> newAction = new Action<BusSolution>(direction, bus);
        audit.add(newAction);
    }

    public List<Action<BusSolution>> getAudit() {
        return audit;
    }
}