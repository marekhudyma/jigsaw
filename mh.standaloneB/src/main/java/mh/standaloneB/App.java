package mh.standaloneB;

public class App {

    public static void main(String[] args) {

        int counter = 0;
        while(true) {
            sleep1second();
            System.out.println("Hello World " + ++counter);

        }
    }

    private static void sleep1second() {
        try {
            Thread.sleep(1_000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}