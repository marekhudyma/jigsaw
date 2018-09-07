package mh.standaloneC;

import org.apache.poi.hsmf.MAPIMessage;

public class App {

    public static void main(String[] args) {
        try {
            MAPIMessage msg = new MAPIMessage("");
        } catch (Exception e) {
            e.printStackTrace();
        }


        int counter = 0;
        while (true) {
            sleep1second();
            System.out.println("Hello World C " + ++counter);

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
