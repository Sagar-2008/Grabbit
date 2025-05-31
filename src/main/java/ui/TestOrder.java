package ui;

import model.User;
import model.Product;
import model.CartItem;
import service.OrderService;

import java.util.*;

public class TestOrder {
    public static void main(String[] args) {
        User user = new User(1,"sagar","1234","customer");

        Product product1 = new Product(2, "Soya Chunks", "Soya Chunks With 57g Protein",100,"https://via.placeholder.com/124",1);
        Product product2 = new Product(3,"Pasta","Sweet delicious morning breakfast",70,"https://via.placeholder.com/154",1);

        CartItem item1 = new CartItem(product1,3);

        CartItem item2 = new CartItem(product2,2);

        List<CartItem> cartItems = new ArrayList<>();
        cartItems.add(item1);
        cartItems.add(item2);

        OrderService orderService = new OrderService();
        orderService.placeOrder(user, cartItems);

        List<Map<String, Object>> orders = orderService.getOrdersByUser(user.getId());

        for (Map<String, Object> order : orders) {
            System.out.println("Order ID: " + order.get("id"));
            System.out.println("Date: " + order.get("order_date"));
            System.out.println("Total: ₹" + order.get("total_amount"));
            System.out.println("Status: " + order.get("status"));
            System.out.println("Items:");
            List<Map<String, Object>> items = orderService.getOrderItems((int) order.get("id"));
            for (Map<String, Object> item : items) {
                System.out.println("- " + item.get("name") + " x" + item.get("quantity") + " @ ₹" + item.get("price"));
            }
            System.out.println("-------------");
            System.out.println("-------------");
        }
        orderService.updateOrderStatus(1, "Delivered");
        System.out.println("Order status updated.");
    }
}
