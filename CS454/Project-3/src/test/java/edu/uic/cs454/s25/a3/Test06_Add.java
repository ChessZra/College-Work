package edu.uic.cs454.s25.a3;

import org.junit.Assert;
import org.junit.Test;

import java.util.*;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicReference;

public class Test06_Add {
    @Test
    public void addIsLinearizable() {
        Depot depot = Depot.createDepot();
        Ticket[] ticekts = new Ticket[2_500];
        Bus[] buses = new Bus[ticekts.length * 2];

        AtomicReference<Thread>[] winner = new AtomicReference[ticekts.length];


        // Set-up
        {
            for (int i = 0 ; i < buses.length ; i++) {
                buses[i] = depot.createBus(2);
            }

            for (int i = 0 ; i < ticekts.length ; i++) {
                ticekts[i] = depot.issueTicket(i);
                winner[i] = new AtomicReference<>(null);
            }
        }

        // Thread 1 attempts to add a ticket to buses 0-499
        Thread t1 = new Thread(() -> {
            for (int i = 0 ; i < ticekts.length ; i++) {
                boolean result = depot.boardBus(buses[i], Set.of(ticekts[i]));
                if (result) {
                    Thread prior = winner[i].compareAndExchange(null, Thread.currentThread());
                    // null -> I won
                    // not null -> Both me and the other thread were able to add the same ticket to different buses
                    Assert.assertNull(prior);
                }
            }
        });

        // Thread 2 attempts to add a ticket to buses 500-1000
        Thread t2 = new Thread(() -> {
            for (int i = 0 ; i < ticekts.length ; i++) {
                boolean result = depot.boardBus(buses[i + ticekts.length], Set.of(ticekts[i]));
                if (result) {
                    Thread prior = winner[i].compareAndExchange(null, Thread.currentThread());
                    // null -> I won
                    // not null -> Both me and the other thread were able to add the same ticket to different buses
                    Assert.assertNull(prior);
                }
            }
        });

        Test03_Progress.runAllThreads(t1, t2);

        Assert.assertEquals(Set.of(ticekts), depot.getTickets());

        Set<Ticket> allTests = new HashSet<>();
        for (Bus bus : buses) {
            for (Object t : depot.getTickets(bus)) {
                Assert.assertFalse(allTests.contains(t));
            }
            allTests.addAll(depot.getTickets(bus));
        }
    }

    @Test
    public void testSafeMoveAdd() {
        Depot depot = Depot.createDepot();
        Bus[] buses = new Bus[10_000];
        Bus[] reverse = new Bus[10_000];
        Ticket[] tickets = new Ticket[buses.length];

        // Set up
        {
            for (int i = 0 ; i < buses.length ; i++) {
                buses[i] = depot.createBus(buses.length);
                reverse[buses.length-1-i] = buses[i];
                tickets[i] = depot.issueTicket(i);

                Assert.assertTrue(depot.boardBus(buses[i], Set.of(tickets[i])));
            }
        }

        AtomicBoolean done = new AtomicBoolean(false);

        // Thread 1, move
        Thread t1 = new Thread(() -> {
            for (int i = buses.length - 1 ; i > 0 ; i--) {
                Set<Ticket> s = Set.of(tickets[i]);
                Assert.assertTrue(depot.transferTickets(buses[i], buses[(i-1)], s));
            }

            done.set(true);
        });

        Bus toAdd = depot.createBus(Integer.MAX_VALUE);

        // Thread 2, add
        Thread t2 = new Thread(() -> {
            int id = tickets.length;
            while (!done.get() && id < Integer.MAX_VALUE) {
                Ticket d = depot.issueTicket(id++);
                Assert.assertTrue(depot.boardBus(toAdd, Set.of(d)));
            }
        });

        Test03_Progress.runAllThreads(t1, t2);

        // No tickets were lost
        Assert.assertEquals(Set.of(tickets), depot.getTickets(Arrays.asList(buses)));
    }

    @Test
    public void testSafeAdd() {
        // Careful!  The same can happen to use/expire!!
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(10_000);
        Bus bus2 = depot.createBus(10_000);

        Ticket[] tickets = new Ticket[10_000];

        Set<Ticket> tickets1 = new LinkedHashSet<>();
        Set<Ticket> tickets2 = new LinkedHashSet<>();

        // Set up
        {
            for (int i = 0 ; i < tickets.length ; i++)
                tickets[i] = depot.issueTicket(i);

            for (int i = 0 , j = tickets.length - 1 ; i < tickets.length ; i++ , j--) {
                tickets1.add(tickets[i]);
                tickets2.add(tickets[j]);
            }
        }

        Iterator<Ticket> i1 = tickets1.iterator();
        Iterator<Ticket> i2 = tickets2.iterator();

        AtomicBoolean b1 = new AtomicBoolean(false);
        AtomicBoolean b2 = new AtomicBoolean(false);

        // Thread 1
        Thread t1 = new Thread(() -> {
            b1.set(depot.boardBus(bus1, tickets1));
        });

        // Thread 2
        Thread t2 = new Thread(() -> {
            b2.set(depot.boardBus(bus2, tickets2));
        });

        Test03_Progress.runAllThreads(t1, t2);

        // Ensure the Depot did not change the collection
        i1.next();
        i2.next();

        // Only one operation succeeded
        Assert.assertTrue((b1.get() && !b2.get()) || (!b1.get() && b2.get()));

        // Check that all the tickets are where they should be
        if (b1.get()) {
            Assert.assertEquals(tickets1, depot.getTickets(bus1));
            Assert.assertEquals(Set.of(), depot.getTickets(bus2));
        } else {
            Assert.assertEquals(Set.of(), depot.getTickets(bus1));
            Assert.assertEquals(tickets2, depot.getTickets(bus2));
        }
    }


    @Test
    public void testProgress() {
        new Test03_Progress().progressGetOneBus();
        new Test03_Progress().progressUseExpire();
    }

}
