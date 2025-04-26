package edu.uic.cs454.s25.a4;

import java.util.Set;

import edu.uic.cs454.s25.a4.solution.DepotSolution;

public abstract class Depot<B extends Bus, T extends Ticket> {
    public static Depot<?, ?> createDepot() {
        return new DepotSolution();
    }

    public abstract B createBus(int capacity);

    public abstract T issueTicket(int id);

    public abstract boolean boardBus(B bus, Set<T> tickets);

    public abstract boolean transferTickets(B from, B to, Set<T> tickets);

    public abstract boolean useTickets(B bus, Set<T> tickets);

    public abstract boolean expireTickets(B bus, Set<T> tickets);

    public abstract Set<T> getTickets();

    public abstract Set<T> getTickets(B bus);

    public abstract Result<Boolean> boardBusAsync(B bus, Set<T> tickets);

    public abstract Result<Boolean> transferTicketsAsync(B from, B to, Set<T> tickets);

    public abstract Result<Boolean> useTicketsAsync(B bus, Set<T> tickets);

    public abstract Result<Boolean> expireTicketsAsync(B bus, Set<T> tickets);

    public abstract Result<Set<T>> getTicketsAsync();

    public abstract Result<Set<T>> getTicketsAsync(B bus);
}
