package ui;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.google.gson.Gson;
import model.Product;
import model.CartItem;
import service.ProductService;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.*;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    private final Gson gson = new Gson();
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<CartItem> cart = getCart(req);
        resp.setContentType("application/json");
        resp.getWriter().write(gson.toJson(cart));
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        BufferedReader reader = req.getReader();
        Product incomingProduct = gson.fromJson(reader, Product.class);

        if (incomingProduct == null || incomingProduct.getId() == 0) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product");
            return;
        }

        List<CartItem> cart = getCart(req);

        // Check if product already in cart
        Optional<CartItem> existingItemOpt = cart.stream()
                .filter(item -> item.getProduct().getId() == incomingProduct.getId())
                .findFirst();

        if (existingItemOpt.isPresent()) {
            CartItem existing = existingItemOpt.get();
            existing.setQuantity(existing.getQuantity() + 1);
        } else {
            // Fetch full product from DB (optional but cleaner)
            Product fullProduct = productService.getProductById(incomingProduct.getId());
            if (fullProduct == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                return;
            }
            CartItem newItem = new CartItem(fullProduct, 1);
            cart.add(newItem);
        }

        req.getSession().setAttribute("cart", cart);
        resp.setStatus(HttpServletResponse.SC_OK);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.getSession().removeAttribute("cart");
        resp.setStatus(HttpServletResponse.SC_OK);
    }

    @SuppressWarnings("unchecked")
    private List<CartItem> getCart(HttpServletRequest req) {
        HttpSession session = req.getSession();
        Object cartObj = session.getAttribute("cart");
        if (cartObj == null) {
            List<CartItem> newCart = new ArrayList<>();
            session.setAttribute("cart", newCart);
            return newCart;
        }
        return (List<CartItem>) cartObj;
    }
}
