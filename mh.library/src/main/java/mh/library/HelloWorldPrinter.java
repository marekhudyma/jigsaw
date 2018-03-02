package mh.library;

public class HelloWorldPrinter {

    private int counter = 0;

    public void printForever() throws InterruptedException {
        while(true) {
            System.out.println("Hello World " + ++counter);
            Thread.sleep(1_000);
        }
    }
}
