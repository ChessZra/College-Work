import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import org.junit.jupiter.api.DisplayName;

import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class CoffeeDecoratorTest {

    @Test
    void testBasicCoffeeCost() {
        Order order = new Order(1, 0, 0, 0, 0, 0);
        assertEquals(4.50, order.getSingleCoffeeCost(), 0.001);
    }

    @Test
    void testCoffeeWithCinnamon() {
        Order order = new Order(1, 1, 0, 0, 0, 0);
        assertEquals(4.80, order.getSingleCoffeeCost(), 0.001);
    }

    @Test
    void testCoffeeWithMultipleExtras() {
        Order order = new Order(1, 2, 1, 1, 1, 1);
        double expectedCost = 4.50 + (0.30 * 2) + 0.50 + 1.20 + 0.75 + 0.50;
        assertEquals(expectedCost, order.getSingleCoffeeCost(), 0.001);
    }

    @Test
    void testTotalOrderCost() {
        Order order = new Order(3, 1, 1, 0, 0, 0);
        double singleCoffeeCost = 4.50 + 0.30 + 0.50;
        assertEquals(singleCoffeeCost * 3, order.getTotalOrderCost(), 0.001);
    }

    @Test
    void testOrderSummary() {
        Order order = new Order(2, 1, 2, 1, 0, 1);
        String summary = order.getOrderSummary();
        
        assertTrue(summary.contains("Coffee Order Details:"));
        assertTrue(summary.contains("Basic Coffee: 2 unit(s)"));
        assertTrue(summary.contains("Cinnamon: 1 unit(s)"));
    }

    @Test
    void testZeroQuantityExtras() {
        Order order = new Order(1, 0, 0, 0, 0, 0);
        assertEquals(4.50, order.getSingleCoffeeCost(), 0.001);
    }

    @Test
    void testLargeNumberOfExtras() {
        Order order = new Order(1, 5, 5, 5, 5, 5);
        double expectedCost = 4.50 + (0.30 * 5) + (0.50 * 5) + (1.20 * 5) + (0.75 * 5) + (0.50 * 5);
        assertEquals(expectedCost, order.getSingleCoffeeCost(), 0.001);
    }

    @Test
    void testCoffeeWithOnlyExtraShots() {
        Order order = new Order(1, 0, 0, 3, 0, 0);
        double expectedCost = 4.50 + (1.20 * 3);
        assertEquals(expectedCost, order.getSingleCoffeeCost(), 0.001);
    }

    @Test
    void testCoffeeObjectCreation() {
        Order order = new Order(1, 1, 1, 0, 0, 0);
        assertNotNull(order.getCoffee());
    }

    @Test
    void testCoffeeImmutability() {
        Order order1 = new Order(1, 1, 0, 0, 0, 0);
        Order order2 = new Order(1, 0, 1, 0, 0, 0);
        
        assertNotEquals(order1.getSingleCoffeeCost(), order2.getSingleCoffeeCost());
    }
}