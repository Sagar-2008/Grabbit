document.addEventListener("DOMContentLoaded", () => {
    const loginForm = document.getElementById("loginForm");

    if (loginForm) {
        loginForm.addEventListener("submit", function (e) {
            e.preventDefault();
            loginHandler(); // wrap in a new function
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

            const data = await response.json();

            if (response.ok) {
                localStorage.setItem("user", JSON.stringify(data.user));
                window.location.href = "/index.html";
            } else {
                alert(data.message || "Login failed!");
            }
        } catch (err) {
            alert("Error: " + err.message);
        }
    }
});
