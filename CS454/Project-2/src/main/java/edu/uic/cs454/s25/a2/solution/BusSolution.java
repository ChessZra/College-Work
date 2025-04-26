package edu.uic.cs454.s25.a2.solution;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import edu.uic.cs454.s25.a2.Action;
import edu.uic.cs454.s25.a2.Bus;

public class BusSolution implements Bus {
    private int capacity;

    // ticketsInTheBus.size() = numberOfPeopleInTheBus
    private int numberOfPeopleInTheBus;
    private Set<TicketSolution> ticketsInTheBus;
    private LockSolution ticketsInTheBusLock;

    private List<Action<TicketSolution>> audit; // a list of tickets which this bus has occupied

    public BusSolution(int capacity) {
        this.capacity = capacity;
        ticketsInTheBus = new HashSet<TicketSolution>();
        ticketsInTheBusLock = new LockSolution();
        audit = new ArrayList<>();
    }

    public int getCapacity() {
        return capacity;
    }

    public Set<TicketSolution> getAllTicketsInTheBus() {
        return ticketsInTheBus;
    }

    public boolean board(Set<TicketSolution> tickets) {

        // Edge case, a ticket that's already boarded is boarding again? Same person:
        Set<TicketSolution> intersection = new HashSet<>(ticketsInTheBus);
        intersection.retainAll(tickets);
        if (intersection.size() > 0) {
            System.out.println("Edge case, a ticket that's already boarded is boarding again?");
            return false;
        }

        if (numberOfPeopleInTheBus + tickets.size() > capacity) {
            System.out.println("Exceeded capacity from Bus.board() " + numberOfPeopleInTheBus + " Already here, you want " + tickets.size() + " more");
            return false;
        }

        ticketsInTheBusLock.lock(); 
        
        try {
            ticketsInTheBus.addAll(tickets);
            numberOfPeopleInTheBus = ticketsInTheBus.size();
        } finally {
            ticketsInTheBusLock.unlock();
        }

        System.out.println("Successfully boarded");
        return true;
    } 

    public void removeTicketsAndUpdateCapacity(Set<TicketSolution> tickets) {
        ticketsInTheBusLock.lock();

        try {
            ticketsInTheBus.removeAll(tickets);
            numberOfPeopleInTheBus = ticketsInTheBus.size();
        } finally {
            ticketsInTheBusLock.unlock();
        }
    }

    public void updateAudit(Action.Direction direction, TicketSolution ticket) {
        Action<TicketSolution> newAction = new Action<TicketSolution>(direction, ticket);
        audit.add(newAction);
    }

    public List<Action<TicketSolution>> getAudit() {
        return audit;
    }

}