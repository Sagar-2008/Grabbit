document.addEventListener("DOMContentLoaded", () => {
    const cartContainer = document.getElementById("cartContainer");
    const totalAmountEl = document.getElementById("totalAmount");
    const checkoutBtn = document.getElementById("checkoutBtn");
    const logoutBtn = document.getElementById("logoutBtn");

    let cart = JSON.parse(sessionStorage.getItem("cart")) || [];

    if (logoutBtn) {
        logoutBtn.addEventListener("click", () => {
            localStorage.removeItem("user");
            window.location.href = "/Grabbit";
        });
    }

    if (cart.length === 0) {
        cartContainer.innerHTML = `
            <div class="placeholder-msg">
                <h3>Your cart is empty.</h3>
                <p>Add items to your cart to see them here.</p>
            </div>
        `;
        checkoutBtn.disabled = true;
        totalAmountEl.textContent = "₹0.00";
        return;
    }

    // Render cart items
    let totalAmount = 0;
    cartContainer.innerHTML = "";

    cart.forEach((item, index) => {
        const { product, quantity } = item;
        const itemTotal = product.price * quantity;
        totalAmount += itemTotal;

        const card = document.createElement("div");
        card.className = "cart-item";
        card.innerHTML = `
            <img src="${product.imageUrl}" alt="${product.name}">
            <div class="cart-item-details">
                <h3>${product.name}</h3>
                <p>₹${product.price} × ${quantity}</p>
                <p class="subtotal">Subtotal: ₹${itemTotal.toFixed(2)}</p>
                <div class="qty-controls">
                    <button class="decrease" data-index="${index}">−</button>
                    <button class="increase" data-index="${index}">+</button>
                    <button class="remove" data-index="${index}">Remove</button>
                </div>
            </div>
        `;
        cartContainer.appendChild(card);
    });

    totalAmountEl.textContent = `₹${totalAmount.toFixed(2)}`;

    // Quantity controls
    cartContainer.addEventListener("click", (e) => {
        const index = parseInt(e.target.dataset.index);
        if (isNaN(index)) return;

        if (e.target.classList.contains("increase")) {
            cart[index].quantity += 1;
        } else if (e.target.classList.contains("decrease")) {
            if (cart[index].quantity > 1) {
                cart[index].quantity -= 1;
            } else {
                cart.splice(index, 1);
            }
        } else if (e.target.classList.contains("remove")) {
            cart.splice(index, 1);
        }

        sessionStorage.setItem("cart", JSON.stringify(cart));
        location.reload(); // quick refresh to re-render
    });

    // Checkout button click (placeholder)
    checkoutBtn.addEventListener("click", () => {
        alert("Checkout feature coming soon!");
    });
});
