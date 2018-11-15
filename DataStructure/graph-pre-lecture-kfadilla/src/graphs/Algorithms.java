package graphs;

import sequences.SLinkedList;
import sequences.Queue;

import java.util.Map;
import java.util.function.Consumer;

public class Algorithms {

    static <V> void topo_sort(Graph<V> G, Consumer<V> output,
                              Map<V,Integer> num_pred) {
        // initialize the in-degrees to zero
        for (V u : G.vertices()) {
            num_pred.put(u, 0);
        }
        // compute the in-degree of each vertex
        for (V u : G.vertices())
            for (V v : G.adjacent(u))
                num_pred.put(v, num_pred.get(v) + 1);

        // collect the vertices with zero in-degree
        Queue<V> zeroes = new SLinkedList<V>();
        for (V v : G.vertices())
            if (num_pred.get(v) == 0)
                zeroes.push(v);

        // The main loop outputs a vertex with zero in-degree and subtracts
        // one from the in-degree of each of its successors, adding them to
        // the zeroes bag when they reach zero.
        while (! zeroes.empty()) {
            V u = zeroes.pop();
            output.accept(u);
            for (V v : G.adjacent(u)) {
                num_pred.put(v, num_pred.get(v) - 1);
                if (num_pred.get(v) == 0)
                    zeroes.push(v);
            }
        }
    }


}
