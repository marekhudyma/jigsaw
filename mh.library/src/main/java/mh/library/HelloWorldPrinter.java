package mh.library;

import com.google.common.util.concurrent.Uninterruptibles;

import java.util.concurrent.TimeUnit;

public class HelloWorldPrinter {

    private int counter = 0;

    public void printForever() {
        while(true) {
            System.out.println("Hello World " + ++counter);
            Uninterruptibles.sleepUninterruptibly(1, TimeUnit.SECONDS);
            //sleep1second();
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
