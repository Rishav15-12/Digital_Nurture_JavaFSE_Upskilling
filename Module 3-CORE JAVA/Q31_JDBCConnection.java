import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Q31_JDBCConnection {

    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/testdb";
        String user = "root";
        String password = "root";

        try {

            // Load JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Create Connection
            Connection con =
                    DriverManager.getConnection(
                            url, user, password);

            System.out.println("Database Connected Successfully!");

            // Create Statement
            Statement stmt = con.createStatement();

            // Execute SELECT Query
            String query = "SELECT * FROM students";

            ResultSet rs = stmt.executeQuery(query);

            System.out.println("\nStudent Records:");
            System.out.println("----------------------------");

            while (rs.next()) {

                int id = rs.getInt("id");
                String name = rs.getString("name");
                int age = rs.getInt("age");

                System.out.println(
                        "ID: " + id +
                        ", Name: " + name +
                        ", Age: " + age);
            }

            rs.close();
            stmt.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
