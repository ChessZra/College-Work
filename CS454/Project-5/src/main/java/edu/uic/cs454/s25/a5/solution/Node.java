package edu.uic.cs454.s25.a5.solution;

public class Node {
    public Invocation invoc;
    public Consensus decideNext;
    public Node next;
    public int seq;
    public Node prev; // for consensus
    
    public Node(Invocation invoc) {
        this.invoc = invoc;
        this.decideNext = new Consensus(this);
        this.seq = 0;
        this.prev = invoc != null ? invoc.currentHead : null;
        this.next = null;
    }

    public static Node max(Node[] array) {
        Node mx = array[0];
        for (int i = 1; i < array.length; i++) {
            if (mx.seq < array[i].seq) {
                mx = array[i];
            }
        }
        return mx;
    }
}