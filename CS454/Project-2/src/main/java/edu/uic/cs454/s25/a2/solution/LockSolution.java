package edu.uic.cs454.s25.a2.solution;

import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicReference;

import edu.uic.cs454.s25.a2.CS454Lock;

public class LockSolution extends CS454Lock {
    AtomicBoolean state = new AtomicBoolean(false);
    volatile int lock_freq = 0; // No need to be atomic because only one thread has access to this (the owner)
    AtomicReference<Thread> owner = new AtomicReference<>();

    static void highPrecisionSleep(long millis) {
        long currentTime = System.currentTimeMillis();
        while (System.currentTimeMillis() - currentTime < millis);
    }

    @Override
    public void lock() {
        
        if (state.get() && Thread.currentThread() == owner.get()) {
            lock_freq++;
            return;
        } 

        long backoff = 10; // Delay hehehehaw
        
        while (true) {
            while (state.get()) continue;
            // Only gets here when lock is free

            // If the previous value is true,
            // then some thread acquired the lock
            // in between the lines here, so we 
            // return back.
            if (!state.getAndSet(true)) {
                owner.set(Thread.currentThread());
                lock_freq++;
                return;
            } else {
                highPrecisionSleep(backoff);
                backoff *= 1.5;
            }
        }
    }

    // Attempts to acquire the lock. If another thread already has the lock, this operation returns
    // false. Otherwise, this operation acquires the lock and   returns true. This operation does not block
    // waiting for the lock.
    @Override
    public boolean tryLock() {

        if (state.get() && Thread.currentThread() == owner.get()) {
            lock_freq++;
            return true;
        }

        // Same logic here as lock()
        if (!state.getAndSet(true)) {
            owner.set(Thread.currentThread());
            return true;
        } else { // state was evaluated to true which means the lock was taken
            return false;
        }
    }

    @Override
    public void unlock() {
        if (owner.get() != Thread.currentThread()) {
            throw new IllegalMonitorStateException("This lock cannot be unlocked since this thread is not the owner.");          
        }

        if (state.get() == false) {
            throw new IllegalMonitorStateException("Attempted to unlock an unlocked lock");
        }

        lock_freq--;
        
        if (lock_freq == 0) {
            owner.set(null);
            state.set(false);
        }
    }

    @Override
    public boolean isReentered() {
        return lock_freq > 1;
    }    
}
