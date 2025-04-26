package edu.uic.cs454.s25.a5.solution;

import edu.uic.cs454.s25.a5.Action;
import edu.uic.cs454.s25.a5.Ticket;
import java.util.concurrent.atomic.AtomicReference;

public class LFUniversal {
    
    private Node[] head;
    private Node tail;
    private AtomicReference<Log> currentLog;  // Make log updates atomic

    public LFUniversal() {
        head = new Node[10];
        tail = new Node(null);
        tail.seq = 1;
        for (int i = 0; i < 10; i++) {
            head[i] = tail;
        }
        Log initial = new Log();
        initial.currentHead = tail;
        currentLog = new AtomicReference<>(initial);
    }

    public boolean apply(Invocation invoc) {
        int i = (int) Thread.currentThread().getId() % 10;
        Node prefer = new Node(invoc);

        Node before = Node.max(head);
        if (before != invoc.currentHead) {
            return false; 
        }
        
        // Change like CAS(count, value, value + 1)
        Node after = before.decideNext.decide(prefer);
        before.next = after;
        after.seq = before.seq + 1;
        head[i] = after;

        if (after == prefer) {
            // Create new log with our changes
            Log oldLog = currentLog.get();
            Log newLog = new Log();
            newLog.contents.addAll(oldLog.contents);
            
            // Add our changes
            if (invoc.message.equals("board")) {
                for (TicketSolution ticket : invoc.tickets) {
                    ticket.status = Ticket.Status.IN_CIRCULATION;
                    BusTicket bt = new BusTicket(invoc.bus, ticket);
                    newLog.contents.add(new Action<>(Action.Direction.IN_CIRCULATION, bt));
                }
            } else if (invoc.message.equals("use")) {
                for (TicketSolution ticket : invoc.tickets) {
                    ticket.status = Ticket.Status.USED;
                    BusTicket bt = new BusTicket(invoc.bus, ticket);
                    newLog.contents.add(new Action<>(Action.Direction.USED, bt));
                }
            } else if (invoc.message.equals("expire")) {
                for (TicketSolution ticket : invoc.tickets) {
                    ticket.status = Ticket.Status.EXPIRED;
                    BusTicket bt = new BusTicket(invoc.bus, ticket);
                    newLog.contents.add(new Action<>(Action.Direction.EXPIRED, bt));
                }
            } else if (invoc.message.equals("transfer")) {
                for (TicketSolution ticket : invoc.tickets) {
                    BusTicket bt = new BusTicket(invoc.from, ticket);
                    newLog.contents.add(new Action<>(Action.Direction.MOVED_OUT, bt));     
                    
                    BusTicket bt2 = new BusTicket(invoc.to, ticket);
                    newLog.contents.add(new Action<>(Action.Direction.MOVED_IN, bt2));     
                }
            } 
            newLog.currentHead = prefer;
            currentLog.compareAndSet(oldLog, newLog);
        }

        return after == prefer;
    }
    
    public Ticket.Status getTicketStatus(TicketSolution ticket) {
        Ticket.Status currentStatus = Ticket.Status.ISSUED;
        // Process all actions in the log to determine current status
        for (Action<BusTicket> action : currentLog.get().contents) {
            if (action.get().ticket == ticket) {
                switch (action.getDirection()) {
                    case IN_CIRCULATION:
                    case MOVED_IN: // case MOVED_OUT does not affect
                        currentStatus = Ticket.Status.IN_CIRCULATION;
                        break;
                    case USED:
                        currentStatus = Ticket.Status.USED;
                        break;
                    case EXPIRED:
                        currentStatus = Ticket.Status.EXPIRED;
                        break;
                }
            }
        }
        
        return currentStatus;
    }
    
    public Log getLog() {
        return currentLog.get();
    }
}