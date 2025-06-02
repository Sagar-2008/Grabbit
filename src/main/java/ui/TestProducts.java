package ui;

import model.Category;
import model.Product;
import service.ProductService;

import java.util.*;

public class TestProducts {
    public static void main(String[] args) {
        ProductService productService = new ProductService();

        List<Product> productList = productService.getProductsByCategoryName("Beverages");
        for (Product p : productList) {
            System.out.println("🛒 " + p.getName() + " - ₹" + p.getPrice());
        }
    }
}
