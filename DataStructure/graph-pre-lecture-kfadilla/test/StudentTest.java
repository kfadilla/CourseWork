import static org.junit.Assert.*;
import static sequences.Algorithms.*;
import graphs.AdjacencyList;
import org.junit.Test;
import java.util.Arrays;
import java.util.Random;

public class StudentTest {

    @Test
    public void testNumVertices() {
        for (int n = 0; n != 10; ++n) {
            AdjacencyList G = new AdjacencyList(n);
            assertEquals(n, G.numVertices());
        }
    }

    @Test
    public void testAddEdge() {
        int n = 6;
        AdjacencyList G = new AdjacencyList(n);
        G.addEdge(0,0);
        G.addEdge(1,2); G.addEdge(1,4);
        G.addEdge(2,5);
        G.addEdge(3,5); G.addEdge(3,0);
        G.addEdge(4,2);
        G.addEdge(5,4);

        // Adjacency matrix representation
        boolean H[][] = new boolean[n][n];
        H[0][0] = true;
        H[1][2] = true; H[1][4] = true;
        H[2][5] = true;
        H[3][5] = true; H[3][0] = true;
        H[4][2] = true;
        H[5][4] = true;

        for (Integer u : G.vertices())
            for (Integer v : G.adjacent(u)) {
                assertTrue(H[u][v]);
            }
        for (int u = 0; u != n; ++u)
            for (int v = 0; v != n; ++v)
                if (H[u][v])
                    assertTrue(contains(G.adjacent(u), v));
    }

    @Test
    public void testVertices() {
        int n = 5;
        AdjacencyList G = new AdjacencyList(n);
        int i = 0;
        for (Integer u : G.vertices())
            assertEquals(u, new Integer(i++));
        i = 0;
        for (Integer u : G.vertices())
            assertEquals(u, new Integer(i++));
    }

    @Test
    public void testAdjacent() {
        int n = 6;
        AdjacencyList G = new AdjacencyList(n);
        boolean H[][] = new boolean[n][n];
        H[0][0] = true;
        H[1][2] = true; H[1][4] = true;
        H[2][5] = true;
        H[3][5] = true; H[3][0] = true;
        H[4][2] = true;
        H[5][4] = true;
        for (int u = 0; u != n; ++u)
            for (int v = 0; v != n; ++v)
                if (H[u][v])
                    G.addEdge(u, v);

        for (int u = 0; u != n; ++u) {
            for (Integer v : G.adjacent(u))
                assertTrue(H[u][v]);
            // Do it a second time to check that no mutable state funny-business is going on.
            for (Integer v : G.adjacent(u))
                assertTrue(H[u][v]);
        }
    }

    @Test
    public void bigAddVerticesAdjacentRandom() {
        Random gen = new Random();
        int n = 100, k = 1000;
        boolean[][] H = new boolean[n][n];
        AdjacencyList G = new AdjacencyList(n);
        for (int i = 0; i != k; ++i) {
            int u = gen.nextInt(n);
            int v = gen.nextInt(n);
            H[u][v] = true;
            G.addEdge(u, v);
            equivalentGraph(G, H);
        }
    }

    public void equivalentGraph(AdjacencyList G, boolean H[][]) {
        int n = G.numVertices();
        for (Integer u : G.vertices())
            for (Integer v : G.adjacent(u)) {
                assertTrue(H[u][v]);
            }
        for (int u = 0; u != n; ++u)
            for (int v = 0; v != n; ++v)
                if (H[u][v])
                    assertTrue(contains(G.adjacent(u), v));
    }
}
