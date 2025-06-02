document.addEventListener("DOMContentLoaded", () => {
    window.scrollTo({ top: 0, left: 0 });

    const categoryCards = document.querySelectorAll(".category-card");
    const productGrid = document.getElementById("product-list");
    const searchBox = document.querySelector(".search-box");
    const scrollTopBtn = document.getElementById("scrollTopBtn");
    const loginBtn = document.getElementById("loginBtn");
    const productSection = document.getElementById("products");
    const welcomeMsg = document.getElementById("welcomeMsg");
    const user = JSON.parse(localStorage.getItem("user"));
    let allProducts = [];

    // Handle login/logout UI
    function updateLoginButton() {
        const user = JSON.parse(localStorage.getItem("user"));

        if (user) {
            loginBtn.textContent = "Logout";
            loginBtn.onclick = () => {
                localStorage.removeItem("user");
                updateLoginButton(); // Update button to say "Login"
            };
        } else {
            loginBtn.textContent = "Login";
            loginBtn.onclick = () => {
                window.location.href = "/Grabbit/login.html";
            };
        }
    }

    updateLoginButton(); // Call once on load

    // Render products
    function renderProducts(products) {
        productGrid.innerHTML = "";

        if (products.length === 0) {
            productGrid.innerHTML = `<p class="placeholder-msg">No products found.</p>`;
            return;
        }

        products.forEach((prod, index) => {
            const card = document.createElement("div");
            card.className = "product-card";
            card.style.animationDelay = `${index * 0.1}s`;
            card.innerHTML = `
                <img src="${prod.imageUrl}" alt="${prod.name}">
                <h3>${prod.name}</h3>
                <p>₹${prod.price}</p>
                <p>${prod.description}</p>
                <button>Add to Cart</button>
            `;
            productGrid.appendChild(card);
        });
    }

    // Search filtering
    searchBox.addEventListener("input", () => {
        const query = searchBox.value.trim().toLowerCase();

        if (query === "") {
            renderProducts(allProducts);
            return;
        }

        const filtered = allProducts.filter(prod =>
            prod.name.toLowerCase().includes(query)
        );

        renderProducts(filtered);
    });

    // Scroll to Top button logic
    window.addEventListener("scroll", () => {
        scrollTopBtn.style.display = document.documentElement.scrollTop > 300 ? "block" : "none";
    });

    scrollTopBtn.addEventListener("click", () => {
        window.scrollTo({ top: 0, behavior: "smooth" });
    });

    // Expose to global scope so fetchProducts.js can call setProducts
    window.setProducts = function (products) {
        allProducts = products;
        renderProducts(products);
    };
});
