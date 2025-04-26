package edu.uic.cs454.s25.a2;

import org.junit.Assert;
import org.junit.Test;

import java.util.Random;
import java.util.concurrent.locks.Lock;

public class Test04_ManyThreadsManyLocks {

    @Test
    public void eachUsesOwnCounter() {
        int nthreads = 20;
        int increments = 1_000_000;

        Lock l[]       = new Lock[nthreads];
        int counters[] = new int[nthreads];
        Thread ts[]    = new Thread[nthreads];

        Depot.createLock();

        for (int i = 0 ; i < nthreads ; i++) {
            int threadid = i;
            l[i] = Depot.createLock();
            ts[i] = new Thread(() -> {
                for (int j = 0 ; j < increments ; j++) {
                    l[threadid].lock();
                    counters[threadid] += 1;
                    l[threadid].unlock();
                }
            });
        }

        Test02_TwoThreadsLock.runAllThreads(ts);

        for (int i = 0 ; i< nthreads ; i++) {
            Assert.assertEquals(increments, counters[i]);
        }
    }

    @Test
    public void allThreadsUseAllLocks() {
        int nthreads = 8;
        int increments = 2_000_000;

        Lock l[] = new Lock[3];

        for (int i = 0 ; i < l.length ; i++)
            l[i] = Depot.createLock();

        long counters[] = new long[nthreads];
        Thread ts[]     = new Thread[nthreads];

        Depot.createLock();

        for (int i = 0 ; i < nthreads ; i++) {
            ts[i] = new Thread(() -> {
                Random rnd = new Random();
                for (int j = 0 ; j < increments ; j++) {
                    int target = rnd.nextInt(counters.length);
                    l[target % l.length].lock();
                    counters[target] += 1;
                    l[target % l.length].unlock();
                }
            });
        }

        Test02_TwoThreadsLock.runAllThreads(ts);

        long total = 0;
        for (int i = 0 ; i< counters.length ; i++) {
            total += counters[i];
        }

        long expected = ((long)nthreads) * ((long)increments);
        Assert.assertEquals(expected, total);
    }
}
