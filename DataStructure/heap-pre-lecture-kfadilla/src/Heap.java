import java.util.ArrayList;
import java.util.Collection;
import java.util.function.BiPredicate;


public class Heap<E> {

    ArrayList<E> data;
    BiPredicate<E,E> less;

    Heap(BiPredicate<E,E> lessThan) {
        data = new ArrayList<>(); less = lessThan;
    }

    Heap(BiPredicate<E,E> lessThan, Collection<E> S) {
        less = lessThan;
        data = new ArrayList<E>(S);
        build_max_heap();
    }

    public E maximum() {
        return data.get(0);
    }

    public void insert(E k) {
        if (data.size() + 1 >= data.size()) {
            ArrayList<E> d = new ArrayList<>((data.size() + 1) * 2);
            for (E e : data)
                d.add(e);
            data = d;
        }
        data.add(k);
        increase_key(data.size() - 1);
    }

    public E extract_max() {
        E max = data.get(0);
        data.set(0, data.get(data.size()-1));
        data.remove(data.size()-1);
        max_heapify(0, data.size());
        return max;
    }

    public static <E> void sortInPlace(ArrayList<E> A, BiPredicate<E,E> lessThan) {
        Heap<E> H = new Heap<E>(lessThan);
        H.data = A;
        H.build_max_heap();
        for (int i  = H.data.size() - 1; i != 0; --i) {
            swap(H.data, 0, i);
            H.max_heapify(0, i);
        }
        assert(H.data == A);
    }

    public boolean is_heap() {
        return is_heap(0);
    }

    public String toString() {
        return data.toString();
    }

    /***************
     * Helper functions
     */

    static int left(int i) { return 2*i + 1; }
    static int right(int i) { return 2*(i + 1); }
    static int parent(int i) { return (int) Math.floor((double)(i - 1) / 2.0); }

    static <E> void swap(ArrayList<E> A, int i, int j) {
        E tmp = A.get(i);
        A.set(i, A.get(j));
        A.set(j, tmp);
    }

    /**
     * TODO (pre-lecture assignment)
     * The max_heapify method rearranges the subtree rooted at index i
     * so that the subtree satisfies the heap property. The children
     * of the node at index i must already satisfy the heap property.
     *
     * @param i The index of the node that you wish to heapify.
     * @param length The effective length of the data array (usually the same as data.size(),
     *               but not always, so use length instead of data.size()).
     */
    void max_heapify(int i, int length) {
            if (!(is_heap(i))){
                if (left(i) < length && right(i) < length) {
                    if (less.test(data.get(right(i)), data.get(left(i)))) {
                        swap(data, left(i), i);
                        if (!(is_heap(left(i)))) {
                            max_heapify(left(i), length);
                        }
                    } else {
                        swap(data, right(i), i);
                        if (!(is_heap(right(i)))) {
                            max_heapify(right(i), length);
                        }
                    }
                    }else if (left(i) <= length){
                    swap(data, left(i), i);
                    if (!(is_heap(left(i)))) {
                        max_heapify(left(i), length);
                    }
                } else if(right(i) <= length){
                    swap(data, right(i), i);
                    if (!(is_heap(right(i)))) {
                        max_heapify(right(i), length);
                    }
                }
        }
    }

    void build_max_heap() {
        int last_parent = data.size() / 2 - 1;
        for (int i = last_parent; i != -1; --i) {
            max_heapify(i, data.size());
        }
    }

    void increase_key(int i) {
        while (parent(i) >= 0 && less.test(data.get(parent(i)), data.get(i))) {
            swap(data, i, parent(i));
            i = parent(i);
        }
    }

    boolean is_heap(int i) {
        int l = left(i);
        int r = right(i);
        boolean ret = true;
        if (l < data.size()) {
            ret = ret && ! less.test(data.get(i), data.get(l)) && is_heap(l);
        }
        if (r < data.size()) {
            ret = ret && ! less.test(data.get(i), data.get(r)) && is_heap(r);
        }
        return ret;
    }

}
