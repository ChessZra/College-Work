/* HMTest.java */
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;

public class HMTest {

    MyHashMap<Integer> map;

    @BeforeEach
    void setup() {
        map = new MyHashMap<Integer>("Cozmo", 50);
    }

    void addFiveElements(MyHashMap<Integer> map) {
        String keys[] = {"the", "robot", "amazed", "everyone", "!"};
        int values[] = {51, 52, 53, 54, 55};

        for (int i = 0; i < 5; i++) {
            map.put(keys[i], values[i]);
        }
    }

    @Test
    void HMConstructor() {        
        assertEquals(1, map.size());
        assertTrue(map.contains("Cozmo"));

        ArrayList<GenericQueue<Integer>> arrayList = map.getMap();
        assertEquals(10, arrayList.size());  // The size of the ArrayList should be initialized to 10 here.
    }

    @Test
    void putTest() {
        map.put("omzoC", 60);  // This should be put at index 0, along with "Cozmo."

        ArrayList<GenericQueue<Integer>> arrayList = map.getMap();

        // The length of the queue should be 2: Cozmo: 50 -> omzoC: 60
        assertEquals(2, arrayList.get(0).getLength());       
        assertEquals(50, arrayList.get(0).getHead().data);   
        assertEquals(60, arrayList.get(0).getTail().data);    
    }

    @Test
    void containsTest() {
        // Ensure that these elements are not in the map:
        assertFalse(map.contains("cozmo"));
        assertFalse(map.contains(" cozmO"));
        assertFalse(map.contains(" Cozmo"));
        assertFalse(map.contains("Cozmo "));
        
        // Now check elements that should be in the map:
        assertTrue(map.contains("Cozmo"));
        addFiveElements(map);
        assertTrue(map.contains("the"));
        assertTrue(map.contains("robot"));
        assertTrue(map.contains("amazed"));
        assertTrue(map.contains("everyone"));
        assertTrue(map.contains("!"));
    }

    @Test
    void getTest() {
        assertEquals(50, map.get("Cozmo"));

        addFiveElements(map);
        String keys[] = {"the", "robot", "amazed", "everyone", "!"};
        int values[] = {51, 52, 53, 54, 55};
        
        // Make sure that the corresponding keys map to the right values.
        for (int i = 0; i < 5; i++) {
            assertEquals(values[i], map.get(keys[i]));
        }
    }

    @Test
    void sizeTest() {
        // The beginning only has length 1
        assertEquals(1, map.size());

        // Add five elements to the map
        addFiveElements(map);

        // In total, there should be 6 elements
        assertEquals(6, map.size());
    }

    @Test
    void isEmptyTest() {
        // There is no way to have an empty map.
        assertFalse(map.isEmpty());

        // Add five elements to the map
        addFiveElements(map);

        assertFalse(map.isEmpty());
    }

    @Test
    void replaceTest() {
        assertNull(map.replace("This key does not exist", 60));
        
        // Now let's replace "Cozmo" from the value 50 to the value 30:
        assertEquals(50, map.replace("Cozmo", 30));

        // The new value of "Cozmo" should be 30:
        assertEquals(30, map.get("Cozmo"));
        
        // Test it on multiple elements:
        addFiveElements(map);
        String keys[] = {"the", "robot", "amazed", "everyone", "!"};
        int values[] = {51, 52, 53, 54, 55};
        for (int i = 0; i < 5; i++) {
            // Ensure that map.replace() is returning the old value.
            assertEquals(values[i], map.replace(keys[i], 0));
        }

        // Ensure that map.replace() successsfully replaced the values to 0.
        for (int i = 0; i < 5; i++) {
            assertEquals(0, map.get(keys[i]));
        }
    }

    private boolean contains(int[] array, int value) {
        for (int element: array) {
            if (element == value) {
                return true;
            }
        }
        return false;
    }

    @Test
    void HMIteratorTest()
    {   
        addFiveElements(map);

        int elements = 0;
        int values[] = {51, 52, 53, 54, 55, 50};
        for (int value : map) { 
            // Ensure that the iterator goes through all of our values in the map.
            assertTrue(contains(values, value));
            elements += 1;
        }
        // Make sure that the number of traversed elements = number of values
        assertEquals(values.length, elements);  
        assertEquals(map.size(), elements);
    }
}