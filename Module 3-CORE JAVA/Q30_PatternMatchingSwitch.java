public class Q30_PatternMatchingSwitch {

    static void test(Object obj) {
        switch (obj) {
            case Integer i ->
                System.out.println("Integer value: " + i);

            case String s ->
                System.out.println("String value: " + s);

            case Double d ->
                System.out.println("Double value: " + d);

            case Long l ->
                System.out.println("Long value: " + l);

            case null ->
                System.out.println("Object is null");

            default ->
                System.out.println("Unknown type: " + obj);
        }
    }

    public static void main(String[] args) {
        test(100);
        test("Hello Java 21");
        test(45.67);
        test(999L);
        test(true);
        test(null);
    }
}
