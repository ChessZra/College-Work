public class GenericQueue<T> extends GenericList<T> {
    
    private Node<T> tail;

    public GenericQueue(T data) {
        Node<T> newNode = new Node<>(data, 0);
        setHead(newNode);
        tail = getHead();
        setLength(1);
    } 

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

    public Node<T> getTail() {
        return tail;
    }
    
    public void enqueue(T data) {
        add(data);
    }

    public T dequeue() {
        return delete();
    }
}
