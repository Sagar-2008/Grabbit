package service;

import model.CartItem;
import model.Product;

import java.util.ArrayList;
import java.util.List;

public class CartService {
    private final List<CartItem> cart = new ArrayList<>();

    public void addToCart(Product product, int quantity) {
        for (CartItem item : cart) {
            if (item.getProduct().getId() == product.getId()) {
                item.setQuantity(item.getQuantity() + quantity);
                return;
            }
        }
        cart.add(new CartItem(product, quantity));
    }

    public void removeFromCart(int productId) {
        cart.removeIf(item -> item.getProduct().getId() == productId);
    }

    public List<CartItem> getCartItems() {
        return cart;
    }

    public double getCartTotal() {
        double total = 0;
        for (CartItem item : cart) {
            total += item.getTotalPrice();
        }
        return total;
    }

    public void clearCart() {
        cart.clear();
    }
}