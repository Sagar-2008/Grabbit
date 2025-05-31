document.addEventListener("DOMContentLoaded", () => {
    // Ensure page starts at top
    window.scrollTo({ top: 0, left: 0 });

    const categoryCards = document.querySelectorAll(".category-card");
    const productGrid = document.getElementById("product-list");
    const searchBox = document.querySelector(".search-box");
    const productSection = document.getElementById("products");
    const scrollTopBtn = document.getElementById("scrollTopBtn");

    let allProducts = [];

    const dummyProducts = {
        "Snacks": [
            { name: "Chips", price: 40 },
            { name: "Cookies", price: 60 }
        ],
        "Beverages": [
            { name: "Cola", price: 30 },
            { name: "Juice", price: 50 }
        ],
        "Personal Care": [
            { name: "Shampoo", price: 120 },
            { name: "Toothpaste", price: 45 }
        ],
        "Home Essentials": [
            { name: "Floor Cleaner", price: 150 },
            { name: "Air Freshener", price: 90 }
        ]
    };

    // Render products with fade animation delay
    function renderProducts(products) {
        productGrid.innerHTML = "";

        if (products.length === 0) {
            productGrid.innerHTML = `<p class="placeholder-msg">No products found.</p>`;
            return;
        }

        products.forEach((prod, index) => {
            const card = document.createElement("div");
            card.className = "product-card";
            // stagger fade-in by index * 0.1s
            card.style.animationDelay = `${index * 0.1}s`;
            card.innerHTML = `
                <h3>${prod.name}</h3>
                <p>₹${prod.price}</p>
                <button>Add to Cart</button>
            `;
            productGrid.appendChild(card);
        });
    }

    // Category click event
    categoryCards.forEach(card => {
        card.addEventListener("click", () => {
            const categoryName = card.dataset.category;
            allProducts = dummyProducts[categoryName] || [];
            renderProducts(allProducts);

            // Scroll to product section after rendering
            setTimeout(() => {
                productSection.scrollIntoView({ behavior: "smooth", block: "start" });
            }, 150);
        });
    });

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
        if (document.documentElement.scrollTop > 300) {
            scrollTopBtn.style.display = "block";
        } else {
            scrollTopBtn.style.display = "none";
        }
    });

    scrollTopBtn.addEventListener("click", () => {
        window.scrollTo({ top: 0, behavior: "smooth" });
    });
});
