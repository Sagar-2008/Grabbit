document.addEventListener("DOMContentLoaded", () => {
    const categoryCards = document.querySelectorAll(".category-card");
    const productSection = document.getElementById("products");

    // Category card click listener → fetch from servlet
    categoryCards.forEach(card => {
        card.addEventListener("click", () => {
            const categoryName = card.dataset.category;

            fetch(`/ProductServlet?category=${encodeURIComponent(categoryName)}`)
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    return response.json();
                })
                .then(products => {
                    // use global renderer from main.js
                    if (typeof window.setProducts === "function") {
                        window.setProducts(products);

                        // Scroll to product section
                        setTimeout(() => {
                            productSection.scrollIntoView({
                                behavior: "smooth",
                                block: "start"
                            });
                        }, 100);
                    } else {
                        console.error("setProducts not defined in main.js");
                    }
                })
                .catch(error => {
                    console.error("Failed to fetch products:", error);
                    alert("Something went wrong while loading products.");
                });
        });
    });
});
