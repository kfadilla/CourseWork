import junit.framework.TestCase;

import java.util.ArrayList;
import java.util.LinkedList;

import static org.junit.Assert.*;

public class BinaryTreeTest extends TestCase {
    BinaryTree<Integer> T;


    public BinaryTreeTest() { }

    @Override
    public void setUp() throws Exception {
        BinaryNode<Integer> n2 = new BinaryNode<>(2,null,null);
        BinaryNode<Integer> n5 = new BinaryNode<>(5,null,null);
        BinaryNode<Integer> n25 = new BinaryNode<>(5,n2,n5);
        BinaryNode<Integer> n8 = new BinaryNode<>(8, null, null);
        BinaryNode<Integer> n7 = new BinaryNode<>(7, null, n8);
        BinaryNode<Integer> r = new BinaryNode<>(6, n25, n7);
        T = new BinaryTree<>(r);
    }

    @org.junit.Test
    public void testPreorder() throws Exception {
        {
            ArrayList<Integer> B = new ArrayList<>();
            T.preorder((Integer k) -> { B.add(k); });
            int expected[] = { 6, 5, 2, 5, 7, 8 };
            for (int i = 0; i != expected.length; ++i)
                assertEquals((Integer)expected[i], B.get(i));
        }
    }

    @org.junit.Test
    public void testInorder() throws Exception {
        {
            ArrayList<Integer> B = new ArrayList<>();
            T.inorder((Integer k) -> { B.add(k); });
            int expected[] = { 2, 5, 5, 6, 7, 8 };
            for (int i = 0; i != expected.length; ++i)
                assertEquals((Integer)expected[i], B.get(i));
        }
    }

    @org.junit.Test
    public void testPostorder() throws Exception {
        {
            ArrayList<Integer> B = new ArrayList<>();
            T.postorder((Integer k) -> { B.add(k); });
            int expected[] = { 2, 5, 5, 8, 7, 6 };
            for (int i = 0; i != expected.length; ++i)
                assertEquals((Integer)expected[i], B.get(i));
        }
    }

}