document.addEventListener("DOMContentLoaded", () => {
    // Smooth scroll to top on page load
    window.scrollTo({ top: 0, left: 0, behavior: 'smooth' });

    const categoryCards = document.querySelectorAll(".category-card");
    const productGrid = document.getElementById("product-list");
    const searchBox = document.querySelector(".search-box");
    const loginBtn = document.getElementById("loginBtn");
    const cartBtn = document.getElementById("cartBtn");
    const productSection = document.getElementById("products");
    const user = JSON.parse(localStorage.getItem("user"));
    let allProducts = [];
    let isScrolling = false;

    // Smooth scroll utility function
    function smoothScrollTo(element, offset = 100) {
        if (isScrolling) return;
        isScrolling = true;

        const targetPosition = element.offsetTop - offset;
        const startPosition = window.pageYOffset;
        const distance = targetPosition - startPosition;
        const duration = 800;
        let startTime = null;

        function animation(currentTime) {
            if (startTime === null) startTime = currentTime;
            const timeElapsed = currentTime - startTime;
            const run = easeInOutCubic(timeElapsed, startPosition, distance, duration);
            window.scrollTo(0, run);

            if (timeElapsed < duration) {
                requestAnimationFrame(animation);
            } else {
                isScrolling = false;
            }
        }

        function easeInOutCubic(t, b, c, d) {
            t /= d / 2;
            if (t < 1) return c / 2 * t * t * t + b;
            t -= 2;
            return c / 2 * (t * t * t + 2) + b;
        }

        requestAnimationFrame(animation);
    }

    // Enhanced category card interactions
    categoryCards.forEach((card, index) => {
        // Add staggered animation on load
        card.style.animationDelay = `${index * 0.1}s`;

        card.addEventListener("click", () => {
            // Remove active class from all cards
            categoryCards.forEach(c => c.classList.remove('active'));

            // Add active class to clicked card
            card.classList.add('active');

            // Add click animation
            card.style.transform = 'scale(0.95)';
            setTimeout(() => {
                card.style.transform = '';
            }, 150);

            // Smooth scroll to products section with larger offset
            setTimeout(() => {
                smoothScrollTo(productSection, -45);
            }, 200);
        });

        // Enhanced hover effects
        card.addEventListener('mouseenter', () => {
            if (!card.classList.contains('active')) {
                card.style.transform = 'translateY(-12px) scale(1.03)';
            }
        });

        card.addEventListener('mouseleave', () => {
            if (!card.classList.contains('active')) {
                card.style.transform = '';
            }
        });
    });

    // Handle login/logout UI with smooth transitions
    function updateLoginButton() {
        const user = JSON.parse(localStorage.getItem("user"));

        // Add transition effect
        loginBtn.style.transition = 'all 0.3s ease';
        loginBtn.style.transform = 'scale(0.9)';

        setTimeout(() => {
            if (user) {
                loginBtn.textContent = "Logout";
                loginBtn.className = "logout-btn";
                loginBtn.onclick = () => {
                    // Add logout animation
                    loginBtn.style.transform = 'scale(0.8)';
                    setTimeout(() => {
                        localStorage.removeItem("user");
                        updateLoginButton();
                    }, 150);
                };
            } else {
                loginBtn.textContent = "Login";
                loginBtn.className = "login-btn";
                loginBtn.onclick = () => {
                    // Add click animation before redirect
                    loginBtn.style.transform = 'scale(0.8)';
                    setTimeout(() => {
                        window.location.href = "/Grabbit/login.html";
                    }, 150);
                };
            }

            // Restore scale
            setTimeout(() => {
                loginBtn.style.transform = 'scale(1)';
            }, 100);
        }, 100);
    }

    function cartRedirection() {
        cartBtn.onclick = () => {
            if (user) {
                setTimeout(() => {
                    window.location.href = "/Grabbit/cart.html";
                }, 150);
            } else {
                cartBtn.style.transform = 'scale(0.8)';
                window.alert("Please login to view your cart.");
            }
        }
    }
    cartRedirection();
    updateLoginButton();

    // Enhanced product rendering with staggered animations
    function renderProducts(products) {
        // Fade out existing products
        productGrid.style.opacity = '0.5';
        productGrid.style.transform = 'translateY(20px)';

        setTimeout(() => {
            productGrid.innerHTML = "";

            if (products.length === 0) {
                productGrid.innerHTML = `
                    <div class="placeholder-msg" style="animation: fadeInUp 0.6s ease-out;">
                    <h3>No products found</h3>
                    <p>Try searching for something else or select a different category</p>
                    </div>
                `;

                // Fade in
                productGrid.style.opacity = '1';
                productGrid.style.transform = 'translateY(0)';
                return;
            }

            products.forEach((prod, index) => {
                const card = document.createElement("div");
                card.className = "product-card";
                card.style.opacity = '0';
                card.style.transform = 'translateY(30px)';
                card.innerHTML = `
                    <img src="${prod.imageUrl}" alt="${prod.name}" loading="lazy">
                    <h3>${prod.name}</h3>
                    <p class="price">₹${prod.price}</p>
                    <p class="description">${prod.description}</p>
                    <button class="add-to-cart-btn" onclick="addToCart(${JSON.stringify(prod).replace(/"/g, '&quot;')})">
                        <span>Add to Cart</span>
                        <span class="cart-icon">🛒</span>
                    </button>
                `;

                productGrid.appendChild(card);

                // Staggered animation
                setTimeout(() => {
                    card.style.transition = 'all 0.6s cubic-bezier(0.25, 0.8, 0.25, 1)';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);

                // Add hover effects to product cards
                card.addEventListener('mouseenter', () => {
                    card.style.transform = 'translateY(-8px) scale(1.02)';
                });

                card.addEventListener('mouseleave', () => {
                    card.style.transform = 'translateY(0) scale(1)';
                });
            });

            // Fade in the grid
            productGrid.style.opacity = '1';
            productGrid.style.transform = 'translateY(0)';
        }, 200);
    }

    // Enhanced search with debouncing and smooth transitions
    let searchTimeout;
    searchBox.addEventListener("input", (e) => {
        const query = e.target.value.trim().toLowerCase();

        // Add search animation
        searchBox.style.transform = 'scale(1.02)';
        setTimeout(() => {
            searchBox.style.transform = 'scale(1)';
        }, 100);

        // Clear previous timeout
        clearTimeout(searchTimeout);

        // Debounce search
        searchTimeout = setTimeout(() => {
            if (query === "") {
                renderProducts(allProducts);
                return;
            }

            const filtered = allProducts.filter(prod =>
                prod.name.toLowerCase().includes(query) ||
                prod.description.toLowerCase().includes(query)
            );

            renderProducts(filtered);
        }, 300);
    });

    // Add to cart function with animations
    window.addToCart = function (product) {
        // Animate
        const button = event.target.closest('.add-to-cart-btn');
        button.style.transform = 'scale(0.9)';
        button.style.background = 'var(--success)';
        button.innerHTML = '<span>Added!</span><span>✓</span>';

        setTimeout(() => {
            button.style.transform = 'scale(1)';
            setTimeout(() => {
                button.style.background = '';
                button.innerHTML = '<span>Add to Cart</span><span class="cart-icon">🛒</span>';
            }, 1000);
        }, 150);

        // ✅ Store product in session cart
        let cart = JSON.parse(sessionStorage.getItem("cart")) || [];

        // Check if already exists, if so increment quantity
        const existing = cart.find(item => item.product.id === product.id);
        if (existing) {
            existing.quantity += 1;
        } else {
            cart.push({ product, quantity: 1 });
        }

        sessionStorage.setItem("cart", JSON.stringify(cart));

        console.log('Cart updated:', cart);
    };    

    // Intersection Observer for scroll animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    // Observe sections for scroll animations
    document.querySelectorAll('.categories, .products-section').forEach(section => {
        section.style.opacity = '0';
        section.style.transform = 'translateY(30px)';
        section.style.transition = 'all 0.8s ease-out';
        observer.observe(section);
    });

    // Enhanced navbar scroll effect
    let lastScrollY = window.scrollY;
    window.addEventListener('scroll', () => {
        const navbar = document.querySelector('.navbar');
        const currentScrollY = window.scrollY;

        if (currentScrollY > lastScrollY && currentScrollY > 100) {
            // Scrolling down
            navbar.style.transform = 'translateY(-100%)';
        } else {
            // Scrolling up
            navbar.style.transform = 'translateY(0)';
        }

        lastScrollY = currentScrollY;
    });

    // Expose to global scope so fetchProducts.js can call setProducts
    window.setProducts = function (products) {
        allProducts = products;
        renderProducts(products);
    };

    // Add loading animation helper
    window.showLoading = function () {
        productGrid.innerHTML = `
            <div class="loading-container">
                <div class="loading-spinner"></div>
                <p>Loading delicious products...</p>
            </div>
        `;
    };

    // Smooth page transitions
    document.querySelectorAll('a[href^="/"]').forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            document.body.style.opacity = '0.8';
            document.body.style.transform = 'scale(0.98)';

            setTimeout(() => {
                window.location.href = link.href;
            }, 300);
        });
    });
});