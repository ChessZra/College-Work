import static org.junit.jupiter.api.Assertions.*;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

/*
	MyMoney **(1 error in the constructor)**:
		2 unit tests per public method
		**test both constructors (several cases)**
		**parameterized test to check if cashValues contains all values loaded by in the readvalues()**
		**use assertion assertArrayEquals() to check if interestValues array contains the all of the values loaded in by the readInValues()**
		**Test whether it's initialized or not**
 */

class MyMoneyTest {
	
	static MyMoney hasCash;
	static MyMoney hasInterest;
	static MyMoney hasBoth;
 
	static double[] expectedCashValues = {4000, 5500, 15000, 18000, 24000, 9000, 11000, 12000};
	static double[] expectedInterestValues = {.055, .075, .045, .09, .10, .065, .035, .025};

	@BeforeAll
	static void setup() {
		hasCash = new MyMoney("values.txt", 8, 1);
		hasInterest = new MyMoney("values2.txt", 8, 2);
		hasBoth = new MyMoney("values.txt", "values2.txt", 8, 8);
	}

	@Test
	void testHasCash() {
		double[] cashValues = hasCash.getCashValues();

		// cashValues array's size should be equal to size 8
		assertEquals(8, cashValues.length);
		
		// cashValues array should be equal to expectedCashValues
		assertArrayEquals(expectedCashValues, cashValues);

		// interestValues array should be undefined/uninitialized
		assertEquals(null, hasCash.getInterestValues());
	}

	@Test
	void testHasInterest() {
		double[] interestValues = hasInterest.getInterestValues();

		// interestValues array's size should be equal to size 8
		assertEquals(8, interestValues.length);
		
		// interestValues array should be equal to expectedInterestValues
		assertArrayEquals(expectedInterestValues, interestValues);

		// cashValues array should be undefined/uninitialized
		assertEquals(null, hasInterest.getCashValues());
	}

	@Test
	void testHasBoth() {
		double[] cashValues = hasBoth.getCashValues();
		double[] interestValues = hasBoth.getInterestValues();

		// Both arrays should be of length 8
		assertEquals(8, interestValues.length);
		assertEquals(8, cashValues.length);

		// Check that both arrays should be initialized and include the right elements
		assertArrayEquals(expectedInterestValues, interestValues);
		assertArrayEquals(expectedCashValues, cashValues);
	}

	@ParameterizedTest
	@ValueSource(strings = {"values.txt", "values2.txt"})
	void testReadInFile(String filename) {
		try {
			File f = new File("src/main/resources/"+filename);
			Scanner s = new Scanner(f);
			int i = 0;
			while(s.hasNextDouble()) {
				// Let's ensure that the numbers that we read in from "values.txt" and "values2.txt"
				// are in the data members of MyMoney class.
				if (filename.equals("values.txt")) {
					assertEquals(s.nextDouble(), hasBoth.getCashValues()[i]);
				} else if (filename.equals("values2.txt")) {
					assertEquals(s.nextDouble(), hasBoth.getInterestValues()[i]);
				}
				i++;
			}
			s.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}

	@Test
	void lumpSum_ConstantRate1() {
		// Test on constructor "hasBoth"
		double total = Math.round(hasBoth.lumpSum_ConstantRate(1000, 0.5, 5));
		assertEquals(7594, total);
	}

	@Test
	void lumpSum_ConstantRate2() {
		// Test on constructor "hasCash"
		double total = Math.round(hasCash.lumpSum_ConstantRate(2000, 0.7, 10));
		assertEquals(403199, total);
	}

	@Test
	void lumpSum_VariableRate1() {
		// Test on constructor "hasBoth"
		double total = Math.round(hasBoth.lumpSum_VariableRate(20000));
		assertEquals(32110, total);
	}

	@Test
	void lumpSum_VariableRate2() {
		// Test on constructor "hasInterest"
		double total = Math.round(hasInterest.lumpSum_VariableRate(50000));
		assertEquals(80275, total);
	}

	@Test
	void compoundSavings_sameContribution1() {
		// Test on constructor "hasBoth"
		double total = Math.round(hasBoth.compoundSavings_sameContribution(20000, .014, 10));
		assertEquals(213082, total);
	}

	@Test
	void compoundSavings_sameContribution2() {
		// 2nd Test on constructor "hasBoth"
		double total = Math.round(hasBoth.compoundSavings_sameContribution(100, .2, 30));
		assertEquals(118188, total);
	}

	@Test
	void compoundSavings_variableContribution1() {
		// Test on constructor "hasBoth"
		double total = Math.round(hasBoth.compoundSavings_variableContribution(.05));
		assertEquals(115278, total);
	}

	@Test
	void compoundSavings_variableContribution2() {
		// Test on constructor "hasInterest"
		double total = Math.round(hasBoth.compoundSavings_variableContribution(.084));
		assertEquals(128333, total);
	}
}
