/* GLLIterator.java */
import java.util.Iterator;

public class GLLIterator<T> implements Iterator<T> {

    // Private data member:
    // cur is initially the head node of the list.
    private GenericList<T>.Node<T> cur;

    // Public constructor which takes in the reference.
    public GLLIterator(GenericList<T> ref) {
        cur = ref.getHead();
    }

    // If cur is not null, then there is another node to be traversed.
    // Returns if there is another node to be traversed/
    @Override
    public boolean hasNext() {
        return cur != null;
    }

    // This function only workos if hasNext() is already true:
    // Returns the data associated with cur.
    @Override
    public T next() {
        T res = cur.data;
        cur = cur.next;
        return res;
    }
}