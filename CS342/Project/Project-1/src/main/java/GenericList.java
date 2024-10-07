/* GenericList.java */
import java.util.ArrayList;
import java.util.Iterator;

public abstract class GenericList<T> implements Iterable<T> {
    // Private Data Members:
    private Node<T> head;
    private int length = 0;

    // Abstract Functions:
    public abstract void add(T data);

    public abstract T delete();

    // Nested class:
    // Node represents a single node in the list.
    public class Node<E> {
        E data;
        int code;
        Node<E> next; 

        Node(E data, int code) {
            this.data = data;
            this.code = code;
            this.next = null;
        }
    }

    // Iterator function (descending):
    public Iterator<T> descendingIterator() {
        return new ReverseGLLIterator<T>(this);
    }

    // Iterator function (ascending):
    public Iterator<T> iterator() {
        return new GLLIterator<T>(this);
    }

    // Prints the list in every new line:
    public void print() {
        if (getLength() == 0) {
            System.out.println("Empty List");
        } else {
            Node<T> cur = head;
            while (cur != null) {
                System.out.println(cur.data);
                cur = cur.next;
            }
        }
    }

    // Converts the list into an ArrayList then returns it:
    public ArrayList<T> dumpList() {
        ArrayList<T> res = new ArrayList<>();
        Node<T> cur = head;
        while (cur != null) {
            res.add(cur.data);
            cur = cur.next;
        }
        return res;
    }

    // Get the element at specified index:
    public T get(int index) {
        if (index >= getLength() || index < 0) return null;
        Node<T> cur = head;
        int pos = 0;
        while (pos < index) {
            cur = cur.next;
            pos++;
        }
        return cur.data;
    }

    // Set the element at specified index:
    public T set(int index, T element) {
        if (index >= getLength() || index < 0) return null;

        Node<T> cur = head;
        int pos = 0;
        while (pos < index) {
            cur = cur.next;
            pos++;
        }
        T old = cur.data;
        cur.data = element;
        return old;
    }

    // Getter function for length:
    public int getLength() {
        return this.length;
    }

    // Setter function for length:
    public void setLength(int length) {
        this.length = length;
    }

    // Getter function for head:
    public Node<T> getHead() {
        return this.head;
    }

    // Setter function for head;
    public void setHead(Node<T> head) {
        this.head = head;
    }

}
