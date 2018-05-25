package mh.standalone;

import mh.library.without.HelloWorldPrinter;

public class App {

    public static void main(String[] args) throws InterruptedException {

        HelloWorldPrinter printer = new HelloWorldPrinter();
        printer.printForever();

    }
}
