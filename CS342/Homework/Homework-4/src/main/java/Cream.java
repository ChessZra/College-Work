class Cream extends CoffeeDecorator {
	
	private double cost = .50;
	Cream(Coffee specialCoffee){
		super(specialCoffee);
	}
	
	public double makeCoffee() {
		return specialCoffee.makeCoffee() + addCream();
	}
	
	private double addCream() {
		
		System.out.println(" + cream: $.50");
		
		return cost;
	}

    @Override
    public double getCost() {
        return cost;
    }
}