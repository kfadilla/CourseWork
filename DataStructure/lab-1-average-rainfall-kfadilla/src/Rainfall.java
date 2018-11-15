import java.io.IOException;
import java.lang.ArithmeticException;
//change
public class Rainfall {

    public static double average_rainfall(int[] rainfall) throws IllegalArgumentException {
        int length = rainfall.length; //initialize variables
        double sum = 0;
        double count = 0;
        double average;
        if (length == 0) { //if clause when the divisor is zero
            throw new IllegalArgumentException("The divisor is 0"); //throw exception
        } else {
            try {
                for (int i = 0; i != length; ++i) { //forward traversal
                    //break the loop if the value of the array is -999
                    if (rainfall[i] == -999) {
                        break;
                    } //count the number of valid element in the array, and sum them up
                    if (rainfall[i] < 0) { //if the rainfall is negative, set it to 0
                    } else {
                        sum += rainfall[i];
                        ++count;
                    }
                }
                if (count == 0){
                    throw new IllegalArgumentException("");
                }
                average = sum / count; //calculate the average rainfall
                return average;
            } catch (Exception ae) { //throw an arithmeetic exception
                throw new IllegalArgumentException("The divisor is 0");
            }
        }
    }
}

