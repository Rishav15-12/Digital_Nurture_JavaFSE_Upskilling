/*
 * Q34 - Create and Use Java Modules
 * Simplified single-file demonstration
 */

public class Q34_ModuleDemo {

    static class MessageUtil {

        public static String getGreeting() {
            return "Welcome to Java Modules!";
        }

        public static String getVersion() {
            return "Version 1.0";
        }
    }

    public static void main(String[] args) {

        System.out.println("Java Modules");

        System.out.println("Greeting: " +
                MessageUtil.getGreeting());

        System.out.println("Version: " +
                MessageUtil.getVersion());

        System.out.println("\nModule Communication Successful!");

        System.out.println("\nNote:");
        System.out.println("In a real Java Module project,");
        System.out.println("MessageUtil would be placed in");
        System.out.println("module 'com.utils' and used by");
        System.out.println("module 'com.greetings' via");
        System.out.println("'requires' and 'exports'.");
    }
}
