public class Order {

    // Prices as constants
    private static final double basicCoffeePrice = 4.50;  
    private static final double cinnamonPrice = 0.30;
    private static final double creamPrice = 0.50;
    private static final double extraShotPrice = 1.20;
    private static final double honeyPrice = 0.75;
    private static final double sugarPrice = 0.50;

    // Data members for the order
    private int coffeeAmount;
    private int cinnamonAmount;
    private int creamAmount;
    private int extraShotAmount;
    private int honeyAmount;
    private int sugarAmount;
    private Coffee order;

    // Constructor 
    public Order(int coffeeAmount, int cinnamonAmount, int creamAmount, int extraShotAmount, int honeyAmount, int sugarAmount) {
        this.coffeeAmount = coffeeAmount;
        this.cinnamonAmount = cinnamonAmount;
        this.creamAmount = creamAmount;
        this.extraShotAmount = extraShotAmount;
        this.honeyAmount = honeyAmount;
        this.sugarAmount = sugarAmount;

        make(); 
    }

    public void make() {
        // Create the coffee:
        order = new BasicCoffee();

        for (int i = 0; i < cinnamonAmount; i++) order = new Cinnamon(order);
        for (int i = 0; i < creamAmount; i++) order = new Cream(order);
        for (int i = 0; i < extraShotAmount; i++) order = new ExtraShot(order);
        for (int i = 0; i < honeyAmount; i++) order = new Honey(order);
        for (int i = 0; i < sugarAmount; i++) order = new Sugar(order);
    }

    public double getSingleCoffeeCost() {
        return order.makeCoffee();
    }

    public double getTotalOrderCost() {
        return getSingleCoffeeCost() * this.coffeeAmount;
    }

    public String getOrderSummary() {

        double cinnamonTotal = cinnamonPrice * cinnamonAmount;
        double creamTotal = creamPrice * creamAmount;
        double extraShotTotal = extraShotPrice * extraShotAmount;
        double honeyTotal = honeyPrice * honeyAmount;
        double sugarTotal = sugarPrice * sugarAmount;

        String orderSummary = "Coffee Order Details:\n" +
                "---------------------\n" +
                "Basic Coffee: " + coffeeAmount + " unit(s)\n" +
                "Cinnamon: " + cinnamonAmount + " unit(s) - $" + String.format("%.2f", cinnamonTotal) + "\n" +
                "Cream: " + creamAmount + " unit(s) - $" + String.format("%.2f", creamTotal) + "\n" +
                "Extra Shot: " + extraShotAmount + " unit(s) - $" + String.format("%.2f", extraShotTotal) + "\n" +
                "Honey: " + honeyAmount + " unit(s) - $" + String.format("%.2f", honeyTotal) + "\n" +
                "Sugar: " + sugarAmount + " unit(s) - $" + String.format("%.2f", sugarTotal) + "\n" +
                "---------------------\n" +
                "Total: $" + String.format("%.2f", getSingleCoffeeCost());

        return orderSummary;
    }

    public Coffee getCoffee() {
        return order;
    }
}
