package edu.uic.cs454.s25.a5;

import java.util.Set;

import edu.uic.cs454.s25.a5.solution.DepotSolution;

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
}