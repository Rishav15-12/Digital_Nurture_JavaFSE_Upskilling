import java.sql.*;

public class Q33_TransactionDemo {

    private static final String URL =
            "jdbc:mysql://localhost:3306/testdb";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    public static void transferMoney(int fromAccount,
                                     int toAccount,
                                     double amount) {

        Connection con = null;

        try {
            con = DriverManager.getConnection(
                    URL, USER, PASSWORD);

            // Start transaction
            con.setAutoCommit(false);

            // Debit from sender
            PreparedStatement debitStmt =
                    con.prepareStatement(
                            "UPDATE accounts SET balance = balance - ? " +
                            "WHERE id = ?");

            debitStmt.setDouble(1, amount);
            debitStmt.setInt(2, fromAccount);

            int debitRows = debitStmt.executeUpdate();

            // Credit to receiver
            PreparedStatement creditStmt =
                    con.prepareStatement(
                            "UPDATE accounts SET balance = balance + ? " +
                            "WHERE id = ?");

            creditStmt.setDouble(1, amount);
            creditStmt.setInt(2, toAccount);

            int creditRows = creditStmt.executeUpdate();

            if (debitRows > 0 && creditRows > 0) {
                con.commit();
                System.out.println(
                        "Transaction Successful!");
            } else {
                con.rollback();
                System.out.println(
                        "Transaction Failed. Rolled Back.");
            }

        } catch (Exception e) {

            try {
                if (con != null) {
                    con.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }

            System.out.println(
                    "Error occurred. Transaction rolled back.");
            e.printStackTrace();

        } finally {

            try {
                if (con != null) {
                    con.setAutoCommit(true);
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {

        System.out.println("Transaction Example");

        transferMoney(1, 2, 1000.0);
    }
}
