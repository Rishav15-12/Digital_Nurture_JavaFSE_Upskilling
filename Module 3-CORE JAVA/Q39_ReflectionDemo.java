import java.lang.reflect.Method;
import java.lang.reflect.Parameter;

public class Q39_ReflectionDemo {

    public static void main(String[] args) throws Exception {

        // Load class dynamically
        Class<?> clazz = Class.forName("java.lang.String");

        System.out.println("Class Name: " + clazz.getName());
        System.out.println("\nMethods and Parameters:");

        // Print method names and parameters
        for (Method method : clazz.getDeclaredMethods()) {
            System.out.print(method.getName() + "(");

            Parameter[] params = method.getParameters();

            for (int i = 0; i < params.length; i++) {
                System.out.print(params[i].getType().getSimpleName());

                if (i < params.length - 1) {
                    System.out.print(", ");
                }
            }

            System.out.println(")");
        }

        // Dynamically invoke a method
        String text = "hello world";

        Method toUpperCaseMethod = clazz.getMethod("toUpperCase");

        Object result = toUpperCaseMethod.invoke(text);

        System.out.println("\nInvoked Method: toUpperCase()");
        System.out.println("Original String: " + text);
        System.out.println("Result: " + result);
    }
}
