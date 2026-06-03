public class Q07_TypeCastingDemo {
    public static void main(String[] args) {
        // Double to int (narrowing type casting)
        double decimalValue = 12.8;
        int intValue = (int) decimalValue;

        // Int to double (widening type casting)
        int number = 25;
        double doubleValue = (double) number;

        System.out.println("Original double value: " + decimalValue);
        System.out.println("After casting to int: " + intValue);

        System.out.println("Original int value: " + number);
        System.out.println("After casting to double: " + doubleValue);
    }
}
