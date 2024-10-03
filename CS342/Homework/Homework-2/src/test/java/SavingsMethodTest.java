import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

class SavingsMethodTest {
	
	static MyMoney myMoney;
	
	static double[] cash;
	static double[] interest;

	@BeforeAll
	static void setup() {
		myMoney = new MyMoney("values.txt", "values2.txt", 8, 8);
		cash = myMoney.getCashValues();
		interest = myMoney.getInterestValues();
	}

	@Test
	void futureValueLumpSum1() {
		double total = Math.round(SavingsFormulas.futureValueLumpSum(1000, 0.5, 5));
		assertEquals(7594, total);
	}

	@Test
	void futureValueLumpSum2() {
		double total = Math.round(SavingsFormulas.futureValueLumpSum(3000, 0.5, 10));
		assertEquals(172995, total);
	}

	@Test
	void futureValueLS_VariableInterest1() {
		double total = Math.round(SavingsFormulas.futureValueLS_VariableInterest(20000, interest));
		assertEquals(32110, total);
	}

	@Test
	void futureValueLS_VariableInterest2() {
		double total = Math.round(SavingsFormulas.futureValueLS_VariableInterest(50000, interest));
		assertEquals(80275, total);
	}

	@Test
	void compoundSavingsConstant1() {
		double total = Math.round(SavingsFormulas.compoundSavingsConstant(20000, .014, 10));
		assertEquals(213082, total);
	}

	@Test
	void compoundSavingsConstant2() {
		double total = Math.round(SavingsFormulas.compoundSavingsConstant(20000, .07, 10));
		assertEquals(276329, total);
	}
	
	@Test
	void compoundSavingsVariable1() {
		double total = Math.round(SavingsFormulas.compoundSavingsVariable(cash, .05));
		assertEquals(115278, total);
	}

	@Test
	void compoundSavingsVariable2() {
		double total = Math.round(SavingsFormulas.compoundSavingsVariable(cash, .07));
		assertEquals(122785, total);
	}
}
