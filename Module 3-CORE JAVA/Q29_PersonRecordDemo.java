import java.util.Arrays;
import java.util.List;

record Person(String name, int age) {}

public class Q29_PersonRecordDemo {
    public static void main(String[] args) {

        // Creating record instances
        Person p1 = new Person("Alice", 20);
        Person p2 = new Person("Bob", 17);
        Person p3 = new Person("Charlie", 25);
        Person p4 = new Person("David", 15);

        // Printing record instances
        System.out.println("Person Records:");
        System.out.println(p1);
        System.out.println(p2);
        System.out.println(p3);
        System.out.println(p4);

        // Using records in a List
        List<Person> persons = Arrays.asList(p1, p2, p3, p4);

        // Filtering persons whose age is 18 or above using Streams
        System.out.println("\nPersons aged 18 or above:");
        persons.stream()
               .filter(person -> person.age() >= 18)
               .forEach(System.out::println);
    }
}
