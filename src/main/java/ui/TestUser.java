package ui;

import model.User;
import service.UserService;

import java.util.*;

public class TestUser {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        UserService us = new UserService();

        System.out.println("1. Register\n2. Login");
        int choice = sc.nextInt();
        sc.nextLine(); // consume newline

        System.out.print("Username: ");
        String username = sc.nextLine();
        System.out.print("Password: ");
        String password = sc.nextLine();

        if (choice == 1) {
            if (us.registerUser(username, password)) {
                System.out.println("✅ Registered successfully!");
            } else {
                System.out.println("❌ Registration failed.");
            }
        }
        else {
            User user = us.loginUser(username, password);
            if (user != null) {
                System.out.println("✅ Login successful. Welcome, " + user.getUsername() + "!");
            } else {
                System.out.println("❌ Invalid credentials.");
            }
        }
        sc.close();
    }
}
