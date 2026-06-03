import java.util.*;

public class Q02_SimpleCalculator {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);

        System.out.print("Enter first number: ");
        double x = s.nextDouble();

        System.out.print("Enter second number: ");
        double y = s.nextDouble();

        System.out.println("Choose operation:");
        System.out.println("1. Addition (+)");
        System.out.println("2. Subtraction (-)");
        System.out.println("3. Multiplication (*)");
        System.out.println("4. Division (/)");

        int choice = s.nextInt();

        switch (choice) {
            case 1:
                System.out.println("Result = " + (x + y));
                break;
            case 2:
                System.out.println("Result = " + (x - y));
                break;
            case 3:
                System.out.println("Result = " + (x * y));
                break;
            case 4:
                if (y != 0)
                    System.out.println("Result = " + (x / y));
                else
                    System.out.println("Division by zero is not allowed.");
                break;
            default:
                System.out.println("Invalid choice.");
        }

        s.close();
    }
}
