package de.ItProject2018.Silas;

public class Main {

    public static void main(String[] args) throws InterruptedException {
        RaspBerrySendSerial SendSerial = new RaspBerrySendSerial();
        try {
            SendSerial.RaspBerrySendSerial();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
