document.addEventListener("DOMContentLoaded", () => {
    const categoryCards = document.querySelectorAll(".category-card");
    const productSection = document.getElementById("products");

    categoryCards.forEach(card => {
        card.addEventListener("click", () => {
            const categoryName = card.dataset.category;
            if (!categoryName) return;

            // Optional: Add loading animation
            if (typeof window.showLoading === "function") {
                window.showLoading();
            }

            fetch(`/Grabbit/ProductServlet?category=${encodeURIComponent(categoryName)}`)
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    return response.json();
                })
                .then(products => {
                    console.log("Products fetched successfully:", products);

                    if (typeof window.setProducts === "function") {
                        window.setProducts(products);

                        // Smooth scroll to products
                        setTimeout(() => {
                            productSection.scrollIntoView({
                                behavior: "smooth",
                                block: "start"
                            });
                        }, 200);
                    } else {
                        console.error("setProducts not defined in main.js");
                    }
                })
                .catch(error => {
                    console.error("Failed to fetch products:", error);
                    document.getElementById("product-list").innerHTML = `
                        <div class="placeholder-msg" style="color: red;">
                            <h3>Failed to load products</h3>
                            <p>Please try again in a few minutes.</p>
                        </div>
                    `;
                });
        });
    });
});
