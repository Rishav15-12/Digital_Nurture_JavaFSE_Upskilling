import java.util.ArrayList;
import java.util.Scanner;

public class Q24_ArrayListDemo {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayList<String> studentNames = new ArrayList<>();

        System.out.print("Enter number of students: ");
        int n = sc.nextInt();
        sc.nextLine(); // consume newline

        for (int i = 1; i <= n; i++) {
            System.out.print("Enter name of student " + i + ": ");
            String name = sc.nextLine();
            studentNames.add(name);
        }

        System.out.println("\nStudent Names:");
        for (String name : studentNames) {
            System.out.println(name);
        }

        sc.close();
    }
}
