
class BasicCoffee implements Coffee {

	private double cost = 4.50;
	
	@Override
	public double makeCoffee() {
		// TODO Auto-generated method stub
		System.out.println("Black Coffee: $4.50");
		
		return cost;
	}	
}