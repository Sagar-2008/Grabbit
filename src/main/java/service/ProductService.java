package service;

import db.DBConnection;
import model.Product;
import model.Category;

import java.sql.*;
import java.util.*;

public class ProductService {
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image_url"),
                        rs.getInt("category_id")
                ));
            }
        } catch (SQLException e) {
            System.out.println("🚫 Error fetching all products: " + e.getMessage());
        }
        return products;
    }

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT * FROM category";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                categories.add(new Category(
                        rs.getInt("id"),
                        rs.getString("name")
                ));
            }
        } catch (SQLException e) {
            System.out.println("🚫 Error fetching categories: " + e.getMessage());
        }
        return categories;
    }

    public int getCategoryIdByName(String name) {
        int id = -1;
        String query = "SELECT id FROM category WHERE name = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                id = rs.getInt("id");
            }
        } catch (SQLException e) {
            System.out.println("🚫 Error fetching category ID by name: " + e.getMessage());
        }
        return id;
    }

    public List<Product> getProductsByCategoryName(String name) {
        int categoryId = getCategoryIdByName(name);
        return getProductsByCategory(categoryId);
    }

    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products WHERE category_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image_url"),
                        rs.getInt("category_id")
                ));
            }
        } catch (SQLException e) {
            System.out.println("🚫 Error fetching products by category: " + e.getMessage());
        }
        return products;
    }

    public List<Product> searchProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products WHERE name LIKE ? OR description LIKE ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            String searchTerm = "%" + keyword + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image_url"),
                        rs.getInt("category_id")
                ));
            }
        } catch (SQLException e) {
            System.out.println("🚫 Error searching products: " + e.getMessage());
        }
        return products;
    }

    public boolean addProduct(String name, String description, double price, String imageUrl, int categoryId) {
        String query = "INSERT INTO products (name, description, price, image_url, category_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setDouble(3, price);
            stmt.setString(4, imageUrl);
            stmt.setInt(5, categoryId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("🚫 Error adding product: " + e.getMessage());
            return false;
        }
    }

    public boolean updateProduct(int id, String name, String description, double price, String imageUrl, int categoryId) {
        String query = "UPDATE products SET name = ?, description = ?, price = ?, image_url = ?, category_id = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setDouble(3, price);
            stmt.setString(4, imageUrl);
            stmt.setInt(5, categoryId);
            stmt.setInt(6, id);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("🚫 Error updating product: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteProduct(int id) {
        String query = "DELETE FROM products WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("🚫 Error deleting product: " + e.getMessage());
            return false;
        }
    }

    public Product getProductById(int id) {
        String query = "SELECT * FROM products WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image_url"),
                        rs.getInt("category_id")
                );
            }
        } catch (SQLException e) {
            System.out.println("🚫 Error fetching product by ID: " + e.getMessage());
        }
        return null;
    }
}
