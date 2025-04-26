package edu.uic.cs454.s25.a1.solution;

import java.util.HashSet;
import java.util.Set;

import edu.uic.cs454.s25.a1.Bus;

public class BusSolution implements Bus {
    public int capacity;
    public Set<TicketSolution> contents;

    public BusSolution(int capacity) {
        this.capacity = capacity;
        contents = new HashSet<TicketSolution>();
    }
}
