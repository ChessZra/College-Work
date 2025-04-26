package edu.uic.cs454.s25.a3;

import org.junit.Assert;
import org.junit.Test;

import java.util.*;
import java.util.concurrent.atomic.AtomicBoolean;

public class Test07_Status {

    @Test
    public void getStatusIsLinearizable() {
        for (int lucky = 0 ; lucky < 25 ; lucky++) {
            Depot depot = Depot.createDepot();
            Set<Ticket>[] groups = new Set[50];
            Set<Ticket> everything = new HashSet<>();
            int capacity = 200_000;
            Bus bus = depot.createBus(capacity);

            // Set-up
            {
                int id = 0;
                for (int i = 0 ; i < groups.length ; i++) {
                    Set<Ticket> s = new HashSet<>();
                    for (int j = 0 ; j < capacity / groups.length ; j++) {
                        Ticket ticket = depot.issueTicket(id++);
                        s.add(ticket);
                        everything.add(ticket);
                    }

                    groups[i] = s;
                }

                Assert.assertTrue(depot.boardBus(bus, everything));
            }

            AtomicBoolean done = new AtomicBoolean(false);

            // Thread 1 marks as USED or EXPIRED all the tickets, group by group
            Thread t1 = new Thread(() -> {
                Random r = new Random();
                for (int i = 0 ; i < groups.length ; i++) {
                    if (r.nextBoolean())
                        Assert.assertTrue(depot.useTickets(bus, groups[i]));
                    else
                        Assert.assertTrue(depot.expireTickets(bus, groups[i]));
                }

                done.set(true);
            });

            // Thread 2 takes snapshots of the tickets in the depot
            Thread t2 = new Thread(() -> {
                Random r = new Random();

                while (!done.get()) {
                    // Pick a group at random
                    Set<Ticket> g = groups[r.nextInt(groups.length)];

                    // Get the status of a test
                    Ticket.Status s = null;

                    if (s == Ticket.Status.IN_CIRCULATION)
                        continue;


                    for (Ticket d : g) {
                        if (s == null)
                            s = d.getStatus();

                        if (s == Ticket.Status.IN_CIRCULATION)
                            break;

                        // Ensure that all the other tickets have the same status, either USED or EXPIRED
                        Assert.assertEquals(s, d.getStatus());

                    }
                }
            });

            Test03_Progress.runAllThreads(t1, t2);

            Assert.assertEquals(Set.of(), depot.getTickets());

        }
    }

    @Test
    public void testProgress() {
        new Test03_Progress().progressGetOneBus();
        new Test03_Progress().progressUseExpire();
    }

}
