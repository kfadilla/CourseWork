public class Main {

    static void rotate(int[] A) {
        for(int i =A.length -1; i>0; i--) { //swap position
            int temp = A[i];
            A[i] = A[i-1];
            A[i-1] = temp;
        }
    }
}


