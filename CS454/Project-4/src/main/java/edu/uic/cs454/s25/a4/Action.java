package edu.uic.cs454.s25.a4;

import java.util.Objects;

public final class Action<T,R> {
    public enum Direction { ADD, MOVE_OUT, MOVE_IN, USED, EXPIRED, CONTENTS }

    private final Direction direction;
    private final T target;
    private final Result<R> result;

    public Action(Direction direction, T t, Result<R> result) {
        this.direction = direction;
        this.target = t;
        this.result = result;
    }

    public T getTarget() {
        return this.target;
    }

    public Result<R> getResult() {
        return this.result;
    }

    public Direction getDirection() {
        return this.direction;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Action<?,?> action = (Action<?,?>) o;
        return direction == action.direction &&
                Objects.equals(target, action.target);
    }

    @Override
    public int hashCode() {
        return Objects.hash(direction, target);
    }

    @Override
    public String toString() {
        return "{" + direction + " - " + target + '}';
    }
}
