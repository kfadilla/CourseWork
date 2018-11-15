import java.util.ArrayList;

public class SeamCarving {

	// TODO: Find the seam with the lowest disruption measure
	public static Seam carve_seam(int[][] disruption_matrix) {
		ArrayList<SeamSegment> listofss = new ArrayList<>();
		for (int length = 0; length < disruption_matrix[0].length; length++) {
			SeamSegment s = new SeamSegment(disruption_matrix[0][length], new Coord(0, length), null);
			listofss.add(s);
		}
		for (int i = 1; i < disruption_matrix.length; i++) {
			ArrayList<SeamSegment> temlistofss = new ArrayList<>();
			for (int j = 0; j < disruption_matrix[0].length; j++) {
				int minD = Integer.MAX_VALUE;
				SeamSegment ss = new SeamSegment(0, new Coord(i, j), null);
				for (int k = 0; k < disruption_matrix[0].length; k++) {
					if (new Coord(i - 1, k).isYAdjacent(new Coord(i, j), disruption_matrix[0].length)) {
						if (listofss.get(k).disruption < minD) {
							minD = listofss.get(k).disruption;
							ss = listofss.get(k);
						}
					}
				}
				SeamSegment cs = new SeamSegment(disruption_matrix[i][j] + minD, new Coord(i, j), ss);
				temlistofss.add(cs);
			}
			listofss = temlistofss;
		}
		int a = Integer.MAX_VALUE;
		SeamSegment small = null;
		for (SeamSegment ss : listofss) {
			if (ss.disruption < a) {
				a = ss.disruption;
				small = ss;
			}
		}
		Seam result = small.getSeam();
		ArrayList<Coord> points = new ArrayList<>();
		for(int i =result.points.size()-1;i>-1;i--){
			points.add(result.points.get(i));
		}
		return new Seam(result.disruption,points);
	}
}