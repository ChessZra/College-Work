package edu.uic.cs454.s25.a5.solution;

import java.util.HashSet;

public class Invocation {
    public String message;
    public BusSolution bus;
    public BusSolution from; // only for transfer
    public BusSolution to; // only for transfer
    public HashSet<TicketSolution> tickets = new HashSet<>();
    public Node currentHead;
}