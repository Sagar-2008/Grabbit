package ui;

import model.Product;
import service.CartService;
import service.ProductService;

import java.util.*;

public class TestCart {
    public static void main(String[] args) {
        CartService cart = new CartService();
        ProductService productService = new ProductService();
        Scanner sc = new Scanner(System.in);

        List<Product> products = productService.getAllProducts();

        System.out.println("🛒 Available Products:");
        for (Product p : products) {
            System.out.println(p.getId() + ". " + p.getName() + " - ₹" + p.getPrice());
        }

        System.out.print("\nEnter product ID to add to cart: ");
        int productId = sc.nextInt();

        System.out.print("Enter quantity: ");
        int quantity = sc.nextInt();

        Product selectedProduct = null;
        for (Product p : products) {
            if (p.getId() == productId) {
                selectedProduct = p;
                break;
            }
        }

        if (selectedProduct != null) {
            cart.addToCart(selectedProduct, quantity);
            System.out.println("✅ Added to cart: " + selectedProduct.getName() + " x" + quantity);
        }
        else {
            System.out.println("❌ Product not found!");
        }

        System.out.println("\n🛒 Cart Items:");
        cart.getCartItems().forEach(item -> {
            System.out.println(item.getProduct().getName() + " x " + item.getQuantity() + " = ₹" + item.getTotalPrice());
        });

        System.out.println("Total Cart Value: ₹" + cart.getCartTotal());
        sc.close();
    }
}