interface Coffee {
    public double makeCoffee();
}

public class MakeCoffee {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Coffee order = new Sugar(new Cream( new ExtraShot(new BasicCoffee())));
		
		Coffee order2 = new ExtraShot(order);
		
		double cost = order2.makeCoffee();
		System.out.println("Total: $"+ String.format("%.2f", cost));	
	}
}
