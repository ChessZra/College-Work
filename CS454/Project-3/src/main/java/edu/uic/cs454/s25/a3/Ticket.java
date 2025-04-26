package edu.uic.cs454.s25.a3;

public interface Ticket {
    enum Status {ISSUED, IN_CIRCULATION, USED, EXPIRED}

    Status getStatus();
}
