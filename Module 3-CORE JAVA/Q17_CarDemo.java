class Car {
    String make;
    String model;
    int year;

    void displayDetails() {
        System.out.println("Make: " + make);
        System.out.println("Model: " + model);
        System.out.println("Year: " + year);
    }
}

public class Q17_CarDemo {
    public static void main(String[] args) {

        Car c = new Car();
        c.make = "Toyota";
        c.model = "Camry";
        c.year = 2024;

        c.displayDetails();
    }
}
