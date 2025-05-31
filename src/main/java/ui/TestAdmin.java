package ui;

import model.User;
import service.UserService;
import service.OrderService;
import service.ProductService;

import java.util.*;

public class TestAdmin {
    public static void main(String[] args) {
        OrderService os = new OrderService();
        ProductService ps = new ProductService();
        List<Map<String, Object>> allOrders = os.getAllOrders();

        for (Map<String, Object> order : allOrders) {
            System.out.println("Order ID: " + order.get("id"));
            System.out.println("User: " + order.get("username") + " (ID: " + order.get("user_id") + ")");
            System.out.println("Date: " + order.get("order_date"));
            System.out.println("Total: ₹" + order.get("total_amount"));
            System.out.println("Status: " + order.get("status"));
            System.out.println("-------------");
        }

        boolean added = ps.addProduct("Saffola Masala Oats", "Healthy wholegrain oats", 120.0, "https://via.placeholder.com/100", 1);
        System.out.println(added ? "✅ Product added" : "❌ Failed to add");

        boolean updated = ps.updateProduct(2, "Updated Name", "Updated Description", 150.0, "https://via.placeholder.com/150", 1);
        System.out.println(updated ? "✅ Product updated" : "❌ Failed to update");

        boolean deleted = ps.deleteProduct(2);
        System.out.println(deleted ? "✅ Product deleted" : "❌ Failed to delete");

        Scanner sc = new Scanner(System.in);
        UserService us = new UserService();

        List<User> users = us.getAllUsers();
        for (User user : users) {
            System.out.println("ID: " + user.getId() + ", Username: " + user.getUsername() + ", Role: " + user.getRole());
        }

        System.out.print("Enter user ID to delete: ");
        int idToDelete = sc.nextInt();
        sc.nextLine();

        if (us.deleteUserById(idToDelete)) {
            System.out.println("✅ User deleted.");
        } else {
            System.out.println("❌ Failed to delete user.");
        }
        sc.close();
    }
}
