<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@page import="com.example.ecom.model.Seller" %>
        <%@page import="com.example.ecom.model.Product" %>
            <%@page import="com.example.ecom.model.Customer" %>
                <%@page import="java.util.List" %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <meta charset="UTF-8">
                        <title>Welcome to SwiftKart™</title>
                        <link rel="stylesheet" href="/css/output.css" />
                    </head>
                    <% Customer c=(Customer)session.getAttribute("customer"); int custid=c.getId(); String
                        custname=c.getName(); %>

                        <body class=text-gray-800" style="background-image: linear-gradient(to top, purple, cyan);">
                            <!-- navbar -->
                            <nav class="bg-gray-900 w-full text-gray-100 px-4">
                                <div class="flex flex-wrap justify-between items-center my-2">
                                    <!-- Logo -->
                                    <a href="/" class="flex m-4 items-center space-x-3">
                                        <img src="/images/SwiftMart.png" class="h-14 rounded-xl shadow-lg"
                                            alt="SwiftMart Logo" />
                                        <span class="text-2xl font-semibold text-white">SwiftMart™</span>
                                    </a>

                                    <!-- Navigation Links -->
                                    <div class="flex gap-4 items-center text-sm sm:text-base">
                                        <a href="customerhome"
                                            class="bg-gray-600 shadow px-4 py-2 rounded hover:bg-gray-700 font-medium">Products</a>
                                        <a href="custcart"
                                            class="bg-gray-800 shadow px-4 py-2 rounded hover:bg-gray-700 font-medium">Cart</a>
                                        <a href="custordrhist"
                                            class="bg-gray-800 shadow px-4 py-2 rounded hover:bg-gray-700 font-medium">Orders</a>

                                        <!-- User Dropdown -->
                                        <div class="relative inline-block text-left">
                                            <button id="dropdownButton" onclick="toggleDropdown()"
                                                class="h-12 w-12 flex items-center gap-2 px-4 py-2">
                                                <% String[] nameParts=custname.trim().split(" "); 
                        String initials = "";
                        for (String part : nameParts) {
                            if (!part.isEmpty()) initials += part.charAt(0);
                        }
                        initials = initials.toUpperCase();
                    %>
                    <div class=" flex items-center justify-center text-gray-700 font-semibold text-2xl shadow"
                                                    style="width: 50px; height: 50px; border-radius: 50%; background-color: rgb(32, 220, 220); border: 3px solid white;">
                                                    <%= initials %>
                                        </div>
                                        <span class="hidden sm:inline text-white font-medium">
                                            <%= custname %>
                                        </span>
                                        <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor"
                                            stroke-width="2" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7">
                                            </path>
                                        </svg>
                                        </button>

                                        <!-- Dropdown Menu -->
                                        <div id="dropdownMenu"
                                            class="absolute right-0 mt-2 w-40 origin-top-right bg-white rounded-md shadow-lg ring-1 ring-black ring-opacity-5 hidden z-50">
                                            <div class="py-1 text-gray-700">
                                                <form action="Logout" method="post" class="inline-block">
                                                    <button type="submit"
                                                        class="block px-4 py-2 text-sm hover:bg-gray-100">Logout</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                </div>
                            </nav>

                            <!-- Greeting -->
                            <div class="text-center m-4 text-2xl font-semibold text-gray-800">
                                Welcome to SwiftMart, <%= custname %>
                            </div>

                            <!-- Products Grid -->
                            <div class="px-6 pb-16">
                                <% List<Product> perm_p = (List<Product>) request.getAttribute("prod_y_perm");
                                        if (perm_p.isEmpty()) { %>
                                        <div class="text-center text-gray-600 mt-10 text-lg font-medium">No products
                                            available right now.</div>
                                        <% } else { %>
                                            <section
                                                class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                                                <% for (Product x : perm_p) { int pd=x.getId(); int
                                                    sd=x.getSeller().getId(); String p_name=x.getName(); String
                                                    p_pd=x.getPd(); Double p_price=x.getPrice(); int
                                                    qty=x.getQuantity(); String s_name=x.getSeller().getName(); String
                                                    path=x.getImgp(); %>

                                                    <!-- Product Card -->
                                                    <div
                                                        class="bg-white rounded-xl shadow-md hover:shadow-xl transition-all duration-300 overflow-hidden">
                                                        <img src="<%= path %>" alt="Product <%= pd %>"
                                                            class="w-full h-auto object-cover">
                                                        <div class="p-4 space-y-2">
                                                            <h3 class="text-lg font-semibold text-gray-800">
                                                                <%= p_name %>
                                                            </h3>
                                                            <p class="text-gray-600 text-sm">
                                                                <%= p_pd %>
                                                            </p>
                                                            <p class="text-gray-500 text-sm">Remaining: <%= qty %>
                                                            </p>
                                                            <p class="text-gray-500 text-sm">Seller: <%= s_name %>
                                                            </p>
                                                            <p class="text-xl font-bold text-green-600">₹<%= p_price %>
                                                            </p>

                                                            <div class="w-full flex gap-2 mt-4">
                                                                <form action="Addcart" method="post" class="">
                                                                    <input type="hidden" name="product_id"
                                                                        value="<%= pd %>">
                                                                    <button type="submit"
                                                                        class="w-full bg-blue-600 hover:bg-blue-700 text-white py-2 px-3 rounded-md text-sm font-medium transition duration-300">
                                                                        Add to Cart
                                                                    </button>
                                                                </form>

                                                                <% if (qty> 0) { %>
                                                                    <form action="Buynowsingle" method="post"
                                                                        class="w-1/2">
                                                                        <input type="hidden" name="product_id"
                                                                            value="<%= pd %>">
                                                                        <button type="submit"
                                                                            class="w-full bg-green-600 hover:bg-green-700 text-white py-2 px-3 rounded-md text-sm font-medium transition duration-300">
                                                                            Buy Now
                                                                        </button>
                                                                    </form>
                                                                    <% } %>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <% } %>
                                            </section>
                                            <% } %>
                            </div>
                            <!-- footer -->
                            <footer class="rounded-lg shadow-sm bg-gray-900 m-4">
                                <div class="w-full max-w-screen-xl mx-auto p-4 md:py-8">
                                    <div class="sm:flex sm:items-center sm:justify-between">
                                        <a href="/sellerhome"
                                            class="flex items-center mb-4 sm:mb-0 space-x-3 rtl:space-x-reverse">
                                            <img src="images/SwiftMart.png" class="h-12 rounded-xl"
                                                alt="SwiftMart Logo" />
                                            <span
                                                class="self-center text-2xl font-semibold whitespace-nowrap text-white">SwiftMart™</span>
                                        </a>
                                        <ul
                                            class="flex flex-wrap items-center mb-6 text-sm font-medium text-gray-500 sm:mb-0 dark:text-gray-400">
                                            <li>
                                                <a href="#" class="hover:underline me-4 md:me-6">About</a>
                                            </li>
                                            <li>
                                                <a href="#" class="hover:underline me-4 md:me-6">Privacy Policy</a>
                                            </li>
                                            <li>
                                                <a href="#" class="hover:underline me-4 md:me-6">Licensing</a>
                                            </li>
                                            <li>
                                                <a href="#" class="hover:underline">Contact</a>
                                            </li>
                                        </ul>
                                    </div>
                                    <hr class="my-6 border-gray-200 sm:mx-auto dark:border-gray-700 lg:my-8" />
                                    <span class="block text-sm text-gray-500 sm:text-center dark:text-gray-400">© 2023
                                        <a href="https://flowbite.com/" class="hover:underline">SwiftMart™</a>. All
                                        Rights Reserved.</span>
                                </div>
                            </footer>
                            <script>
                                function toggleDropdown() {
                                    const menu = document.getElementById('dropdownMenu');
                                    menu.classList.toggle('hidden');
                                }

                                // Close dropdown if clicked outside
                                window.addEventListener('click', function (e) {
                                    const dropdownButton = document.getElementById('dropdownButton');
                                    const dropdownMenu = document.getElementById('dropdownMenu');
                                    if (!dropdownButton.contains(e.target)) {
                                        dropdownMenu.classList.add('hidden');
                                    }
                                });

                                setInterval(function () {
                                    location.reload();
                                }, 5000);
                            </script>
                        </body>

                    </html>