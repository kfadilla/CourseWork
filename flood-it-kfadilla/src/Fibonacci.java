import static org.junit.Assert.*;
import org.junit.Test;

/**
 * The following table shows the first ten numbers in the
 * Fibonacci sequence:
 * 
 *      n  :  0  1  2  3  4  5  6  7  8  9 ...
 *  Fib(n) :  1  1  2  3  5  8 13 21 34 55 ...
 * 
 * @author <put your name here>
 */

public class Fibonacci {

  /**
   * TODO: Implement the recursive definition directly.
   */
  public static int fib1(int n) {
    return 0;
  }

  /**
   * TODO: Implement recursively by calling a tail-recursive helper.
   */
  public static int fib2(int n){
    return 0;
  }

  /**
   * TODO: Run this class as an application.
   */
  public static void main(String... args) {
    assert fib1(9) == 55;
    assert fib2(9) == 55;
  }
  
  /**
   * TODO: Run this class as a JUnit test. Add additional tests to
   * the following methods.
   */
  
  @Test
  public void testFib1() {
    assertEquals(55, fib1(9));
  }
  
  @Test
  public void testFib2() {
    assertEquals(55, fib2(9));
  }
}
