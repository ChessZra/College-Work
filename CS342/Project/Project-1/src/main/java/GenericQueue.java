/* GenericQueue.java */
public class GenericQueue<T> extends GenericList<T> {
    // Private data members:
    private Node<T> tail;

    // Constructor that takes in T data only:
    public GenericQueue(T data) {
        Node<T> newNode = new Node<>(data, 0);
        setHead(newNode);
        tail = getHead();
        setLength(1);
    } 

    // Overloaded constructor that takes in T data and int code:
    public GenericQueue(T data, int code) {
        Node<T> newNode = new Node<>(data, code);
        setHead(newNode);
        tail = getHead();
        setLength(1);
    } 

    // Overrided function from GenericList<T>
    // Adds an element to the back of the queue.
    @Override
    public void add(T data) { 
        Node<T> newNode = new Node<>(data, 0);
        if (getHead() == null) {
            setHead(newNode);
            tail = newNode;
        } else {
            tail.next = newNode;
            tail = tail.next;
        }
        setLength(getLength() + 1);
    }
    
    // Overloaded function which adds an element to the front of the queue
    // This function specifically sets node with a specific code.
    public void add(T data, int code) {
        Node<T> newNode = new Node<>(data, code);
        if (getHead() == null) {
            setHead(newNode);
            tail = newNode;
        } else {
            tail.next = newNode;
            tail = tail.next;
        }
        setLength(getLength() + 1);
    }

    // Overrided function from GenericList<T>
    // Deletes an element from the front of the queue.
    @Override
    public T delete() {
        if (getHead() == null) {
            return null;
        }

        T res = getHead().data;
        setHead(getHead().next);
        setLength(getLength() - 1);

        if (getHead() == null) {
            tail = null;
        }

        return res;
    }

    // Getter function to fetch the tail node
    // In other words, the back of the queue
    public Node<T> getTail() {
        return tail;
    }
    
    // Alias for add()
    public void enqueue(T data) {
        add(data);
    }

    // Alias for delete()
    public T dequeue() {
        return delete();
    }
}
