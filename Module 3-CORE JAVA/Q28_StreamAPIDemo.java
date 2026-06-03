import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class Q28_StreamAPIDemo {
    public static void main(String[] args) {

        // Create a List of integers
        List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

        // Use Stream API to filter even numbers
        List<Integer> evenNumbers = numbers.stream()
                                           .filter(n -> n % 2 == 0)
                                           .collect(Collectors.toList());

        // Display the result
        System.out.println("Original List: " + numbers);
        System.out.println("Even Numbers: " + evenNumbers);
    }
}
