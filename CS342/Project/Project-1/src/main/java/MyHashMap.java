/* MyHashMap.java */
import java.util.ArrayList;
import java.util.Iterator;

public class MyHashMap<T> implements Iterable<T> {

    // Private data members:
    private ArrayList<GenericQueue<T>> map;
    private int keySize = 0;

    // This constructor initializes the map with a single key: value pair already.
    public MyHashMap(String key, T value) {
        map = new ArrayList<>(10);
        for (int i = 0; i < 10; i++) {
            map.add(null);
        }
        put(key, value);
    }

    // Returns an iterator for our map.
    public Iterator<T> iterator() {
        return new HMIterator<T>(this);
    }

    // Puts in the value with an associated code based on the key 
    // at the right index on the map.
    public void put(String key, T value) {
        int code = key.hashCode();
        int index = code & 0x9;
        GenericQueue<T> queue = map.get(index);
        if (queue == null) {
            GenericQueue<T> newQueue = new GenericQueue<>(value, code);
            map.set(index, newQueue);
        } else {
            map.get(index).add(value, code);
        }
        keySize += 1;
    }

    // This returns true if the key is found in our map.
    // The process:
    // Turn the key into a specific code
    // Find the right index based on the code
    // Check if the queue includes the corresponding code
    // Return true if found else False.
    public boolean contains(String key) {
        int code = key.hashCode();
        int index = code & 0x9;
        GenericQueue<T> queue = map.get(index);

        if (queue == null) return false;

        GenericList<T>.Node<T> cur = queue.getHead();
        
        while (cur != null) {
            if (cur.code == code) return true;
            cur = cur.next;
        }

        return false;
    }

    // Gets the associated value based on the key from our map.
    public T get(String key) {
        int code = key.hashCode();
        int index = code & 0x9;
        GenericQueue<T> queue = map.get(index);

        if (queue == null) return null;

        GenericList<T>.Node<T> cur = queue.getHead();
        
        while (cur != null) {
            if (cur.code == code) return cur.data;
            cur = cur.next;
        }

        return null;
    }

    // Getter function to get the number of elements in the map:
    public int size() {
        return keySize;
    }

    // Returns true if our map is empty:
    public boolean isEmpty() {
        return keySize == 0;
    }

    // This function returns the old value before replacement.
    // If the value does not exist, this function returns null.
    public T replace(String key, T value) {
        int code = key.hashCode();
        int index = code & 0x9;
        GenericQueue<T> queue = map.get(index);

        if (queue == null) return null;

        GenericList<T>.Node<T> cur = queue.getHead();
        T oldValue = null;
        while (cur != null) {
            if (cur.code == code) {
                oldValue = cur.data;
                cur.data = value;
                break;
            }
            cur = cur.next;
        }

        return oldValue;
    }

    // Getter function to get our map data structure:
    public ArrayList<GenericQueue<T>> getMap() {
        return map;
    }
}
