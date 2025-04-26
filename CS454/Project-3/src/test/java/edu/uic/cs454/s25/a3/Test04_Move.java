package edu.uic.cs454.s25.a3;

import org.junit.Assert;
import org.junit.Test;

import java.util.List;
import java.util.Set;

public class Test04_Move {

    @Test
    public void testSafeTransfer() {
        Depot depot = Depot.createDepot();
        Bus bus1 = depot.createBus(2);
        Bus bus2 = depot.createBus(2);
        Ticket ticket1 = depot.issueTicket(1);
        Ticket ticket2 = depot.issueTicket(2);

        // Set up
        {
            depot.boardBus(bus1, Set.of(ticket1,ticket2));
        }

        int n = 500_000;

        // Thread 1, move ticket1 back and forth
        Thread t1 = new Thread(() -> {
            for (int i = 0 ; i < n ; i++) {
                Set<Ticket> s = Set.of(ticket1);
                Assert.assertTrue(depot.transferTickets(bus1, bus2, s));
                Assert.assertTrue(depot.transferTickets(bus2, bus1, s));
            }
        });

        // Thread 2, move ticket2 back and forth
        Thread t2 = new Thread(() -> {
            for (int i = 0 ; i < n ; i++) {
                Set<Ticket> s = Set.of(ticket2);
                Assert.assertTrue(depot.transferTickets(bus1, bus2, s));
                Assert.assertTrue(depot.transferTickets(bus2, bus1, s));
            }
        });

        Test03_Progress.runAllThreads(t1, t2);

        // No tickets were lost
        Assert.assertEquals(Set.of(ticket1, ticket2), depot.getTickets());
        Assert.assertEquals(Set.of(ticket1, ticket2), depot.getTickets(List.of(bus1, bus2)));
    }

    @Test
    public void testProgress() {
        new Test03_Progress().progressGetOneBus();
        new Test03_Progress().progressUseExpire();
    }
}
