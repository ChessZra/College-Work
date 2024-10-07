/* GQTest.java */
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

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
        assertEquals(0, queue1.getHead().code);
    }

    @Test
    void GenericQueueConstructorWithCode() {
        GenericQueue<Integer> queueWithCode = new GenericQueue<Integer>(100, 415);
        assertNotNull(queueWithCode);                                       // Object should not be null
        assertNotNull(queueWithCode.getHead());                             // Verify head
        assertEquals(100, queueWithCode.getHead().data);                    // Verify head's data
        assertEquals(queueWithCode.getHead(), queueWithCode.getTail());     // Verify that head and tail are equal
        assertEquals(1, queueWithCode.getLength());                         // LL length: 1
        assertEquals(415, queueWithCode.getHead().code);
    }

    @Test
    void NodeConstructor() {
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

    @Test
    void GenericQueueEnqueueTest() {
        queue1.enqueue(5);
        // The queue is now [100, 5]
        assertEquals(2, queue1.getLength());    // Length should be 2
        assertEquals(5, queue1.getTail().data); // Tail should be set to 5
    } 

    @Test
    void GenericQueueDequeueTest() {
        // Since Function Dequeue() is pretty much the same as Function Delete()
        // There is no need to do repeated cases.

        // The queue at this line is [100]
        assertEquals(100, queue1.dequeue());
        // The queue at this line should be []
        assertEquals(0, queue1.getLength());        
    }

    @Test
    void GenericQueueGetTailTest() {
        // The queue at this line is: 100
        assertEquals(100, queue1.getTail().data);
        assertEquals(queue1.getHead(), queue1.getTail());

        helperAddIntegers(queue1);
        // The queue at this line is: 100, 61, 24, 12, 41, 51
        assertEquals(51, queue1.getTail().data);
    }

    /* The following lines below are methods defined in the GenericList class. */

    @Test
    void dumpListTest() {
        helperAddIntegers(queue1);
        ArrayList<Integer> queue1List = queue1.dumpList();

        int expected[] = {100, 61, 24, 12, 41, 51};

        assertEquals(expected.length, queue1List.size());

        for (int i = 0; i < expected.length; i++) {
            assertEquals(queue1List.get(i), expected[i]);
        }

        // Test for an empty queue:
        GenericQueue<Integer> emptyQueue = new GenericQueue<>(0);
        emptyQueue.dequeue();

        ArrayList<Integer> emptyList = emptyQueue.dumpList();
        assertEquals(0, emptyList.size());
    }

    @Test
    void getTest() {
        helperAddIntegers(queue1);
        // The queue at this line is: 100, 61, 24, 12, 41, 51
        assertEquals(100, queue1.get(0));
        assertEquals(61, queue1.get(1));
        assertEquals(24, queue1.get(2));
        assertEquals(12, queue1.get(3));
        assertEquals(41, queue1.get(4));
        assertEquals(51, queue1.get(5));
        assertNull(queue1.get(6));              // Out of bounds
        assertNull(queue1.get(-5));             // Out of bounds
    }

    @Test
    void setTest() {
        helperAddIntegers(queue1);
        // The queue at this line is: 100, 61, 24, 12, 41, 51
        for (int i = 0; i < 6; i++) {
            queue1.set(i, i + 60);
        }

        // The queue at this line is: 60, 61, 62, 63, 64, 65
        for (int i = 0; i < 6; i++) {
            assertEquals(60 + i, queue1.get(i));
        }

        assertNull(queue1.set(-1, 59));         // Out of bounds
        assertNull(queue1.set(6, 66));          // Out of bounds
    }

    @Test
    void getLengthTest() {
        // The queue at this line is: 100
        assertEquals(1, queue1.getLength());
        
        queue1.delete();
        // The queue at this line is: 
        assertEquals(0, queue1.getLength());

        helperAddIntegers(queue1);
        // The queue at this line is: 61, 24, 12, 41, 51

        assertEquals(5, queue1.getLength());
    }

    @Test
    void setLengthTest() {
        helperAddIntegers(queue1);
        // The queue at this line is: 100, 61, 24, 12, 41, 51
        assertEquals(6, queue1.getLength());
        
        queue1.setLength(1);
        assertEquals(1, queue1.getLength());

        queue1.setLength(100);
        assertEquals(100, queue1.getLength());

        queue1.setLength(0);
        assertEquals(0, queue1.getLength());
    }

    @Test
    void getHeadTest() {
        queue1.add(50);
        // The queue at this line is: 100, 50

        assertEquals(100, queue1.getHead().data);
        queue1.delete();

        // The queue at this line is: 50
        assertEquals(50, queue1.getHead().data);
        queue1.delete();

        // The queue at this line is: empty
        assertNull(queue1.getHead());
    }

    @Test
    void setHeadTest() {
        helperAddIntegers(queue1);
        // The queue at this line is: 100, 61, 24, 12, 41, 51

        assertEquals(100, queue1.getHead().data);

        assertNotEquals(queue1.getHead(), queue1.getTail());
        queue1.setHead(queue1.getTail());   // Set the head to the tail
        assertEquals(queue1.getHead(), queue1.getTail());
        assertEquals(51, queue1.getHead().data);
    }

    @Test
    void ForEachLoopTest() {
        helperAddIntegers(queue1);
        int[] expected = {100, 61, 24, 12, 41, 51};
        
        int i = 0;
        for (int element : queue1) {
            assertEquals(expected[i], element);
            i++;
        }
        
        // Make sure that all elements were checked
        assertEquals(expected.length, i);
    }

    @Test
    void IteratorTest() {
        helperAddIntegers(queue1);

        Iterator<Integer> it;
        it = queue1.iterator();

        int[] expected = {100, 61, 24, 12, 41, 51};
        int i = 0;
        while (it.hasNext()) {
            assertEquals(expected[i++], it.next());
        }

        // Make sure that all elements were checked
        assertEquals(expected.length, i);
    }

    @Test
    void ReversedIteratorTest() {
        helperAddIntegers(queue1);

        Iterator<Integer> it;
        it = queue1.descendingIterator();

        int[] expected = {100, 61, 24, 12, 41, 51};
        int i = expected.length - 1;
        while (it.hasNext()) {
            assertEquals(expected[i--], it.next());
        }

        // Make sure that all elements were checked
        assertEquals(-1, i);
    }
}