document.addEventListener("DOMContentLoaded", () => {
    const categoryCards = document.querySelectorAll(".category-card");
    const productSection = document.getElementById("products");

    categoryCards.forEach(card => {
        card.addEventListener("click", () => {
            const categoryName = card.dataset.category;
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
