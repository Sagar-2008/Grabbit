document.addEventListener("DOMContentLoaded", () => {
    const productForm = document.getElementById("productForm");
    const productId = document.getElementById("productId");
    const productName = document.getElementById("productName");
    const productPrice = document.getElementById("productPrice");
    const productDescription = document.getElementById("productDescription");
    const productImageUrl = document.getElementById("productImageUrl");
    const productCategory = document.getElementById("productCategory");
    const categoryFilter = document.getElementById("categoryFilter");
    const productTableContainer = document.getElementById("productTableContainer");
    const logoutBtn = document.getElementById("logoutBtn");

    let allProducts = [];
    let categories = [];

    logoutBtn.addEventListener("click", () => {
        localStorage.removeItem("user");
        window.location.href = "/Grabbit/login.html";
    });

    // Fetch categories and populate dropdowns
    async function fetchCategories() {
        try {
            const res = await fetch("/Grabbit/categories"); // Assumes you have a CategoryServlet returning JSON
            categories = await res.json();

            categories.forEach(cat => {
                const option1 = document.createElement("option");
                option1.value = cat.id;
                option1.textContent = cat.name;
                productCategory.appendChild(option1);

                const option2 = document.createElement("option");
                option2.value = cat.id;
                option2.textContent = cat.name;
                categoryFilter.appendChild(option2);
            });
        } catch (err) {
            console.error("Failed to fetch categories", err);
        }
    }

    // Load all products
    async function loadProducts() {
        try {
            const res = await fetch("/Grabbit/products");
            allProducts = await res.json();
            renderTable(allProducts);
        } catch (err) {
            console.error("Failed to load products", err);
        }
    }

    // Render product table
    function renderTable(products) {
        if (products.length === 0) {
            productTableContainer.innerHTML = "<p>No products available.</p>";
            return;
        }

        const table = document.createElement("table");
        table.innerHTML = `
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Price (₹)</th>
                    <th>Description</th>
                    <th>Image</th>
                    <th>Category</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                ${products.map(p => {
            const categoryName = categories.find(c => c.id === p.categoryId)?.name || "Unknown";
            return `
                        <tr>
                            <td>${p.name}</td>
                            <td>${p.price}</td>
                            <td>${p.description}</td>
                            <td><img src="${p.imageUrl}" width="60" /></td>
                            <td>${categoryName}</td>
                            <td>
                                <button data-id="${p.id}" class="editBtn">Edit</button>
                                <button data-id="${p.id}" class="deleteBtn">Delete</button>
                            </td>
                        </tr>
                    `;
        }).join("")}
            </tbody>
        `;

        productTableContainer.innerHTML = "";
        productTableContainer.appendChild(table);

        // Add event listeners
        document.querySelectorAll(".editBtn").forEach(btn => {
            btn.addEventListener("click", () => {
                const product = allProducts.find(p => p.id == btn.dataset.id);
                if (product) fillForm(product);
            });
        });

        document.querySelectorAll(".deleteBtn").forEach(btn => {
            btn.addEventListener("click", async () => {
                const id = btn.dataset.id;
                const res = await fetch("/Grabbit/admin/products", {
                    method: "POST",
                    headers: { "Content-Type": "application/x-www-form-urlencoded" },
                    body: new URLSearchParams({ action: "delete", id })
                });
                const msg = await res.text();
                alert(msg);
                loadProducts();
            });
        });
    }

    // Form submission (add/update)
    productForm.addEventListener("submit", async (e) => {
        e.preventDefault();

        const action = productId.value ? "update" : "add";

        const formData = new URLSearchParams({
            action,
            id: productId.value,
            name: productName.value,
            price: productPrice.value,
            description: productDescription.value,
            imageUrl: productImageUrl.value,
            categoryId: productCategory.value
        });

        const res = await fetch("/Grabbit/admin/products", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: formData
        });

        const msg = await res.text();
        alert(msg);
        productForm.reset();
        productId.value = "";
        loadProducts();
    });

    // Fill form for editing
    function fillForm(product) {
        productId.value = product.id;
        productName.value = product.name;
        productPrice.value = product.price;
        productDescription.value = product.description;
        productImageUrl.value = product.imageUrl;
        productCategory.value = product.categoryId;
    }

    // Filter products by selected category
    categoryFilter.addEventListener("change", () => {
        const selected = categoryFilter.value;
        if (selected === "all") {
            renderTable(allProducts);
        } else {
            const filtered = allProducts.filter(p => p.categoryId == selected);
            renderTable(filtered);
        }
    });

    // Init
    fetchCategories().then(loadProducts);
});
