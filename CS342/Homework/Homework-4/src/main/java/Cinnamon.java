class Cinnamon extends CoffeeDecorator {
    private double cost = .30;

    Cinnamon(Coffee specialCoffee) {
        super(specialCoffee);
    }

    public double makeCoffee() {
		return specialCoffee.makeCoffee() + addCinnamon();
	}
	
	private double addCinnamon() {
		
		System.out.println(" + cinnamon: $.30");
		
		return cost;
	}

    @Override
    public double getCost() {
        return cost;
    }
}
