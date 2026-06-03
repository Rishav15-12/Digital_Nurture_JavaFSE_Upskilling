class Animal {
    void makeSound() {
        System.out.println("Some generic animal sound");
    }
}

class Dog extends Animal {
    @Override
    void makeSound() {
        System.out.println("Bark");
    }
}

public class Q18_InheritanceExample {
    public static void main(String[] args) {

        Animal a = new Animal();
        a.makeSound();   // Parent method

        Dog d = new Dog();
        d.makeSound();    // Overridden method
    }
}
