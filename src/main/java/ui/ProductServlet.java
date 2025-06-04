package ui;

import com.google.gson.Gson;
import model.Product;
import service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String category = request.getParameter("category");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        List<Product> products;
        if (category != null && !category.isEmpty()) {
            products = productService.getProductsByCategoryName(category);
        } else {
            products = productService.getAllProducts();
        }

        Gson gson = new Gson();
        String json = gson.toJson(products);

        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
}
