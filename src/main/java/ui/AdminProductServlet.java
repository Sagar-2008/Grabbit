package ui;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;
import service.ProductService;

import java.io.*;
import java.math.BigDecimal;

@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService(); // Assumes default constructor uses DBConnection
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");

        switch (action) {
            case "add" -> handleAddProduct(req, resp);
            case "update" -> handleUpdateProduct(req, resp);
            case "delete" -> handleDeleteProduct(req, resp);
            default -> {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("Invalid action.");
            }
        }
    }

    private void handleAddProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Product product = extractProduct(req, false);
            boolean success = productService.addProduct(product.getName(),product.getDescription(),product.getPrice(),product.getImageUrl(),product.getCategoryId());
            resp.getWriter().write(success ? "Product added" : "Failed to add");
        } catch (Exception e) {
            resp.setStatus(500);
            resp.getWriter().write("Error: " + e.getMessage());
        }
    }

    private void handleUpdateProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Product product = extractProduct(req, true);
            boolean success = productService.updateProduct(product.getId(),product.getName(),product.getDescription(),product.getPrice(),product.getImageUrl(),product.getCategoryId());
            resp.getWriter().write(success ? "Product updated" : "Failed to update");
        } catch (Exception e) {
            resp.setStatus(500);
            resp.getWriter().write("Error: " + e.getMessage());
        }
    }

    private void handleDeleteProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            boolean success = productService.deleteProduct(id);
            resp.getWriter().write(success ? "Product deleted" : "Failed to delete");
        } catch (Exception e) {
            resp.setStatus(500);
            resp.getWriter().write("Error: " + e.getMessage());
        }
    }

    private Product extractProduct(HttpServletRequest req, boolean includeId) {
        Product product = new Product();
        if (includeId) product.setId(Integer.parseInt(req.getParameter("id")));
        product.setName(req.getParameter("name"));
        product.setDescription(req.getParameter("description"));
        product.setPrice(new BigDecimal(req.getParameter("price")));
        product.setImageUrl(req.getParameter("imageUrl"));
        product.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
        return product;
    }
}