import junit.framework.TestCase;

public class MainTest extends TestCase {
    public void testAverage_rainfall() throws Exception {
        { //test case
            int A[] = {1,2,3};
            double averageA = Rainfall.average_rainfall(A);
            assertEquals(2.0, averageA);
            int B[] = {4,5,-3,-999,3,4,5,6};
            double averageB = Rainfall.average_rainfall(B);
            assertEquals(4.5, averageB);
            int C[] = {1};
            double averageC = Rainfall.average_rainfall(C);
        }
    }
}