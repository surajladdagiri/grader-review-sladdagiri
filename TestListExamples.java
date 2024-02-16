import static org.junit.Assert.*;
import org.junit.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class IsMoon implements StringChecker {
  public boolean checkString(String s) {
    return s.equalsIgnoreCase("moon");
  }
}

public class TestListExamples {
  @Test(timeout = 500)
  public void testMergeRightEnd() {
    List<String> left = Arrays.asList("a", "b", "c");
    List<String> right = Arrays.asList("a", "d");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "a", "b", "c", "d");
    assertEquals(expected, merged);
  }

  @Test
  public void testFilter(){
    List<String> input = new ArrayList<>();
    input.add("moon");
    input.add("Moon");
    input.add("FHUIHFUIE");
    input.add("hfuirjhkwe");
    input.add("mOOn");
    List<String> result = new ArrayList<>();
    StringChecker sc = new IsMoon();
    for(String s: input) {
      if(sc.checkString(s)) {
        result.add(s);
      }
    }
    assertEquals(result, ListExamples.filter(input, sc));
  }
}
