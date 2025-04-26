package edu.uic.cs454.s25.a1;

public interface Ticket {
    enum Status {ISSUED, IN_CIRCULATION, USED, EXPIRED}

    Status getStatus();
}
