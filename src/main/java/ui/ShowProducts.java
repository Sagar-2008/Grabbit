package ui;

import model.Category;
import model.Product;
import service.ProductService;

import java.util.*;

public class ShowProducts {
    public static void main(String[] args) {
        ProductService ps = new ProductService();
        List<Product> productList = ps.getAllProducts();

        for (Product p : productList) {
            System.out.println("🛒 " + p.getName() + " - ₹" + p.getPrice());
        }

        System.out.println("🔹 All Categories:");
        List<Category> categories = ps.getAllCategories();
        for (Category category : categories) {
            System.out.println(category.getId() + ". " + category.getName());
        }

        System.out.println("\n🔹 Products in Category ID 1:");
        List<Product> categoryProducts = ps.getProductsByCategory(1);
        for (Product product : categoryProducts) {
            System.out.println(product.getName() + " - ₹" + product.getPrice());
        }

        System.out.println("\n🔹 Search for 'soya':");
        List<Product> searchResults = ps.searchProducts("amul");
        for (Product product : searchResults) {
            System.out.println(product.getName() + " - ₹" + product.getPrice());
        }
    }
}
