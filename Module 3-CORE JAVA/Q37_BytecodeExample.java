/*
 * Q37 - Using javap to Inspect Bytecode
 * Objective: Explore compiled .class files.
 * Task: Compile a Java class and inspect its bytecode using javap.
 */

public class Q37_BytecodeExample {

    void show() {
        System.out.println("javap demo");
    }

    public static void main(String[] args) {
        Q37_BytecodeExample obj = new Q37_BytecodeExample();
        obj.show();
    }
}
