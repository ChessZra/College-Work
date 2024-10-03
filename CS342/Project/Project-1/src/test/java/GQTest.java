import static org.junit.jupiter.api.Assertions.*;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import java.util.ArrayList;
import java.util.Iterator;

public class GQTest {
    
    static GenericQueue<Integer> queue1; 

    @BeforeEach
    void setup() {
        queue1 = new GenericQueue<Integer>(100);
    }

    // Helper function to add elements.
    void helperAddIntegers(GenericQueue<Integer> q) {
        Integer[] arr = {61, 24, 12, 41, 51};
        for (int i = 0; i < 5; i++) {
            q.add(arr[i]);
        }
    }

    @Test
    void GenericQueueConstructor() {
        assertNotNull(queue1);                              // Object should not be null
        assertNotNull(queue1.getHead());                    // Verify head
        assertEquals(100, queue1.getHead().data);           // Verify head's data
        assertEquals(queue1.getHead(), queue1.getTail());   // Verify that head and tail are equal
        assertEquals(1, queue1.getLength());                // LL length: 1
    }

    @Test
    void GenericQueueNodeConstructor() {
        GenericQueue<Integer>.Node<Integer> node = new GenericQueue<Integer>(10).new Node<Integer>(11, 0);
        assertEquals(11, node.data);
        assertNull(node.next);
        assertEquals(0, node.code);
    }

    @Test
    void GenericQueueAdd() {
        assertEquals(queue1.getHead().data, queue1.getTail().data); // Tail = head, before insertion

        queue1.add(50); 

        assertNotEquals(queue1.getHead().data, queue1.getTail().data); // Head != Tail
        assertEquals(100, queue1.getHead().data);                      // Head.data = 100
        assertEquals(50, queue1.getTail().data);                       // Tail.data = 50
        assertEquals(2, queue1.getLength());                           // Length should be now 2
    }

    @Test
    void GenericQueueDelete() {
        helperAddIntegers(queue1);  
        // Before: 100, 61, 24, 12, 41, 51
        assertEquals(6, queue1.getLength());
        assertEquals(100, queue1.getHead().data);
        assertEquals(51, queue1.getTail().data);

        // After one operation: 61, 24, 12, 41, 51
        int removedInteger = queue1.delete();
        assertEquals(100, removedInteger);          // Removed integer is 100
        assertEquals(5, queue1.getLength());        // New length is 5
        assertEquals(61, queue1.getHead().data);    // Head is now 61
        assertEquals(51, queue1.getTail().data);    // Tail remains the same

        // After removing until one is left: 51
        for (int i = 0; i < 4; i++) removedInteger = queue1.delete();
        assertEquals(queue1.getHead(), queue1.getTail());   // Tail should be the same as head
        assertEquals(51, queue1.getHead().data);            // The last element should be 51
        assertEquals(41, removedInteger);                   // Recent removed integer is 61
        assertEquals(1, queue1.getLength());                // New length is 1
    }

    @Test
    void GenericQueueDeleteAddEmptyList() {
        queue1.delete();                        // List should now be empty
        assertNull(queue1.getHead());
        assertNull(queue1.getTail());
        assertEquals(0, queue1.getLength());

        helperAddIntegers(queue1);              // List should now contain integers
        assertNotEquals(queue1.getHead().data, queue1.getTail().data); // Head != Tail
        assertEquals(5, queue1.getLength());                           // There should be 5 new integers
        assertEquals(61, queue1.getHead().data);                       // Head should be 61
        assertEquals(51, queue1.getTail().data);                       // Tail should be 51
    }

}
