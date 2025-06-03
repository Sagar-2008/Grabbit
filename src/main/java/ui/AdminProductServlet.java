package ui;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;
import service.ProductService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {

    private final ProductService productService = new ProductService();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Product> products = productService.getAllProducts();  // Or filtered by admin
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        Gson gson = new Gson();  // Assuming you imported com.google.gson.*
        out.print(gson.toJson(products));
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.getWriter().write("Missing action parameter");
            return;
        }

        switch (action) {
            case "add" -> handleAdd(request, response);
            case "update" -> handleUpdate(request, response);
            case "delete" -> handleDelete(request, response);
            default -> response.getWriter().write("Invalid action: " + action);
        }
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        double price = parseDouble(request.getParameter("price"));
        int categoryId = parseInt(request.getParameter("categoryId"));

        boolean success = productService.addProduct(name, description, price, imageUrl, categoryId);
        response.getWriter().write(success ? "Product added successfully" : "Failed to add product");
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        double price = parseDouble(request.getParameter("price"));
        int categoryId = parseInt(request.getParameter("categoryId"));

        if (id <= 0) {
            response.getWriter().write("Invalid product ID");
            return;
        }

        boolean success = productService.updateProduct(id, name, description, price, imageUrl, categoryId);
        response.getWriter().write(success ? "Product updated successfully" : "Failed to update product");
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = parseInt(request.getParameter("id"));

        if (id <= 0) {
            response.getWriter().write("Invalid product ID");
            return;
        }

        boolean success = productService.deleteProduct(id);
        response.getWriter().write(success ? "Product deleted successfully" : "Failed to delete product");
    }

    private int parseInt(String value) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return -1;
        }
    }

    private double parseDouble(String value) {
        try {
            return Double.parseDouble(value);
        } catch (Exception e) {
            return 0.0;
        }
    }
}
