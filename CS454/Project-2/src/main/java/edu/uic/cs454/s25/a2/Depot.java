package edu.uic.cs454.s25.a2;

import java.util.List;
import java.util.Set;

import edu.uic.cs454.s25.a2.solution.DepotSolution;
import edu.uic.cs454.s25.a2.solution.LockSolution;

public abstract class Depot<B extends Bus, T extends Ticket> {
    public static Depot<?, ?> createDepot() {
        return new DepotSolution();
    }

    public static CS454Lock createLock() {
        return new LockSolution();
    }

    public abstract B createBus(int capacity);

    public abstract T issueTicket(int id);

    public abstract boolean boardBus(B bus, Set<T> tickets);

    public abstract boolean transferTickets(B from, B to, Set<T> tickets);

    public abstract boolean useTickets(B bus, Set<T> tickets);

    public abstract boolean expireTickets(B bus, Set<T> tickets);

    public abstract Set<T> getTickets();

    public abstract Set<T> getTickets(B bus);

    public abstract List<Action<T>> audit(B bus);

    public abstract List<Action<B>> audit(T ticket);
}
