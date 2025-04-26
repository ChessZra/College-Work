package edu.uic.cs454.s25.a5;

import org.junit.Assert;
import org.junit.Test;

import java.util.HashSet;
import java.util.Random;
import java.util.Set;
import java.util.concurrent.BrokenBarrierException;
import java.util.concurrent.CyclicBarrier;
import java.util.concurrent.atomic.AtomicBoolean;

public class Test06_Status {

    @Test
    public void testTicketChangesCorrectly() {
        Depot depot = Depot.createDepot();
        Bus bus = depot.createBus(3);
        Ticket ticket1 = depot.issueTicket(0);
        Ticket ticket2 = depot.issueTicket(1);
        Ticket ticket3 = depot.issueTicket(2);

        {
            Assert.assertEquals(Ticket.Status.ISSUED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket3.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket1));

            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket3.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket2));

            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.ISSUED, ticket3.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket3));

            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket3.getStatus());
        }

        {
            depot.useTickets(bus, Set.of(ticket1));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket3.getStatus());
        }

        {
            depot.expireTickets(bus, Set.of(ticket1));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket3.getStatus());
        }

        {
            depot.expireTickets(bus, Set.of(ticket2));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket3.getStatus());
        }

        {
            depot.useTickets(bus, Set.of(ticket2));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.IN_CIRCULATION, ticket3.getStatus());
        }

        {
            depot.useTickets(bus, Set.of(ticket3));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.USED, ticket3.getStatus());
        }

        {
            depot.expireTickets(bus, Set.of(ticket3));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.USED, ticket3.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket1));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.USED, ticket3.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket2));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.USED, ticket3.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket3));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.USED, ticket3.getStatus());
        }

        {
            depot.boardBus(bus, Set.of(ticket1, ticket2, ticket3));

            Assert.assertEquals(Ticket.Status.USED, ticket1.getStatus());
            Assert.assertEquals(Ticket.Status.EXPIRED, ticket2.getStatus());
            Assert.assertEquals(Ticket.Status.USED, ticket3.getStatus());
        }


    }


    @Test
    public void getStatusIsLinearizable() {
        for (int lucky = 0 ; lucky < 25 ; lucky++) {
            Depot depot = Depot.createDepot();
            int capacity = 10_000;
            Set<Ticket> everything = new HashSet<>();
            Set<Ticket>[] groups = new Set[25];
            Bus bus = depot.createBus(capacity);

            // Set-up
            {
                int id = 0;
                for (int i = 0 ; i < groups.length ; i++) {
                    Set<Ticket> tickets = new HashSet<>();
                    for (int j = 0 ; j < capacity / groups.length ; j++) {
                        Ticket ticket = depot.issueTicket(id++);
                        tickets.add(ticket);
                        everything.add(ticket);
                    }

                    groups[i] = tickets;
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

                    // Get the status of a ticket
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

            Test03_MultithreadedAdd.runAllThreads(t1, t2);

            Assert.assertEquals(Set.of(), depot.getTickets());

        }
    }

    @Test
    public void getStatusIsLinearizableMultipleThreads() {
        for (int lucky = 0 ; lucky < 50 ; lucky++) {
            Depot depot = Depot.createDepot();
            int capacity = 10_000;
            Set<Ticket> everything = new HashSet<>();
            Set<Ticket>[] groups = new Set[25];
            AtomicBoolean[] success = new AtomicBoolean[groups.length];
            Bus bus = depot.createBus(capacity);


            // Set-up
            {
                int id = 0;
                for (int i = 0 ; i < groups.length ; i++) {
                    Set<Ticket> tickets = new HashSet<>();
                    for (int j = 0 ; j < capacity / groups.length ; j++) {
                        Ticket ticket = depot.issueTicket(id++);
                        tickets.add(ticket);
                        everything.add(ticket);
                    }

                    groups[i] = tickets;
                    success[i] = new AtomicBoolean(false);
                }

                Assert.assertTrue(depot.boardBus(bus, everything));
            }

            AtomicBoolean done = new AtomicBoolean(false);
            CyclicBarrier barrier = new CyclicBarrier(10);

            // Thread 1 marks as USED or EXPIRED all the tickets, group by group
            Thread[] ts = new Thread[10];

            for (int i = 0 ; i < ts.length - 1 ; i++) {
                ts[i] = new Thread(() -> {
                    Random r = new Random();
                    try {
                        barrier.await();
                    } catch (InterruptedException | BrokenBarrierException e) {
                        // Empty
                    }

                    for (int j = 0; j < groups.length; j++) {
                        boolean s = false;
                        int g = r.nextInt(groups.length);
                        if (r.nextBoolean())
                            s = depot.useTickets(bus, groups[g]);
                        else
                            s = depot.expireTickets(bus, groups[g]);

                        if (s) {
                            // We were able to use the group
                            // Make sure we were the only thread able to do so
                            Assert.assertFalse(success[g].getAndSet(true));
                        }
                    }

                    done.set(true);
                });
            }

            // Thread 2 takes snapshots of the tickets in the depot
            ts[ts.length - 1] = new Thread(() -> {
                Random r = new Random();

                try {
                    barrier.await();
                } catch (InterruptedException | BrokenBarrierException e) {
                    // Empty
                }

                while (!done.get()) {
                    // Pick a group at random
                    Set<Ticket> g = groups[r.nextInt(groups.length)];

                    // Get the status of a ticket
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

            Test03_MultithreadedAdd.runAllThreads(ts);

        }
    }

}
