import java.util.ArrayList;
import java.util.List;

public class Q40_VirtualThreadDemo {

    public static void main(String[] args) throws InterruptedException {

        System.out.println("Virtual Threads Java 21");

        int numberOfThreads = 100_000;

        // Virtual Threads Test
        long virtualStart = System.currentTimeMillis();

        List<Thread> virtualThreads = new ArrayList<>();

        for (int i = 1; i <= numberOfThreads; i++) {
            int id = i;

            Thread vt = Thread.startVirtualThread(() -> {
                System.out.println("Virtual Thread " + id);
            });

            virtualThreads.add(vt);
        }

        for (Thread t : virtualThreads) {
            t.join();
        }

        long virtualEnd = System.currentTimeMillis();

        System.out.println("\nVirtual Threads Time: "
                + (virtualEnd - virtualStart) + " ms");

        // Traditional Threads Test
        long platformStart = System.currentTimeMillis();

        List<Thread> platformThreads = new ArrayList<>();

        for (int i = 1; i <= numberOfThreads; i++) {
            int id = i;

            Thread pt = new Thread(() -> {
                System.out.println("Platform Thread " + id);
            });

            pt.start();
            platformThreads.add(pt);
        }

        for (Thread t : platformThreads) {
            t.join();
        }

        long platformEnd = System.currentTimeMillis();

        System.out.println("\nPlatform Threads Time: "
                + (platformEnd - platformStart) + " ms");
    }
}
