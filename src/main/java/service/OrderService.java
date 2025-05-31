package service;

import model.CartItem;
import model.User;
import db.DBConnection;

import java.sql.*;
import java.util.*;

public class OrderService {

    public void placeOrder(User user, List<CartItem> cartItems) {
        double totalAmount = 0;
        for (CartItem item : cartItems) {
            totalAmount += item.getTotalPrice();
        }

        try (Connection conn = DBConnection.getConnection()) {
            String orderSql = "INSERT INTO orders (user_id, total_amount, status) VALUES (?, ?, 'Pending')";
            PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setInt(1, user.getId());
            orderStmt.setDouble(2, totalAmount);
            orderStmt.executeUpdate();

            ResultSet rs = orderStmt.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            String itemSql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            PreparedStatement itemStmt = conn.prepareStatement(itemSql);

            for (CartItem item : cartItems) {
                itemStmt.setInt(1, orderId);
                itemStmt.setInt(2, item.getProduct().getId());
                itemStmt.setInt(3, item.getQuantity());
                itemStmt.setDouble(4, item.getProduct().getPrice());
                itemStmt.addBatch();
            }

            itemStmt.executeBatch();

            System.out.println("✅ Order placed successfully! Order ID: " + orderId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public List<Map<String, Object>> getOrdersByUser(int userId) {
        List<Map<String, Object>> orders = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM orders WHERE user_id = ?")) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> order = new HashMap<>();
                order.put("id", rs.getInt("id"));
                order.put("order_date", rs.getTimestamp("order_date"));
                order.put("total_amount", rs.getDouble("total_amount"));
                order.put("status", rs.getString("status"));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }
    public List<Map<String, Object>> getOrderItems(int orderId) {
        List<Map<String, Object>> items = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT p.name, p.price, oi.quantity FROM order_items oi " +
                             "JOIN products p ON oi.product_id = p.id WHERE oi.order_id = ?")) {

            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> item = new HashMap<>();
                item.put("name", rs.getString("name"));
                item.put("price", rs.getDouble("price"));
                item.put("quantity", rs.getInt("quantity"));
                items.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }
    public void updateOrderStatus(int orderId, String newStatus) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE orders SET status = ? WHERE id = ?")) {

            stmt.setString(1, newStatus);
            stmt.setInt(2, orderId);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Map<String, Object>> getAllOrders() {
        List<Map<String, Object>> orders = new ArrayList<>();
        String query = "SELECT o.*, u.username, " +
                "(SELECT SUM(p.price * oi.quantity) FROM order_items oi JOIN products p ON oi.product_id = p.id WHERE oi.order_id = o.id) AS total_amount " +
                "FROM orders o JOIN users u ON o.user_id = u.id ORDER BY o.order_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> order = new HashMap<>();
                order.put("id", rs.getInt("id"));
                order.put("user_id", rs.getInt("user_id"));
                order.put("username", rs.getString("username"));
                order.put("order_date", rs.getTimestamp("order_date"));
                order.put("status", rs.getString("status"));
                order.put("total_amount", rs.getDouble("total_amount"));
                orders.add(order);
            }

        } catch (SQLException e) {
            System.out.println("Error fetching orders: " + e.getMessage());
        }

        return orders;
    }
}
