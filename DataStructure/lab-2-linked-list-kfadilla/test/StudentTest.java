//changed
import static org.junit.Assert.*;

public class StudentTest {
    @org.junit.Test
    public void begin() throws Exception {
        LinkedList<Integer> L = new LinkedList<Integer>();
        L.begin().equals(L.end());
    }

    @org.junit.Test
    public void insert_front() throws Exception {
        {
            LinkedList<Integer> L = new LinkedList<Integer>();
            L.insert_front(3);
            assertEquals((int) L.begin().get(), 3);
        }
        {
            // Test a sequence of insert_front's
            LinkedList<Integer> L = new LinkedList<Integer>();
            L.insert_front(3);
            L.insert_front(2);
            L.insert_front(1);
            Integer A[] = {1, 2, 3};
            assertTrue(SeqAlgo.equals(L, new ArraySequence<Integer>(A)));

            LinkedList<Integer> J = new LinkedList<Integer>();
            J.insert_front(3);
            Integer B[] = {3};
            assertTrue(SeqAlgo.equals(J, new ArraySequence<Integer>(B)));
        }
    }

    @org.junit.Test
    public void insert_after() throws Exception {
        LinkedList<Integer> L = new LinkedList<Integer>();
        L.insert_front(1);
        LinkedList<Integer>.ListIter i = L.begin();

        // Test insert_after on the first position
        L.insert_after(i, 2);

        // Test insert_after on the last position
        i = L.begin();
        i.advance();
        L.insert_after(i, 4);
        Integer B[] = {1, 2, 4};
        assertTrue(SeqAlgo.equals(L, new ArraySequence<Integer>(B)));

        // Test insert_after in the middle
        i = L.begin();
        i.advance();
        L.insert_after(i, 3);
        Integer C[] = {1, 2, 3, 4};
        assertTrue(SeqAlgo.equals(L, new ArraySequence<Integer>(C)));

        //Test insert_after at the end
        i = L.begin();
        i.advance();
        i.advance();
        i.advance();
        L.insert_after(i, 5);
        Integer D[] = {1, 2, 3, 4, 5};
        assertTrue(SeqAlgo.equals(L, new ArraySequence<Integer>(D)));
    }

    @org.junit.Test
    public void get() throws Exception {
        //test get method
        LinkedList<Integer> L = new LinkedList<Integer>();
        L.insert_front(3);
        L.insert_front(2);
        L.insert_front(1);
        LinkedList<Integer>.ListIter i = L.begin();
        i.advance();
        assertEquals((int) i.get(), 2);
        i.advance();
        assertEquals((int) i.get(), 3);
    }
}