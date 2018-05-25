package mh.library.without;

import jdk.net.*;

public class HelloWorldPrinter {

    private int counter = 0;

    public void printForever() {

        // requires jdk.net;
        try {
            NetworkPermission networkPermission = new NetworkPermission("");
        } catch (Exception e) {
        }

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
