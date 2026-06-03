/*
 * Q35 - TCP Client
 * Connects to the server and enables two-way communication.
 */

import java.io.*;
import java.net.*;

public class Q35_TCPClient {

    public static void main(String[] args) {

        try (Socket socket = new Socket("localhost", 5000)) {

            System.out.println("Connected to Server.");

            BufferedReader userInput =
                    new BufferedReader(
                            new InputStreamReader(System.in));

            BufferedReader serverInput =
                    new BufferedReader(
                            new InputStreamReader(socket.getInputStream()));

            PrintWriter serverOutput =
                    new PrintWriter(socket.getOutputStream(), true);

            while (true) {

                System.out.print("Client: ");
                String message = userInput.readLine();

                serverOutput.println(message);

                if (message.equalsIgnoreCase("exit")) {
                    break;
                }

                String response = serverInput.readLine();

                if (response == null ||
                    response.equalsIgnoreCase("exit")) {
                    break;
                }

                System.out.println("Server: " + response);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
