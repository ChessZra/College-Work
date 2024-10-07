/* ReverseGLLIterator.java */
import java.util.ArrayList;
import java.util.Iterator;

public class ReverseGLLIterator<T> implements Iterator<T> {
    // Private data member:
    private ArrayList<T> stack;

    // The constructor that takes in our object reference.
    // This function builds the stack.
    // O(N) time to allow for an ammortized O(1) next() and hasNext() calls.
    public ReverseGLLIterator(GenericList<T> ref) {
        GenericList<T>.Node<T> cur = ref.getHead();
        stack = new ArrayList<>();
        while (cur != null) {
            stack.add(cur.data);
            cur = cur.next;
        }
    }

    // True if the stack is not empty
    @Override
    public boolean hasNext() {
        return stack.size() > 0;
    }

    // Returns and pops the last element on the stack
    // in O(1) time.
    @Override
    public T next() {
        T ret = stack.get(stack.size() - 1);
        stack.remove(stack.size() - 1);
        return ret;
    }
}