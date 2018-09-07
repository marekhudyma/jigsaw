package mh.libraryA;

public class HelloWorldPrinter {

    private int counter = 0;

    public void printForever() {
        while(true) {
            System.out.println("Hello World A " + ++counter);
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
