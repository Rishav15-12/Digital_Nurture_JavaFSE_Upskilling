import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;

public class Q22_FileWriteDemo {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter text to write to the file: ");
        String text = sc.nextLine();

        try {
            FileWriter writer = new FileWriter("output.txt");
            writer.write(text);
            writer.close();

            System.out.println("Data has been written to output.txt successfully.");
        } catch (IOException e) {
            System.out.println("Error writing to file: " + e.getMessage());
        }

        sc.close();
    }
}
