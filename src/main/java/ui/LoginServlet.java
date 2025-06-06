package ui;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

import com.google.gson.*;
import model.User;
import service.UserService;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() {
        userService = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        Gson gson = new Gson();

        try (BufferedReader reader = request.getReader()) {
            JsonObject json = gson.fromJson(reader, JsonObject.class);

            String username = json.get("username").getAsString();
            String password = json.get("password").getAsString();

            User user = userService.loginUser(username, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                JsonObject resJson = new JsonObject();
                JsonObject userJson = new JsonObject();
                userJson.addProperty("username", user.getUsername());
                userJson.addProperty("role", user.getRole());
                resJson.add("user", userJson);

                response.setStatus(HttpServletResponse.SC_OK);
                out.print(gson.toJson(resJson));
            } else {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                JsonObject errorJson = new JsonObject();
                errorJson.addProperty("message", "Invalid username or password");
                out.print(gson.toJson(errorJson));
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            JsonObject errorJson = new JsonObject();
            errorJson.addProperty("message", "Invalid request format");
            out.print(gson.toJson(errorJson));
        } finally {
            out.flush();
            out.close();
        }
    }
}
