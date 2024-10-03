import java.util.ArrayList;
import java.util.Iterator;

public abstract class GenericList<T> implements Iterable<T> {
    private Node<T> head;
    private int length = 0;

    public abstract void add(T data);

    public abstract T delete();

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

    public class GenericListIterator implements Iterator<T> {
        private int index = 0;

        @Override
        public boolean hasNext() {
            return index < length;
        }

        @Override
        public T next() {
            return get(index);
        }
    }

    public class GenericListDescendingIterator implements Iterator<T> {
        private int index = length - 1;

        @Override
        public boolean hasNext() {
            return index >= 0;
        }

        @Override
        public T next() {
            return get(index);
        }
    }

    public Iterator<T> descendingIterator() {
        return new GenericListDescendingIterator();
    }

    public Iterator<T> iterator() {
        return new GenericListIterator();
    }

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

    public ArrayList<T> dumpList() {
        ArrayList<T> res = new ArrayList<>();
        Node<T> cur = head;
        while (cur != null) {
            res.add(cur.data);
            cur = cur.next;
        }
        return res;
    }

    public T get(int index) {
        if (index >= getLength()) return null;
        Node<T> cur = head;
        int pos = 0;
        while (pos < index) {
            cur = cur.next;
            pos++;
        }
        return cur.data;
    }

    public T set(int index, T element) {
        if (index >= getLength()) return null;

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

    public int getLength() {
        return this.length;
    }

    public void setLength(int length) {
        this.length = length;
    }

    public Node<T> getHead() {
        return this.head;
    }

    public void setHead(Node<T> head) {
        this.head = head;
    }

}
