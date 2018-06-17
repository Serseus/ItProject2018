package de.ITProject2018.Silas;

import java.util.ArrayList;
import java.util.Collections;

public class RaspBerryHelper {
    public RaspBerryHelper(){

    }

    public ArrayList<Integer> GetBitArrayFromInt(int Input){
        String stringToParse = Integer.toBinaryString(Input);
        ArrayList<Integer> BitArray = new ArrayList<>();
        for (int i = 0; i < stringToParse.length(); i++) {
            BitArray.add(Character.getNumericValue(stringToParse.charAt(i)));
            //System.out.println(BitArray.get(i));
        }
        //System.out.println("---------------------------");
        Collections.reverse(BitArray);
        if (BitArray.size() < 8){
            for (int i = BitArray.size(); i < 8; i++) {
                BitArray.add(0);
            }
        }
        return BitArray;
    }

}
