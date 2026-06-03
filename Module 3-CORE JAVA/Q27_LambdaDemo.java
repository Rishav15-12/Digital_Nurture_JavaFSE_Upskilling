import java.util.*;

public class Q27_LambdaDemo {
    public static void main(String[] args) {

        // Create a list of strings
        List<String> names = Arrays.asList("Banana", "Apple", "Mango", "Orange");

        // Sort using lambda expression
        Collections.sort(names, (s1, s2) -> s1.compareTo(s2));

        // Display the sorted list
        System.out.println("Sorted List:");
        for (String name : names) {
            System.out.println(name);
        }
    }
}
