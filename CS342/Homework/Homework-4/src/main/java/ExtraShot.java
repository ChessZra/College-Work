class ExtraShot extends CoffeeDecorator {
	
	private double cost = 1.20;
	
	ExtraShot(Coffee specialCoffee){
		super(specialCoffee);
	}
	
	public double makeCoffee() {
		return specialCoffee.makeCoffee() + addShot();
	}
	
	private double addShot() {
		System.out.println(" + extra shot: $1.20");
		
		return cost;
	}

    @Override
    public double getCost() {
        return cost;  
    }
}