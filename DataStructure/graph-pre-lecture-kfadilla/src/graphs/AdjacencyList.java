package graphs;
import sequences.*;

import java.util.Iterator;

/**
 * TODO
 *
 * Complete the AdjacencyList class, implementing all of the
 * methods needed for the Graph interface and
 * finish the constructor.
 *
 */
public class AdjacencyList implements Graph<Integer> {
    Array<SLinkedList<Integer>> adjacent;


    public AdjacencyList(int num_vertices) {
        adjacent = new Array<SLinkedList<Integer>>(num_vertices, null);
        for (int i = 0; i != num_vertices; ++i){
            adjacent.set(i, new SLinkedList<Integer>());
        }
    }

    public void addEdge(Integer source,Integer target) {
        adjacent.get(source).insert_front(target);
    }

    public Sequence<Integer> vertices(){
        return new Range<Integer>(new IntIter(0), new IntIter(adjacent.size()));
    }

    public Sequence<Integer> adjacent(Integer source){
        return new Range<Integer>(adjacent.get(source).begin(), adjacent.get(source).end());
    }

    public int numVertices(){
        return adjacent.size();
    }
}
