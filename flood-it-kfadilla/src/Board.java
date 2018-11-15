import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.LinkedList;
import java.util.List;
import java.lang.reflect.Method;

/**
 * A Board represents the current state of the game. Boards know their
 * dimension, the collection of coordinates that are in the current
 * flooded region, and mapping from coordinates to tiles.
 * 
 * @author <Michael Fadillah>
 */

public class Board {
  private List<Coord> flooded;
  private Map<Coord, Tile> tiles;
  private int size;
  
  /**
   * Constructs a square game board of the given size, initializes the list of 
   * inside tiles to include just the tile in the upper left corner, and puts 
   * all the other tiles in the outside list.
   */
  public Board(int size) {
    flooded = new LinkedList<>();
		tiles = new HashMap<>();
    this.size = size;
    for (int y = 0; y < size; y++)
      for (int x = 0; x < size; x++) {
        Coord coord = new Coord(x, y);
				Tile t = new Tile(coord);
				tiles.put(coord, t);
      }
    // Move the corner tile into the flooded region and run flood on its color.
    Tile corner = tiles.get(Coord.ORIGIN);
    flooded.add(Coord.ORIGIN);
    flood(0, corner.getColor());
  }
  
  /**
   * Returns the tile at the specified coordinate.
   */ 
  public Tile get(Coord coord) {
			return tiles.get(coord);
  }
  
  /**
   * Returns the size of this board.
   */
  public int getSize() {
    return size;
  }
  
  /**
   * TODO
   * 
   * Returns true iff all tiles on the board have the same color.
   */
  public boolean fullyFlooded() {
    return flooded.size() == size * size;
  }
  
  /**
   * TODO
   * 
   * Updates this board by changing the color of the current flood region 
   * and extending its reach.
   */
  public void flood(int k, WaterColor color) {

    // Change the colors of the already-flooded tiles
  	for (Coord coord : flooded)
				tiles.get(coord).setColor(color);

		// Call the student's flood function.
		// Like this: 
		// Flood.flood(color, flooded, tiles, size);
		// but reflectively to choose between the different
		// versions of the flood function.
    try {
			Flood f = new Flood();
      Class<?> c = Flood.class; 
      Class<?>[] argTypes = new Class[] { WaterColor.class, List.class, Map.class, Integer.class };
      String name = "flood" + (k == 0 ? "" : k);
      Method floodFunction = c.getDeclaredMethod(name, argTypes);
      floodFunction.invoke(f, color, flooded, tiles, new Integer(size));  
    } 
    catch (NoSuchMethodException e) {
      System.out.println("Something went terribly wrong with the flood reflection!");
      e.printStackTrace();
    } catch (IllegalAccessException e) {
      System.out.println("Something went terribly wrong with the flood reflection!");
      e.printStackTrace();
    } catch (InvocationTargetException e) {
      System.out.println("Something went terribly wrong with the flood reflection!");
      e.printStackTrace();
    }

  }
  
  /**
   * TODO
   * 
   * Explore a variety of algorithms for handling a flood. Use the
   * same interface as for flood above, but add an index so your
   * methods are named flood1, flood2, ..., and so on. Then, use the
   * batchTest() tool in Driver to run game simulations and then
   * display a graph showing the run times of all your different flood
   * functions. Do not delete your flood code attempts. For each
   * variety of flood, including the one above that you eventually
   * settle on, write a comment that describes your algorithm in
   * English. For those implementations that you abandon, state your
   * reasons.
  
  public void flood1(WaterColor color) {
    
  }
  
  public void flood2(WaterColor color) {
    
  }
   */
  
  /**
   * TODO
   * 
   * Returns the "best" GameColor for the next move. 
   * 
   * Modify this comment to describe your algorithm. Possible
   * strategies to pursue include maximizing the number of tiles in
   * the current flooded region, or maximizing the size of the
   * perimeter of the current flooded region.
   */
  public WaterColor suggest() {
    WaterColor cornerColor = tiles.get(Coord.ORIGIN).getColor();
    return WaterColor.pickOneExcept(cornerColor);
  }
  
  /**
   * Returns a string representation of this board. Tiles are given as their
   * color names, with those inside the flooded region written in uppercase.
   */ 
  public String toString() {
    StringBuilder ans = new StringBuilder();
    for (int y = 0; y < size; y++) {
      for (int x = 0; x < size; x++) {
        Coord curr = new Coord(x, y);
        WaterColor color = get(curr).getColor();
        ans.append(flooded.contains(curr)
									 ? color.toString().toUpperCase()
									 : color);
        ans.append("\t");
      }
      ans.append("\n");
    }
    return ans.toString();
  }
  
  /**
   * Simple testing.
   */
  public static void main(String... args) {
    // Print out boards of size 1, 2, ..., 5
    int n = 5;
    for (int size = 1; size <= n; size++) {
      Board someBoard = new Board(size);
      System.out.println(someBoard);
    }
  }
}






