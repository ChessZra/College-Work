
public class SavingsFormulas {
	
	public static double futureValueLumpSum(double cash, double interest, int years) {
		double total = Math.pow(1 + interest, years) * cash; // added a "1 + "
		return total;
	}
	
	public static double futureValueLS_VariableInterest(double cash, double values[]) {
		
		return recFV_VariableHelper(0,values,cash);
	}
	
	private static double recFV_VariableHelper(int years, double values[], double cash) {
		
		if (years == values.length){ // Removed -1
			
			return cash;
		}
		else {
			cash = (1 + values[years]) * cash;
			
			return recFV_VariableHelper(years+=1, values, cash);
		}
	}
	
	public static double compoundSavingsConstant(double cash, double interest, int years) {
		double total = (((Math.pow(1+interest, years)) - 1)/interest) * cash;
		return total;
	}
	
	public static double compoundSavingsVariable(double values[], double interest) {
	
		return recSavingsHelper(0,0,values,interest);
	}
	
	private static double recSavingsHelper(int years, double total, double values[], double interest) {
		
		if (years == values.length){
			// This block of code is not necessary
			double originalTotal = 0;
			
			for(double x:values) {
				originalTotal += x;
			}
			// Block of code ends here
			
			return total;
		}
		else {
			total = ((1 + interest) * total) + values[years]; // Added a "1 + "
			
			return recSavingsHelper(years+=1, total, values, interest);
		}
	}

}
