//changed
import java.lang.UnsupportedOperationException;

class Node<T> {
    Node(T d, Node<T> n) {
        data = d; next = n;
    }
    T data;
    Node<T> next;
}

public class LinkedList<T> implements Sequence<T> {
    private Node<T> front;
    // Create a linked list with no elements.
    public LinkedList() {
        front = null;
    }
        
    public ListIter begin() {
        return new ListIter(front);
    }
        
    public ListIter end() {
        return new ListIter(null);
    }
        
    // Add element x to the front of the list.
    public void insert_front(T x) {
         Node add  = new Node(x, front);
         front = add;
    }

    // Insert element x so that it appears one position after the position pos.
    // precondition: pos is the position of an element in the sequence.
    public void insert_after(ListIter pos, T x) {
        Node add = new Node(x,pos.node.next);
        pos.node.next = add;
    }

    public class ListIter implements Iter<T> {
        
        Node<T> node;

        ListIter(Node<T> p) {
            node = p;
        }
      
        public T get() {
            return node.data;
        }

        public void advance() {
            node = node.next;
        }

        public boolean equals(Iter<T> other) {
            boolean result = (this.node == ((ListIter)other).node);
            return result;
        }

        public ListIter clone() {
            ListIter copy = new ListIter(node);
            return copy;
        }
      
    }
}
