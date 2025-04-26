package edu.uic.cs454.s25.a4.solution;

import edu.uic.cs454.s25.a4.Result;

public class ResultSolution<T> extends Result<T> {
    private final Object lock = new Object(); 

    @Override
    public void setResult(T result) {
        synchronized (lock) {
            // this thread is called by the bus thread
            // - this writes 
            this.set(result);
            lock.notifyAll();
        }
    }

    @Override
    public T getResult() {
        synchronized (lock) {
            // this method is called by the main thread(s)
            // - this reads
            while (!this.isReady()) {
                try {
                    lock.wait(100L); 
                } catch (InterruptedException e) {
                    continue; // just continue
                }
            }
            return this.get(); 
        }
    }
}