
import com.bridgelaz.MoodAnalayezed;
//import moodeAnalayzer.java.MoodAnalyserReflector;
import com.bridgelaz.MoodAnalayezedCustom;
import org.junit.Assert;
import org.junit.Test;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import static org.graalvm.compiler.nodes.extended.FixedValueAnchorNode.getObject;

public class MoodAnalyserTest {


    @Test

    public void whenGivenSad_shouldReturnsad() {
        MoodAnalayezed analayezer = new MoodAnalayezed("i am sad");
        String message = analayezer.analayse();
        Assert.assertEquals("Sad", message);
    }

    @Test
    public void whenGivenSadHappy_shouldReturnHappy() {
        MoodAnalayezed analayezer = new MoodAnalayezed("i am Happy");
        String message = analayezer.analayse();
        Assert.assertEquals("Happy", message);
    }

    @Test
    public void whenGivensadMessageWithAlphabetCaptial_shouldReturnSad() {
        MoodAnalayezed analayezer = new MoodAnalayezed("I am sad ri8 now");
        String message = analayezer.analayse();
        Assert.assertEquals("Sad", message);

    }

    @Test
    public void whenGivensadMessageWithEmptyValue_shouldReturnInvalid() {
        MoodAnalayezed analayezer = new MoodAnalayezed("");
        try {
        } catch (Exception e) {
            Assert.assertEquals("please enter valid input", e.getMessage());
        }
    }

    @Test
    public void whenGivensadMessageWithNullValue_shouldReturnInvalid() {
        MoodAnalayezed analayezer = new MoodAnalayezed("null");
        try {
        } catch (Exception e) {
            Assert.assertEquals("please enter valid input", e.getMessage());
        }
    }

    @Test
    public void givenMoodAnalyserClass_whenProper_ShouldReturnObject() {
        MoodAnalayezed moodAnalyser = MoodAnalyserReflector.createMoodAnalyser("i am happy");
        String mood = moodAnalyser.analayse();
        Assert.assertEquals("Happy", mood);
    }

    @Test
    public void givenMoodAnalyserObj_WhenProper_ShouldReturn() {
        Constructor<?> constructor = null;
        try {
            constructor = Class.forName("com.bridgelaz.MoodAnalayezed").getConstructor(String.class);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        }
        try {
            Object myObj = constructor.newInstance("I am Happy know");
            MoodAnalayezed MoodAnalayezer = (MoodAnalayezed) myObj;
            String mood = MoodAnalayezer.analayse();
            Assert.assertEquals("Happy", mood);
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void givenMoodAnalyserClassComapreObject_wheProper_shouldReturn() {
        MoodAnalayezed obj1 = new MoodAnalayezed("i am Happy");
        MoodAnalayezed obj2 = MoodAnalyserReflector.createMoodAnalyser("i am Happy");
        Assert.assertEquals(true, obj1.equals(obj2));

    }

    @Test
    public void givenClassName_whenImproper_ShouldThrowMoodAnalyserException() {
        Constructor<?> constructor = null;
        try {
            constructor = Class.forName("com.bridgelaz.Mood").getConstructor(String.class);
        } catch (ClassNotFoundException e) {
            try {
                throw new MoodAnalayezedCustom(MoodAnalayezedCustom.ExceptionType.NO_SUCH_CLASS_FOUND, "Enter Valid Class");
            } catch (MoodAnalayezedCustom moodAnalayezedCustom) {
                moodAnalayezedCustom.printStackTrace();
            }
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        }
    }


    @Test
    public void GivenClass_WhenConstructorNotProper_shouldThrowMoodAnalysisException() {
        Constructor<?> constructor = null;

        try {
            constructor = Class.forName("com.bridgelaz.MoodAnalayezed").getConstructor(int.class);
        } catch (NoSuchMethodException ex) {
            try {
                throw new MoodAnalayezedCustom(MoodAnalayezedCustom.ExceptionType.NO_SUCH_METHOD_FOUND, "Enter Valid Method");
            } catch (MoodAnalayezedCustom moodAnalayezedCustom) {
                moodAnalayezedCustom.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void givenClas_whenCostructorNotProper_shouldreturnIvalidEmail() {
        Constructor<?> constructor = null;
        try {
            constructor = Class.forName("com.bridgelaz.MoodAnalayezed").getConstructor();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        }

    }

    @Test
    public void whenGivenConstructorWithParameter_shouldReturnobject() {
        Constructor constructor = MoodAnalyserReflector.getConstructor(String.class);
        Object object = MoodAnalyserReflector.getObject(constructor, "i am Happy");
        MoodAnalayezed MoodAnalayezed = (MoodAnalayezed) object;
        Assert.assertEquals(true, MoodAnalayezed.equals(new MoodAnalayezed("i am Happy")));
    }

    @Test
    public void whenGivenConstructurWithNoParameter_shouldreturnNoObject() {
        Constructor constructor = MoodAnalyserReflector.getConstructor();
        Object object = MoodAnalyserReflector.getObject(constructor);
        MoodAnalayezed MoodAnalayezed = (MoodAnalayezed) object;
        Assert.assertEquals(true, MoodAnalayezed.equals(new MoodAnalayezed()));

    }


    @Test
    public void whenGivenInvokedMethod_shouldReturn() {
        Method method = null;
        try {
            Constructor constructor = MoodAnalyserReflector.getConstructor(String.class);
            Object object1 = MoodAnalyserReflector.getObject(constructor, "i am Happy");
            method = MoodAnalayezed.class.getDeclaredMethod("analyes");
            Object object = method.invoke(object1);
            Assert.assertEquals("Happy", object.toString());
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        }

    }

    @Test
    public void whenMethodInvoked_ShouldReturnCorrect() {
        Method method = new MoodAnalyserReflector().getMethod("analyserMood");
        try {
            String mood = (String) method.invoke(new MoodAnalayezed(), "i am Happy");
            Assert.assertEquals("Happy", mood);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void givenField_whenNotProper_shouldreturnException() {
        Class<?> constructor = null;
        try {
            constructor = Class.forName("com.bridgelaz.MoodAnalayezed");
            Field field = constructor.getField("message12");
            Assert.assertEquals(field, "message");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (NoSuchFieldException e) {
            try {
                throw new MoodAnalayezedCustom(MoodAnalayezedCustom.ExceptionType.NO_SUCH_FIELD_FOUND, "No such field found");
            } catch (MoodAnalayezedCustom e1) {
                e1.printStackTrace();
            }
        }
    }

    @Test
    public void whenGivenNullMessage_shouldThrowException() throws InvocationTargetException, IllegalAccessException {
        Class<?> constructor = null;
        try {
            Method method = new MoodAnalyserReflector().getMethod("analyserMood");
            String mood = (String) method.invoke(new MoodAnalayezed(), null);
            Assert.assertEquals("Happy", mood);
        }catch (IllegalArgumentException e){
            try{
                throw new MoodAnalayezedCustom(MoodAnalayezedCustom.ExceptionType.ENTERED_NULL, "please enter valid msg");
            }catch (MoodAnalayezedCustom ex){
                ex.printStackTrace();
            }
        }
    }
}