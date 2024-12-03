/* HMIterator.java */
import java.util.Iterator;
import java.util.ArrayList;

public class HMIterator<T> implements Iterator<T> {
    
    // Private data member:
    // A stack is used for convenience.
    private ArrayList<T> stack;

    // The constructor which gets the reference.
    // This builds the stack data structure and fills it with ALL the elements in the map already.
    // O(N) time to allow for an ammortized O(1) next() and hasNext() calls.
    public HMIterator(MyHashMap<T> ref) {
        ArrayList<GenericQueue<T>> list = ref.getMap();
        stack = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i) != null) {
                GenericQueue<T> queue = list.get(i);   
                for (T element: queue) {
                    stack.add(element);
                }
            }
        }
    }

    // If the stack is not empty, then there is another node to be traversed.
    @Override
    public boolean hasNext() {
        return stack.size() > 0;
    }

    // This function only workos if hasNext() is already true:
    // Returns the data associated at the back of the stack.
    @Override
    public T next() {
        T ret = stack.get(stack.size() - 1);
        stack.remove(stack.size() - 1);
        return ret;
    }
}
