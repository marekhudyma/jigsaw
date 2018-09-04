package mh.libraryB;

public class HelloWorldPrinter {

    private int counter = 0;

    public void printForever() {
        while(true) {
            System.out.println("Hello World " + ++counter);
            sleep1second();
        }
    }

    private void sleep1second() {
        try {
            Thread.sleep(1_000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
