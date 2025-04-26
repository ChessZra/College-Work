package edu.uic.cs454.s25.a3;

import java.util.List;
import java.util.Set;

import edu.uic.cs454.s25.a3.solution.DepotSolution;

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

    public abstract Set<T> getTickets(List<B> buses);

    public final void audit(B bus) {
        throw new Error("Not supported");
    }

    public final void audit(T ticket) {
        throw new Error("Not supported");
    }
}
