package mh;

public class App {

    public static void main(String[] args) throws InterruptedException {

        int counter = 0;
        while(true) {
            System.out.println("Hello World " + ++counter);
            Thread.sleep(1_000);
        }
    }
}
