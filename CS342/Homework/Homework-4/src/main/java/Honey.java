class Honey extends CoffeeDecorator {
    private double cost = .75;

    Honey(Coffee specialCoffee) {
        super(specialCoffee);
    }

    public double makeCoffee() {
		return specialCoffee.makeCoffee() + addHoney();
	}
	
	private double addHoney() {
		
		System.out.println(" + honey: $.75");

		return cost;
	}

    @Override
    public double getCost() {
        return cost; 
	}
}
