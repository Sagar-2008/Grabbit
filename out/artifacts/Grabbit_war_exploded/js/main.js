document.addEventListener("DOMContentLoaded", () => {
    window.scrollTo({ top: 0, left: 0 });

    const categoryCards = document.querySelectorAll(".category-card");
    const productGrid = document.getElementById("product-list");
    const searchBox = document.querySelector(".search-box");
    const productSection = document.getElementById("products");
    const scrollTopBtn = document.getElementById("scrollTopBtn");
    const loginBtn = document.getElementById("loginBtn");

    let allProducts = [];

    // Only rendering remains here (fetching is in fetchProducts.js)
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

    // Keep this for search filtering
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

    // Login button logic
    if (loginBtn) {
        loginBtn.addEventListener("click", () => {
            window.location.href = "login.html";
        });
    }

    // Optionally expose renderProducts to global scope so fetchProducts.js can use it
    window.setProducts = function (products) {
        allProducts = products;
        renderProducts(products);
    };
});
