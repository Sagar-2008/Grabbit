package ui;

import service.CategoryService;
import java.util.*;

public class TestCategory {
    public static void main(String[] args) {
        CategoryService cs = new CategoryService();

        System.out.println(cs.addCategory("Beverages") ? "✅ Added" : "❌ Failed");
        System.out.println(cs.updateCategory(1, "Updated Category") ? "✅ Updated" : "❌ Failed");

        List<Map<String, Object>> all = cs.getAllCategories();
        for (Map<String, Object> c : all) {
            System.out.println(c.get("id") + ": " + c.get("name"));
        }

        System.out.println(cs.deleteCategory(1) ? "✅ Deleted" : "❌ Failed");
    }
}
