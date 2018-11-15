import sequences.*;
import static sequences.Algorithms.*;

public class QuickSort {

    /**
     * TODO
     * @param begin The position of the first element in the sequence to be sorted.
     * @param end   The position that is one-past the last element in the sequence to be sorted.
     * @param <E>   The element type for the sequence.
     */
    public static <E extends Comparable<E>>
    void quicksort(Iter<E> begin, Iter<E> end) {
        if (!begin.equals(end)){
            Iter<E> pivot = partition(begin, end);
            Iter<E> temp = pivot.clone();
            temp.advance();
            quicksort(begin, pivot);
            quicksort(temp, end);
        }
    }
    public static <E extends Comparable<E>> Iter<E> partition(Iter<E> begin, Iter<E> end){
        Iter<E> pivot_loc = last(begin, end);
        E data = pivot_loc.get();
        Iter<E> i = begin.clone();
        for (Iter<E> j = begin.clone(); !j.equals(pivot_loc); j.advance()) {
            if (j.get().compareTo(data) <= 0) {
                iter_swap(i, j);
                i.advance();
            }
        }
        iter_swap(i, pivot_loc);
        return i;
    }
}
