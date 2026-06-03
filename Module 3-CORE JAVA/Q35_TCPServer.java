/*
 * Q35 - TCP Server
 * Listens for client connections and enables two-way communication.
 */

import java.io.*;
import java.net.*;

public class Q35_TCPServer {

    public static void main(String[] args) {

        try (ServerSocket serverSocket = new ServerSocket(5000)) {

            System.out.println("TCP Server Started...");
            System.out.println("Waiting for client connection...");

            Socket socket = serverSocket.accept();
            System.out.println("Client connected: " +
                    socket.getInetAddress());

            BufferedReader serverInput =
                    new BufferedReader(
                            new InputStreamReader(System.in));

            BufferedReader clientInput =
                    new BufferedReader(
                            new InputStreamReader(socket.getInputStream()));

            PrintWriter clientOutput =
                    new PrintWriter(socket.getOutputStream(), true);

            String message;

            while (true) {

                message = clientInput.readLine();

                if (message == null || message.equalsIgnoreCase("exit")) {
                    System.out.println("Client disconnected.");
                    break;
                }

                System.out.println("Client: " + message);

                System.out.print("Server: ");
                String reply = serverInput.readLine();

                clientOutput.println(reply);

                if (reply.equalsIgnoreCase("exit")) {
                    break;
                }
            }

            socket.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
