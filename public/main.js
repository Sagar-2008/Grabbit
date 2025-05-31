document.addEventListener("DOMContentLoaded", () => {
    window.scrollTo({ top: 0, left: 0 });

    const categoryCards = document.querySelectorAll(".category-card");
    const productGrid = document.getElementById("product-list");
    const searchBox = document.querySelector(".search-box");
    const productSection = document.getElementById("products");
    const scrollTopBtn = document.getElementById("scrollTopBtn");

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
                <h3>${prod.name}</h3>
                <p>₹${prod.price}</p>
                <button>Add to Cart</button>
            `;
            productGrid.appendChild(card);
        });
    }

    // Remove this (category click logic handled in fetchProducts.js):
    /*
    categoryCards.forEach(card => {
        card.addEventListener("click", () => {
            const categoryName = card.dataset.category;
            allProducts = dummyProducts[categoryName] || [];
            renderProducts(allProducts);

            setTimeout(() => {
                productSection.scrollIntoView({ behavior: "smooth", block: "start" });
            }, 150);
        });
    });
    */

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

    // Optionally expose renderProducts to global scope so fetchProducts.js can use it
    window.setProducts = function (products) {
        allProducts = products;
        renderProducts(products);
    };
});
