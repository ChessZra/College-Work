package edu.uic.cs454.s25.a2;

import org.junit.Assert;
import org.junit.Test;

import java.util.concurrent.locks.Lock;

public class Test03_ManyThreadsLock {

    @Test
    public void otherThreadCannotUnlock() {
        Lock l = Depot.createLock();

        Thread t1 = new Thread(() -> { l.lock(); });
        Test02_TwoThreadsLock.runAllThreads(t1);

        Thread t2 = new Thread(() -> {
            boolean exceptionCaught = false;

            try {
                l.unlock();
                Assert.fail(); // Should never execute
            } catch (IllegalMonitorStateException e) {
                exceptionCaught = true;
            }

            Assert.assertTrue(exceptionCaught);
        });
        Test02_TwoThreadsLock.runAllThreads(t2);
    }

    @Test
    public void otherThreadsCannotUnlock() {
        int nthreads = 10;

        for (int n = 0 ; n < 500 ; n++) {
            Lock l = Depot.createLock();
            Thread ts[] = new Thread[nthreads];

            for (int i = 0; i < nthreads; i++)
                ts[i] = new Thread(() -> {
                    boolean exceptionCaught = false;

                    try {
                        l.unlock();
                        Assert.fail(); // Should never execute
                    } catch (IllegalMonitorStateException e) {
                        exceptionCaught = true;
                    }

                    Assert.assertTrue(exceptionCaught);
                });


            l.lock();
            Test02_TwoThreadsLock.runAllThreads(ts);
        }
    }

    @Test
    public void otherThreadSeesLocked() {
        int nthreads = 10;

        for (int n = 0 ; n < 100 ; n++) {
            Lock l = Depot.createLock();
            Thread ts[] = new Thread[nthreads];

            for (int i = 0; i < nthreads; i++)
                ts[i] = new Thread(() -> {
                    try {
                        Thread.sleep(1);
                    } catch (InterruptedException e) { /*empty*/ }

                    Assert.assertFalse(l.tryLock());
                });

            l.lock();
            Test02_TwoThreadsLock.runAllThreads(ts);
        }
    }

    @Test
    public void counter() {
        Test02_TwoThreadsLock.C c = new Test02_TwoThreadsLock.C();
        int nthreads = 6;
        int increments = 2_000_000;
        Lock l = Depot.createLock();

        Runnable r = () -> {
            for (int i = 0 ; i < increments ; i++) {
                l.lock();
                c.count += 1;
                l.unlock();
            }
        };

        Thread ts[] = new Thread[nthreads];

        for (int i = 0 ; i < nthreads ; i++)
            ts[i] = new Thread(r);

        Test02_TwoThreadsLock.runAllThreads(ts);

        Assert.assertEquals(increments*nthreads, c.count);
    }
}
