package edu.uic.cs454.s25.a4.solution;

import java.util.Queue;
import java.util.Set;
import java.util.concurrent.ConcurrentLinkedQueue;

import edu.uic.cs454.s25.a4.Action;
import edu.uic.cs454.s25.a4.Bus;
import edu.uic.cs454.s25.a4.Result;
import edu.uic.cs454.s25.a4.Ticket.Status;

public class BusSolution extends Bus<TicketSolution> {

    private final int capacity;
    private final Object lock = new Object(); 
    private int numberOfPeopleInTheBus;
    private Queue<Action> queue;

    public BusSolution(int capacity) {
        super();
        this.capacity = capacity;
        numberOfPeopleInTheBus = 0;
        queue = new ConcurrentLinkedQueue<>();
    }

    // this method is accessed by debot thread..
    @Override
    public void submitAction(Action a) {
        synchronized (lock) {
            queue.offer(a);
            lock.notify();
        }
    }

    @Override
    protected Action getAction() { 
        synchronized (lock) {
            while (queue.isEmpty()) {
                try {
                    lock.wait(100L); 
                } catch (InterruptedException e) {
                    continue; // just continue 
                }
            }
            return queue.poll();
        }
    }

    @Override
    protected void boardBus(Set<TicketSolution> tickets, Result<Boolean> result) {
        // Check if bus has capacity 
        if (this.numberOfPeopleInTheBus + tickets.size() > this.capacity) {
            result.setResult(false);
            return;
        }
        
        // Check if ticket is found in the same bus
        Set<TicketSolution> intersection = this.getContents();
        intersection.retainAll(tickets);
        if (intersection.size() > 0) {
            result.setResult(false);
            return;
        }
        
        // Check if all tickets have valid status
        for (TicketSolution ticket : tickets) {
            if (ticket.getStatus() == Status.USED || ticket.getStatus() == Status.EXPIRED) {
                result.setResult(false);
                return;
            }
        }   

        // Valid, board all the tickets:
        for (TicketSolution ticket : tickets) {
            ticket.setStatus(Status.IN_CIRCULATION);
        }
        this.addTickets(tickets);
        numberOfPeopleInTheBus += tickets.size();
        result.setResult(true); 
    }

    @Override
    protected void useTickets(Set<TicketSolution> tickets, Result<Boolean> result) {
        for (TicketSolution ticket : tickets) {
            if (!this.getContents().contains(ticket) || ticket.getStatus() == Status.USED) {
                result.setResult(false);
                return;
            }
        }
        for (TicketSolution ticket : tickets) {
            ticket.setStatus(Status.USED);
        }
        this.removeTickets(tickets);
        numberOfPeopleInTheBus -= tickets.size();        
        result.setResult(true);   
    }

    @Override
    protected void expireTickets(Set<TicketSolution> tickets, Result<Boolean> result) {
        for (TicketSolution ticket : tickets) {
            if (!this.getContents().contains(ticket) || ticket.getStatus() == Status.USED) {
                result.setResult(false);
                return;
            }
        }
        for (TicketSolution ticket : tickets) {
            ticket.setStatus(Status.EXPIRED);
        }
        this.removeTickets(tickets);
        numberOfPeopleInTheBus -= tickets.size();        
        result.setResult(true);   
    }

    @Override
    protected void contents(Result<Set<TicketSolution>> result) {   
        result.setResult(getContents());
    }

    @Override
    protected void moveIn(Set<TicketSolution> tickets, Result<Boolean> result) {
        // Check if bus has capacity 
        if (this.numberOfPeopleInTheBus + tickets.size() > this.capacity) {
            result.setResult(false);
            return;
        }
        
        // Check if ticket is found in the same bus
        Set<TicketSolution> intersection = this.getContents();
        intersection.retainAll(tickets);
        if (intersection.size() > 0) {
            result.setResult(false);
            return;
        }
        
        // Just assert this, board all the tickets
        for (TicketSolution ticket : tickets) {
            ticket.setStatus(Status.IN_CIRCULATION);
        }

        // Valid, transfer
        this.addTickets(tickets);
        numberOfPeopleInTheBus += tickets.size();
        result.setResult(true); 
    }

    @Override
    protected void moveOut(Set<TicketSolution> tickets, Result<Boolean> result) {
        for (TicketSolution t : tickets) {
            if (!this.getContents().contains(t) || t.getStatus() != Status.IN_CIRCULATION) {
                result.setResult(false);
                return;
            }
        }
        this.removeTickets(tickets);
        numberOfPeopleInTheBus -= tickets.size();
        result.setResult(true);
    }

}