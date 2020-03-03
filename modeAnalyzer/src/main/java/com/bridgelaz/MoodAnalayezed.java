package com.bridgelaz;

import java.util.Objects;

public class MoodAnalayezed {



    public String message;
    public  MoodAnalayezed() {

    }
    public MoodAnalayezed(String messge) {
        this.message = messge;
    }
    public  String analyserMood(String message) {
        this.message = message;
        return  analayse();
    }

    public String analayse() {
        try {
            if (message.length() == 0)
                throw new MoodAnalayezedCustom(MoodAnalayezedCustom.ExceptionType.ENTERED_EMPTY, "please enter valid input");

            if (message.contains("sad"))
                return "Sad";
            else
                return "Happy";
        } catch (NullPointerException e) {
            throw new MoodAnalayezedCustom(MoodAnalayezedCustom.ExceptionType.ENTERED_NULL, "please enter valid input");
        }
    }

    @Override
    public  boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MoodAnalayezed that = (MoodAnalayezed) o;
        return Objects.equals(message, that.message);
    }

}