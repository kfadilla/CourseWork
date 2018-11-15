import org.junit.Test;
import static org.junit.Assert.*;

public class StudentTest {

    @Test
    public void array_to_list() throws Exception {
        int[] A = {1,2,3};
        Node n = Main.array_to_list(A);
        assertEquals(n.data, 1);
        assertEquals(n.next.data, 2);
        assertEquals(n.next.next.data, 3);
    }

    @Test
    public void nth_node() throws Exception {
        int[] A = {1,2,3};
        Node n = Main.array_to_list(A);
        for (int i = 0; i != 3; ++i)
            assert Main.nth_node(n, i).data == i+1;
    }

    @Test
    public void remove_next() throws Exception {
        int[] A = {1,2,3};
        Node n = Main.array_to_list(A);
        Main.remove_next(n);
        assertEquals(n.data, 1);
        assertEquals(n.next.data, 3);
        assertEquals(n.next.next, null);
    }

    @Test
    public void insert_after() throws Exception {
        int[] A = {1,2,4};
        Node n = Main.array_to_list(A);
        Main.insert_after(n.next, 3);
        assertEquals(n.next.next.data, 3);
        assertEquals(n.next.next.next.data, 4);
    }

}