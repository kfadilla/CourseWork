import junit.framework.TestCase;
import java.util.Arrays;

public class MainTest extends TestCase {
    public void testRotate() throws Exception { //check
        {
            int[] A = {7,4,12,53,32};
            int[] A_shifted = {32,7,4,12,53};
            Main.rotate(A);
            assertTrue(Arrays.equals(A, A_shifted));
            int[] B = {7,4,12,53};
            int[] B_shifted = {53,7,4,12};
            Main.rotate(B);
            assertTrue(Arrays.equals(B, B_shifted));
            int[] C = {1,2,3};
            int[] C_shifted = {3,1,2};
            Main.rotate(C);
            assertTrue(Arrays.equals(C, C_shifted));
            int[] D = {1};
            int[] D_shifted = {1};
            Main.rotate(D);
            assertTrue(Arrays.equals(D, D_shifted));
        }
    }
}