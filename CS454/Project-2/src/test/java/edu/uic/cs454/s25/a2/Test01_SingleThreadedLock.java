package edu.uic.cs454.s25.a2;

import org.junit.Assert;
import org.junit.Test;

import java.util.concurrent.locks.Lock;

public class Test01_SingleThreadedLock {

    @Test
    public void testOneLock() {
        Lock l = Depot.createLock();

        int counter = 0;

        l.lock();
        try {
            for (int i = 0; i < 100; i++) {
                counter += 1;
            }
        } finally {
            l.unlock();
        }

        Assert.assertEquals(100, counter);
    }

    @Test
    public void testTwoLocksSeparate() {
        Lock l1 = Depot.createLock();
        Lock l2 = Depot.createLock();

        int counter = 0;

        l1.lock();
        try {
            for (int i = 0; i < 100; i++) {
                counter += 1;
            }
        } finally {
            l1.unlock();
        }

        l2.lock();
        try {
            for (int i = 0; i < 100; i++) {
                counter += 1;
            }
        } finally {
            l2.unlock();
        }

        Assert.assertEquals(200, counter);
    }

    @Test
    public void testTwoLocksSameTime() {
        Lock l1 = Depot.createLock();
        Lock l2 = Depot.createLock();

        int counter = 0;

        l1.lock();
        try {
            for (int i = 0; i < 100; i++) {
                l2.lock();
                try {
                    counter += 1;
                } finally {
                    l2.unlock();
                }
            }
        } finally {
            l1.unlock();
        }

        Assert.assertEquals(100, counter);
    }

    @Test
    public void testUnlockThrowsException() {
        Lock l = Depot.createLock();
        boolean exceptionThrown = false;

        try {
            l.unlock();
            Assert.fail(); // This line should never execute
        } catch (IllegalMonitorStateException e) {
            exceptionThrown = true;
        }

        Assert.assertTrue(exceptionThrown);
    }

    @Test
    public void testDifferentLocksThrowException() {
        Lock l1 = Depot.createLock();
        Lock l2 = Depot.createLock();
        boolean exceptionThrown = false;

        l1.lock(); 
        try {
            l2.unlock();
            Assert.fail(); // This line should never execute
        } catch (IllegalMonitorStateException e) {
            exceptionThrown = true;
        }

        Assert.assertTrue(exceptionThrown);
    }
}
