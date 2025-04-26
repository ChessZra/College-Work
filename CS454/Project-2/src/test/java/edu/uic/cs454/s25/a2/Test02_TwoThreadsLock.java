package edu.uic.cs454.s25.a2;

import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.locks.Lock;

import org.junit.Assert;
import org.junit.Test;

public class Test02_TwoThreadsLock {

    @Test
    public void secondThreadWaitsForFirstToFinish() {
        Lock l = Depot.createLock();
        C c = new C();

        for (int i = 0 ; i < 1 ; i++) {
            c.s = "";

            Thread t1 = new Thread(() -> {
                l.lock();
                try {
                    Thread.sleep(1000);
                    c.s += "T1";
                } catch (InterruptedException e) {
                    return;
                } finally {
                    l.unlock();
                }
            });

            Thread t2 = new Thread(() -> {
                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) {
                    return;
                }
                l.lock();
                try {
                    c.s += "T2";
                } finally {
                    l.unlock();
                }
            });

            runAllThreads(t1, t2);

            Assert.assertEquals("T1T2", c.s);
        }
    }

    @Test
    public void otherThreadSeesLocked() {

        for (int i = 0 ; i < 200 ; i++) {
            Lock l = Depot.createLock();
            AtomicBoolean ready = new AtomicBoolean(false);

            Thread t1 = new Thread(() -> {
                l.lock();
            });

            runAllThreads(t1);

            Thread t2 = new Thread(() -> {
                try {
                    Thread.sleep(1);
                } catch (InterruptedException e) { /*empty*/ }

                Assert.assertFalse(l.tryLock());
            });

            runAllThreads(t2);
        }
    }

    @Test
    public void counter() {
        C c = new C();
        Lock l = Depot.createLock();
        int increments = 2_000_000;

        Runnable r = () -> {
            for (int i = 0 ; i < increments ; i++) {
                l.lock();
                c.count += 1;
                l.unlock();
            }
        };

        Thread t1 = new Thread(r);
        Thread t2 = new Thread(r);

        runAllThreads(t1, t2);

        Assert.assertEquals(increments*2, c.count);
    }

    /*default*/ static void runAllThreads(Thread ... threads) {

        AtomicBoolean exceptionThrown = new AtomicBoolean(false);

        // Uncaught exceptions cause tests to fail
        for (int i = 0 ; i < threads.length ; i++) {
            threads[i].setUncaughtExceptionHandler((t,ex) -> {
                System.err.println(ex.getMessage());
                ex.printStackTrace();
                exceptionThrown.set(true);
            });
        }

        // Start all threads
        for (int i = 0 ; i < threads.length ; i++)
            threads[i].start();

        // Wait for all threads to finish
        for (int i = 0 ; i < threads.length ; i++) {
            while (threads[i].isAlive()) {
                try {
                    threads[i].join();
                } catch (InterruptedException e) {
                    continue;
                }
            }
        }
        
        // Make sure no thread threw an exception
        Assert.assertFalse(exceptionThrown.get());
    }

    public static class C {
        String s = "";
        int count = 0;
    }
}
