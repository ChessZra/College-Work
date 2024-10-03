public class SavingsFormulas {

    private static double helperFutureValueLS_VariableInterest(double PV, double values[], int index) {
        if (index == -1) return PV;
        return helperFutureValueLS_VariableInterest(PV, values, index - 1) * (1 + values[index]);
    }

    private static double helperCompoundSavingsVariable(double values[], double interest, int index) {
        if (index == 0) return values[0];
        return (helperCompoundSavingsVariable(values, interest, index - 1) * (1 + interest)) + values[index];
    }

    public static double futureValueLumpSum(double cash, double interest, int years ) {
        double result = cash * Math.pow(1 + interest, years);
        return result;
    }

    public static double futureValueLS_VariableInterest(double cash, double values[]) {
        return helperFutureValueLS_VariableInterest(cash, values, values.length - 1);
    }
    
    public static double compoundSavingsConstant(double cash, double interest, int years) {
        double result = cash * ((Math.pow(1 + interest, years) - 1) / interest);
        return result;
    }

    public static double compoundSavingsVariable(double values[], double interest) {
        return helperCompoundSavingsVariable(values, interest, values.length - 1);
    }

}
