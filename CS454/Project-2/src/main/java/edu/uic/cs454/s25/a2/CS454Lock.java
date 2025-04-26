package edu.uic.cs454.s25.a2;

import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.Condition;

public abstract class CS454Lock implements java.util.concurrent.locks.Lock {

    public abstract void lock();

    public abstract boolean tryLock();

    public abstract void unlock();

    public abstract boolean isReentered();

    @Override
    public final void lockInterruptibly() throws InterruptedException {
        throw new UnsupportedOperationException();
    }

    @Override
    public final Condition newCondition() {
        throw new UnsupportedOperationException();
    }

    @Override
    public final boolean tryLock(long l, TimeUnit timeUnit) throws InterruptedException {
        throw new UnsupportedOperationException();
    }
}
