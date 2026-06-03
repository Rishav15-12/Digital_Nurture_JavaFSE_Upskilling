/*
 * Q38 - Decompile a Class File
 * Objective: Reverse engineer compiled Java bytecode.
 * Task: Compile a Java program and decompile its .class file using a tool
 * such as JD-GUI or CFR, then analyze the recovered source code.
 */

public class Q38_DecompileExample {

    public static void main(String[] args) {

        System.out.println("Decompiler Demo");

        System.out.println("\n=== Decompile a Class File Experiment ===");
        System.out.println("1. Save this file as Q38_DecompileExample.java");
        System.out.println("2. Compile using: javac Q38_DecompileExample.java");
        System.out.println("3. This creates: Q38_DecompileExample.class");
        System.out.println("4. Open the .class file in JD-GUI or CFR.");
        System.out.println("5. Observe the decompiled source code.");
        System.out.println("\nAnalysis:");
        System.out.println("- Class structure is preserved.");
        System.out.println("- Method definitions are reconstructed.");
        System.out.println("- Comments are not recovered because they are not stored in bytecode.");
        System.out.println("- Formatting may differ from the original source.");
        System.out.println("- Decompiled code is usually very similar to the original program.");
    }
}
