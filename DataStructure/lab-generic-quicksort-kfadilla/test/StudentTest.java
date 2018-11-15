import org.junit.Test;
import sequences.*;
import java.util.Arrays;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class StudentTest {

    @Test
    public void oneQuicksortArray() {
        int n = 1;
        Integer[] A_orig = {42};
        Integer[] A_sorted = A_orig.clone();
        Integer[] A = A_orig.clone();
        ArraySequence<Integer> L = new ArraySequence<Integer>(A);
        QuickSort.quicksort(L.begin(), L.end());
        assertTrue(Arrays.equals(A_sorted, A));
    }

    @Test
    public void twoQuicksortArray() {
        int n = 2;
        Integer[] A_orig = {42, 41};
        Integer[] A_sorted = A_orig.clone();
        Arrays.sort(A_sorted);
        Integer[] A = A_orig.clone();
        ArraySequence<Integer> L = new ArraySequence<Integer>(A);
        QuickSort.quicksort(L.begin(), L.end());
        assertTrue(Arrays.equals(A_sorted, A));
    }

    @Test
    public void smallQuicksortArray() {
        Integer[] A_orig = {2, 8, 7, 1, 3, 5, 6, 4};
        Integer[] A_sorted = A_orig.clone();
        Arrays.sort(A_sorted);

        Integer[] A = A_orig.clone();
        ArraySequence<Integer> L = new ArraySequence<Integer>(A);
        QuickSort.quicksort(L.begin(), L.end());
        assertTrue(Arrays.equals(A_sorted, A));
    }

    @Test
    public void alreadySortedArray() {
        Integer[] A = { 1, 2, 3, 4, 5, 6, 7, 8 },
                  B = A.clone();

        ArraySequence<Integer> AS = new ArraySequence<>(A);
        QuickSort.quicksort(AS.begin(), AS.end());
        assertTrue(Arrays.equals(A, B));
    }

    @Test
    public void smallQuicksortLinkedList() {
        Integer[] A_orig = {2, 8, 7, 1, 3, 5, 6, 4};
        Integer[] A_sorted = A_orig.clone();
        Arrays.sort(A_sorted);

        LinkedList<Integer> L = new LinkedList<Integer>();
        for (int i = A_orig.length - 1; i != -1; --i) {
            L.insert_front(A_orig[i]);
        }
        QuickSort.quicksort(L.begin(), L.end());
        Integer[] A = new Integer[A_orig.length];
        int k = 0;
        for (Iter<Integer> i = L.begin(); !i.equals(L.end()); i.advance()) {
            A[k] = i.get();
            ++k;
        }
        assert Arrays.equals(A_sorted, A);
    }

    @Test
    public void smallQuicksortCharacterArray() {
        Character a = new Character('a');
        Character b = new Character('b');
        Character c = new Character('c');
        Character d = new Character('d');
        Character e = new Character('e');
        Character f = new Character('f');

        Character[] C_orig = {d, f, a, e, b, c},
                CS = C_orig.clone();
        Arrays.sort(CS);

        Character[]  C = C_orig.clone();
        ArraySequence<Character> AS = new ArraySequence<Character>(C);
        QuickSort.quicksort(AS.begin(),AS.end());
        assertTrue(Arrays.equals(CS, C));
    }
}