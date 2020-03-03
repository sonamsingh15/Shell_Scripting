import com.bridgelaz.MoodAnalayezed;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class MoodAnalyserReflector {

    public static MoodAnalayezed createMoodAnalyser(String message) {

        Class<?> moodAnalyserClass = null;
        try {
            moodAnalyserClass = Class.forName("com.bridgelaz.MoodAnalayezed");
            Constructor<?> moodConstructor = moodAnalyserClass.getConstructor(String.class);
            Object moodObj = moodConstructor.newInstance(message);
            return (MoodAnalayezed) moodObj;
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static Constructor getConstructor(Class<?>... parameter) {
        //Object getObject(Constructor constructor, String... message) {
        try {
            Class<?> moodAnalyserClass = Class.forName("com.bridgelaz.MoodAnalayezed");
            //Constructor<?> moodConstructor = moodAnalyserClass.getConstructor(String.class);
            return moodAnalyserClass.getConstructor(parameter);
            //return Constructor;

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Object getObject(Constructor constructor, String... message) {
        Object moodObj = null;
        try {
            moodObj = constructor.newInstance(message);
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }

        return (MoodAnalayezed) moodObj;

    }

    public Method getMethod(String methodname) {
        Constructor constructor=getConstructor();
        Object object =getObject(constructor);
        try{
            Method method=object.getClass().getDeclaredMethod(methodname,String.class);
            return method;

        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        }
        return null;
    }
}