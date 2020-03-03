package com.bridgelaz;

public class MoodAnalayezedCustom extends RuntimeException {

    public enum ExceptionType {
        ENTERED_NULL,ENTERED_EMPTY,NO_SUCH_CLASS_FOUND,NO_SUCH_METHOD_FOUND,NO_SUCH_FIELD_FOUND,
    }
    ExceptionType type;

    public MoodAnalayezedCustom(ExceptionType type, String message) {
        super (message);
        this.type =type;
    }
}
