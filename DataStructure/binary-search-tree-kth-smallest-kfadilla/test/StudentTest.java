import junit.framework.TestCase;
import org.junit.Before;

import java.util.HashSet;

import static org.junit.Assert.*;

public class StudentTest extends TestCase {
    BinarySearchTree<Integer> T;
    HashSet<Integer> H;
    int[] A = {2, 4, 1, 5, 5, 9, 8 }, A_sorted = { 1, 2, 4, 5, 8, 9 };

    @Before
    public void setUp() {
        T = new BinarySearchTree();
        H = new HashSet<Integer>();
    }
    @org.junit.Test
    public void test_find() throws Exception {
        for (int i = 0; i != A.length; ++i) {
            T.insert(A[i]);
            H.add(A[i]);
        }
        for (Integer k : H) assertTrue(T.find(k));
        for (int k : A_sorted) assertTrue(T.find(k));
    }

    @org.junit.Test
    public void test_remove() throws Exception {
        for (int i = 0; i != A.length; ++i) {
            T.insert(A[i]);
            H.add(A[i]);
        }
        for (int i = 0; i != A.length; ++i) {
            T.remove(A[i]);
            assert T.find(A[i]) == false;
        }
    }

    @org.junit.Test
    public void test_kth_smallest() throws Exception {
        for (int i = 0; i != A.length; ++i) {
            T.insert(A[i]);
            H.add(A[i]);
        }
        for (int i = 0; i != A_sorted.length; ++i) {
            int small = T.kth_smallest(i);
            assertEquals(small,A_sorted[i]);
        }
    }

}