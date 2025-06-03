package model;

import java.util.*;
import com.google.gson.Gson;

public class Product {
    private int id;
    private String name;
    private String description;
    private double price;
    private String imageUrl;
    private int categoryId;

    // ✅ No-argument constructor added
    public Product() {
    }

    public Product(int id, String name, String description, double price, String imageUrl, int categoryId) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.imageUrl = imageUrl;
        this.categoryId = categoryId;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public static String toJson(List<Product> products) {
        return new Gson().toJson(products);
    }
}