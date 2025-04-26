package edu.uic.cs454.s25.a4;

import java.util.HashSet;
import java.util.Set;

public abstract class Bus<T extends Ticket> implements Runnable {

    private final HashSet<T> contents = new HashSet<>();
    protected final Thread allowedThread;
    private boolean exception = false;

    private final Action STOP = new Action(Action.Direction.CONTENTS, null, null);

    public Bus() {
        this.allowedThread = new Thread(this);
        this.allowedThread.setDaemon(true);
        this.allowedThread.setUncaughtExceptionHandler( (Thread thread, Throwable throwable) -> {
            System.err.println(throwable.getMessage());
            throwable.printStackTrace();
            exception = true;
        });
    }

    public final void startThread() {
        this.allowedThread.start();
    }

    public final void run() {
        while (true) {
            Action a = getAction();

            if (a == STOP)
                return;

            switch (a.getDirection()) {
                case ADD:
                    boardBus((Set<T>) a.getTarget(), a.getResult());
                    break;
                case USED:
                    useTickets((Set<T>) a.getTarget(), a.getResult());
                    break;
                case EXPIRED:
                    expireTickets((Set<T>) a.getTarget(), a.getResult());
                    break;
                case CONTENTS:
                    contents(a.getResult());
                    break;
                case MOVE_IN:
                    moveIn((Set<T>) a.getTarget(), a.getResult());
                    break;
                case MOVE_OUT:
                    moveOut((Set<T>) a.getTarget(), a.getResult());
                    break;
                default:
                    throw new Error("Unknown operation");
            }
        }
    }

    public final void addTickets(Set<T> tickets) {
        if (this.allowedThread.isAlive() && Thread.currentThread() != this.allowedThread)
            throw new Error("Wrong thread!");

        this.contents.addAll(tickets);
    }

    public final void removeTickets(Set<T> tickets) {
        if (this.allowedThread.isAlive() && Thread.currentThread() != this.allowedThread)
            throw new Error("Wrong thread!");

        this.contents.removeAll(tickets);
    }

    public final Set<T> getContents() {
        if (this.allowedThread.isAlive() && Thread.currentThread() != this.allowedThread)
            throw new Error("Wrong thread!");

        return new HashSet<>(this.contents);
    }

    public final void stopThread() {
        if (!this.allowedThread.isAlive())
            throw new Error("Thread already stopped, maybe due to an exception?");

        this.submitAction(STOP);

        while (this.allowedThread.isAlive()) {
            try {
                this.allowedThread.join();
            } catch (InterruptedException e) {
                continue;
            }
        }
    }

    public final boolean didThrowException() {
        return this.exception;
    }

    public abstract void submitAction(Action a);

    protected abstract Action getAction();

    protected abstract void boardBus(Set<T> tickets, Result<Boolean> result);

    protected abstract void useTickets(Set<T> tickets, Result<Boolean> result);

    protected abstract void expireTickets(Set<T> tickets, Result<Boolean> result);

    protected abstract void contents(Result<Set<T>> result);

    protected abstract void moveIn(Set<T> tickets, Result<Boolean> result);

    protected abstract void moveOut(Set<T> tickets, Result<Boolean> result);
}
