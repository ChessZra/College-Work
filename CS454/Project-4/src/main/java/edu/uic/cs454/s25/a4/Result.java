package edu.uic.cs454.s25.a4;

public abstract class Result<T> {
    private boolean ready = false;
    private T result;

    public final boolean isReady() {
        return ready;
    }

    protected final T get() {
        if (!this.ready)
            throw new IllegalStateException("Result is not ready");

        return result;
    }

    protected final T set(T result) {
        if (this.ready)
            throw new IllegalStateException("Result is not ready");

        this.result = result;
        this.ready = true;

        return result;
    }

    public abstract void setResult(T result);

    public abstract T getResult();
}
