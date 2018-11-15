import java.lang.reflect.Array;
import java.util.*;


public class Routing {

    /**
     * TODO
     *
     * The findPaths function takes a board and a list of points
     * that need to be connected. The function returns
     * a list of paths that connect the points.
     *
     */
    static ArrayList<ArrayList<Coord>> pathList;
    static boolean found;

    public static ArrayList<ArrayList<Coord>>
    findPaths(Board board, ArrayList<Coord[]> points) {
        pathList = new ArrayList<ArrayList<Coord>>();

        for (int i = 0; i != points.size(); i++) {
            Coord[] pair = points.get(i);
            ArrayList<Coord> path = getPath(board, pair[0], pair[1]);
            if(path == null) {
                shiftArray(points);
                resetBoard(board, pathList);
                return findPaths(board, points);
            }
            setObstacle(board, path, i+1);
            pathList.add(path);
            System.out.println(pathList);
        }

        //for (int i = 0; i != pathList.size(); i++)
        //    System.out.println("paths" + pathList.get(i));
        return pathList;
    }

    public static void shiftArray(ArrayList<Coord[]> points) {
        Coord[] temp = points.get(0);
        for (int i = 0; i != points.size()-1; i++) {
            points.set(i, points.get(i+1));
        }
        points.set(points.size()-1, temp);
    }

    public static ArrayList<Coord>
    getPath(Board board,  Coord start, Coord end) {
        Map<Coord, Coord> prevCoord = new HashMap<Coord, Coord>();
        Queue<Coord> q = new LinkedList<Coord>();
        q.add(start);

        while (!q.isEmpty()) {

            Coord coord = q.remove();
            ArrayList<Coord> adj = board.adj(coord);

            for (Coord c : adj) {
                if (c.equals(end)) {
                    prevCoord.put(c, coord);
                    return getChain(start, end, prevCoord);
                } else if (prevCoord.get(c) == null && !board.isObstacle(c) && board.getValue(c) != 1 && board.getValue(c) == 0) {
                    prevCoord.put(c, coord);
                    q.add(c);
                }
            }
        }
        return null;
    }

    public static ArrayList<Coord>
    getChain (Coord start, Coord end, Map<Coord, Coord> prev) {
        ArrayList<Coord> list = null;
        if (prev.get(end) != null) {
            list = new ArrayList<Coord>();
            for (Coord coord = end; !coord.equals(start); coord = prev.get(coord)) {
                list.add(coord);
            }
        }
        list.add(start);
        Collections.reverse(list);
        return list;
    }

    public static void setObstacle(Board board, ArrayList<Coord> list, int val) {
        if (list != null) {
            for (int i = 0; i != list.size(); i++) {
                board.putValue(list.get(i), val);
            }
        }
    }
    public static void resetBoard(Board board, ArrayList<ArrayList<Coord>> pathList) {
        for (int i = 0; i != pathList.size(); i++) {
            for (int j = 0; j!= pathList.get(i).size(); j++) {
                Coord c = pathList.get(i).get(j);
                board.putValue(c, 0);
            }
        }

    }
}
