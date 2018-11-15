import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class Flood {

    // Students implement this flood function.
    //algorithm
    //find if there is any neighbor that has the same color then flood it
    public static void flood(WaterColor color,
			     List<Coord> flooded_list,
			     Map<Coord,Tile> tiles,
			     Integer board_size)
    {
        for (int i = 0; i != flooded_list.size(); ++i) {   //O(n)
            Coord c = (Coord)flooded_list.get(i);
            List<Coord> cN = c.neighbors(board_size.intValue()); //get the neighbour of one of the flood list element
            for(int j  = 0; j!= cN.size() ; ++j){ //O(n)
                Coord add = (Coord) cN.get(j); //checking each neighbour per loop
                if (!flooded_list.contains(add) && ((Tile)tiles.get(add)).getColor() == color) { //checking condition
                    flooded_list.add(add);
                }
            }
        }
    }
    public static void flood1(WaterColor color,
                             List<Coord> flooded_list,
                             Map<Coord,Tile> tiles,
                             Integer board_size)
    {
        for (int i = 0; i != flooded_list.size(); ++i) {   //O(n)
            Coord c = (Coord)flooded_list.get(i);
            Coord[] cN = c.neighbors(board_size.intValue()).toArray(new Coord[c.neighbors(board_size.intValue()).size()]); //get the neighbour of one of the flood list element
            for(int j  = 0; j!= cN.length;++j){ //O(n)
                Coord add = (Coord) cN[j]; //checking each neighbour per loop
                if (!flooded_list.contains(add) && ((Tile)tiles.get(add)).getColor() == color) { //checking condition
                    flooded_list.add(add);
                }
            }
        }
    }


    /*tesing code
    public static void flood2(WaterColor color,
                              List<Coord> flooded_list,
                              Map<Coord,Tile> tiles,
                              Integer board_size)
    {
        for (int i = 0; i != flooded_list.size(); ++i) {   //O(n)
            Coord c = flooded_list.get(i);
            if (c.up().onBoard(1)&&(tiles.get(c.up()).getColor() == color) && !flooded_list.contains(c.up())) {  //check whether the neighbours is on board and check whether the neighbours is in the same color
                flooded_list.add(c.up());
            }
            if (c.down().onBoard(1)&&(tiles.get(c.down()).getColor() == color) && !flooded_list.contains(c.down())) {
                flooded_list.add(c.down());
            }
            if (c.left().onBoard(1)&&(tiles.get(c.left()).getColor() == color) && !flooded_list.contains(c.left())) {
                flooded_list.add(c.left());
            }
            if (c.right().onBoard(1)&&(tiles.get(c.right()).getColor() == color) && !flooded_list.contains(c.right())){
                flooded_list.add(c.right());
            }
        }
    }
    */
}
