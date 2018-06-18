package de.ItProject2018.Silas;

import com.pi4j.io.gpio.*;
import sun.security.util.BitArray;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;
import java.util.concurrent.TimeUnit;

public class RaspBerrySendSerial {

    //Definiere Variablen für Controller und Pins
    protected GpioController gpioController;
    protected GpioPinDigitalOutput pinSetServoActive;
    protected GpioPinDigitalOutput pinSetMotorActive;
    protected GpioPinDigitalOutput pinSendData1;
    protected GpioPinDigitalOutput pinSendData2;
    protected GpioPinDigitalOutput pinSendData3;
    protected GpioPinDigitalOutput pinSendData4;
    protected GpioPinDigitalOutput pinSendData5;
    protected GpioPinDigitalOutput pinSendData6;
    protected GpioPinDigitalOutput pinSendData7;
    protected GpioPinDigitalOutput pinSendData8;
    protected ArrayList<GpioPinDigitalOutput> OutPutPins = new ArrayList<GpioPinDigitalOutput>();

    //Objekt für Hilfsklasse
    RaspBerryHelper Helper;


    public void RaspBerrySendSerial() throws InterruptedException{
        //Erstelle Objekt für Helfer
        Helper = new RaspBerryHelper();

        //Beginn Pin ansprechen
        System.out.println("<---- Initialized Serial Sending ---->");

        gpioController = GpioFactory.getInstance();

        //Initialisiere Pins zur Aktivierung der Datenübertragunng
        pinSetServoActive = gpioController.provisionDigitalOutputPin(RaspiPin.GPIO_00, "Send Servo Active", PinState.LOW);
        pinSetMotorActive = gpioController.provisionDigitalOutputPin(RaspiPin.GPIO_01, "Send Motor Active", PinState.LOW);
        OutPutPins.add(pinSendData1 = gpioController.provisionDigitalOutputPin(RaspiPin.GPIO_02, "Send Data Bit 1", PinState.HIGH));
        OutPutPins.add(pinSendData2 = gpioController.provisionDigitalOutputPin(RaspiPin.GPIO_03, "Send Data Bit 2", PinState.HIGH));
        OutPutPins.add(pinSendData3 = gpioController.provisionDigitalOutputPin(RaspiPin.GPIO_04, "Send Data Bit 3", PinState.HIGH));
        OutPutPins.add(pinSendData4 = gpioController.provisionDigitalOutputPin(RaspiPin.GPIO_05, "Send Data Bit 4", PinState.HIGH));
        OutPutPins.add(pinSendData5 = gpioController.provisionDigitalOutputPin(RaspiPin.GPIO_06, "Send Data Bit 5", PinState.HIGH));
        OutPutPins.add(pinSendData6 = gpioController.provisionDigitalOutputPin(RaspiPin.GPIO_12, "Send Data Bit 6", PinState.HIGH));
        OutPutPins.add(pinSendData7 = gpioController.provisionDigitalOutputPin(RaspiPin.GPIO_13, "Send Data Bit 7", PinState.HIGH));
        OutPutPins.add(pinSendData8 = gpioController.provisionDigitalOutputPin(RaspiPin.GPIO_14, "Send Data Bit 8", PinState.HIGH));

        //Setze "Shutdown" Argumente (Alle Pins auf LOW)
        for (int i = 0; i < OutPutPins.size(); i++) {
            OutPutPins.get(i).setShutdownOptions(true, PinState.LOW);
        }
        pinSetMotorActive.setShutdownOptions(true, PinState.LOW);
        pinSetServoActive.setShutdownOptions(true, PinState.LOW);

        //Initialisiere Standard Werte der Ausgabe
        SetDefaultSerialValues();
    }

    public void SetDefaultSerialValues() throws InterruptedException {
        /*
        ArrayList<Integer> BitArray = Helper.GetBitArrayFromInt(127);
        for (int i = 0; i < BitArray.size(); i++) {
            System.out.println(BitArray.get(i));
        }
        System.out.println("---------------------------");
        System.out.println(BitArray.size());
        System.out.println("---------------------------");
        */
        SendMotorValue(127);
        SendServoValue(127);
    }

    public void SendMotorValue(int x) throws InterruptedException {
        ArrayList<Integer> BitArray = Helper.GetBitArrayFromInt(x);
        SetPinStateByArrayList(BitArray);
        pinSetMotorActive.high();
        System.out.println("Motor data send!");
        Thread.sleep(50);
        pinSetMotorActive.low();
        BitArray.clear();
    }

    public void SendServoValue(int x) throws InterruptedException {
        ArrayList<Integer> BitArray = Helper.GetBitArrayFromInt(x);
        SetPinStateByArrayList(BitArray);
        pinSetServoActive.high();
        System.out.println("Servo data send!");
        Thread.sleep(50);
        pinSetServoActive.low();
        BitArray.clear();
    }

    private void SetPinStateByArrayList(ArrayList<Integer> bitArray) {
        for (int i = 0; i < bitArray.size(); i++) {
            if (bitArray.get(i) == 1){
                OutPutPins.get(i).low();
            } else if (bitArray.get(i) == 0){
                OutPutPins.get(i).high();
            }
        }
    }
}
