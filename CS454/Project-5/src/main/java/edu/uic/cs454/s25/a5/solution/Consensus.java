package edu.uic.cs454.s25.a5.solution;

import java.util.concurrent.atomic.AtomicReference;

public class Consensus {
    private final AtomicReference<Node> decided;

    public Consensus(Node expectedValue) {
        decided = new AtomicReference<>(expectedValue);
    }

    public Node decide(Node node) { 
        // decided is holding the current last node.
        // this is how we do our validation.
        decided.compareAndSet(node.prev, node);
        return decided.get();
    }
}