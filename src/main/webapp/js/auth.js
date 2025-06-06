document.addEventListener("DOMContentLoaded", () => {
    const loginForm = document.getElementById("loginForm");

    if (loginForm) {
        loginForm.addEventListener("submit", function (e) {
            e.preventDefault();
            loginHandler();
        });
    }

    async function loginHandler() {
        const username = document.getElementById("username").value.trim();
        const password = document.getElementById("password").value;

        try {
            const response = await fetch("/Grabbit/login", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ username, password }),
            });

            const contentType = response.headers.get("content-type");

            if (!contentType || !contentType.includes("application/json")) {
                const errorText = await response.text(); 
                throw new Error("Invalid JSON: " + errorText.substring(0, 100));
            }

            const data = await response.json();

            if (response.ok) {
                localStorage.setItem("user", JSON.stringify(data.user));
                if (data.user.role === "admin") {
                    window.location.href = "/Grabbit/admin.html";
                } else {
                    window.location.href = "/Grabbit";
                }
            } else {
                alert(data.message || "Login failed!");
            }
        } catch (err) {
            alert("Error: " + err.message);
        }
    }
});