import java.sql.*;

public class Q32_StudentDAO {

    private static final String URL =
            "jdbc:mysql://localhost:3306/testdb";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    // Insert Student Record
    public void insert(int id, String name, int age) {

        String sql =
                "INSERT INTO students(id, name, age) VALUES(?, ?, ?)";

        try (Connection con =
                     DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.setString(2, name);
            ps.setInt(3, age);

            int rows = ps.executeUpdate();

            System.out.println(rows +
                    " record inserted successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update Student Record
    public void update(int id, String name, int age) {

        String sql =
                "UPDATE students SET name = ?, age = ? WHERE id = ?";

        try (Connection con =
                     DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setInt(2, age);
            ps.setInt(3, id);

            int rows = ps.executeUpdate();

            System.out.println(rows +
                    " record updated successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {

        Q32_StudentDAO dao = new Q32_StudentDAO();

        System.out.println("Insert and Update Operations in JDBC");

        // Insert a student
        dao.insert(101, "Rishav", 20);

        // Update the student
        dao.update(101, "Rishav Kumar", 21);
    }
}
