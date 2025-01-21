//
//  AppData.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 9/1/25.
//

import SwiftUI

struct DataConstants {
    static let appName = "Tạp Hoá Eco"
    
    //MARK: Onboarding
    struct Onboarding {
        static let title = "Welcome to\nTap Hoa Eco"
        static let subtitle = "Receive goods within one hour"
        static let startButton = "Get Started"
        static let loading = "Please wait..."
    }
    
    //MARK: Sign up
    struct SignUp {
        static let title = "Sign Up"
        static let subtitle = "To receive more benefits, register your account by filling in the information"
        static let usernameTitle = "Username"
        static let usernamePlaceholder = "Enter username"
        static let emailTitle = "Email"
        static let emailPlaceholder = "Enter email"
        static let passwordTitle = "Password"
        static let passwordPlaceholder = "Enter password"
        static let signUpButton = "Sign Up"
        static let haveAccount = "Already have an account?"
        static let loginButton = "Login"
    }
    
    //MARK: Login
    struct Login {
        static let title = "Login"
        static let subtitle = "Enter your email & password to access or create a new account"
        static let emailTitle = "Email"
        static let emailPlaceholder = "Enter email"
        static let passwordTitle = "Password"
        static let passwordPlaceholder = "Enter password"
        static let forgotPassword = "Forgot Password"
        static let loginButton = "Login"
        static let noAccount = "Don't have an account?"
        static let signUpButton = "Sign Up"
    }
    
    //MARK: Forgot Password
    struct ForgotPassword {
        static let title = "Forgot Password"
        static let emailTitle = "Email"
        static let emailPlaceholder = "Enter email"
        static let submitButton = "Submit"
        static let okButton = "Ok"
    }
    
    //MARK: Set Password
    struct SetPassword {
        static let title = "New Password"
        static let newPasswordTitle = "New Password"
        static let newPasswordPlaceholder = "Enter new password"
        static let confirmPasswordTitle = "Confirm New Password"
        static let confirmPasswordPlaceholder = "Confirm new password"
        static let changePasswordButton = "Change Password"
        static let okButton = "Ok"
    }
    
    //MARK: OTP
    struct OTP {
        static let title = "Enter Code"
        static let codeTitle = "Code"
        static let codePlaceholder = "- - - -"
        static let resendButton = "Resend Code"
        static let okButton = "Ok"
    }
    
    //MARK: Main Tab
    struct MainTab {
        static let home = "Home"
        static let explore = "Explore"
        static let cart = "Cart"
        static let favourite = "Favourite"
        static let account = "Account"
    }
    
    struct Home {
        static let location = "Your Location"
        static let categories = "Product Categories"
        static let specialOffers = "Special Offers"
        static let bestSellers = "Best Sellers"
        static let loading = "Loading"
        static let ok = "OK"
    }
    
    //MARK: Product Detail
    struct ProductDetail {
        static let price = "Price"
        static let productDetails = "Product Details"
        static let nutrition = "Nutrition"
        static let review = "Review"
        static let addToCart = "Add to Cart"
        static let ok = "OK"
    }
    
    //MARK: Explore
    struct Explore {
        static let title = "Search"
    }
    
    //MARK: Favourite
    struct Favourite {
        static let title = "Favourite"
        static let addAllToCart = "Add All to Cart"
        static let ok = "OK"
    }
    
    //MARK: Cart
    struct Cart {
        static let title = "Cart"
        static let emptyCart = "Cart is empty"
        static let checkout = "Checkout"
        static let ok = "OK"
    }
    
    //MARK: Checkout
    struct Checkout {
        static let title = "Checkout"
        static let placeOrder = "Place Order"
        static let subTotal = "Subtotal"
        static let deliveryFee = "Delivery Fee"
        static let discount = "Discount"
        static let total = "Total"
        static let deliveryType = "Delivery Type"
        static let delivery = "Delivery"
        static let pickup = "Pickup"
        static let deliveryTitle = "Delivery"
        static let choose = "Choose"
        static let paymentType = "Payment Type"
        static let paymentTitle = "Payment"
        static let promoCode = "Promo Code"
        static let ok = "OK"
    }
    
    //MARK: Order Accept
    struct OrderAccept {
        static let orderAccepted = "Your order\nis accepted"
        static let orderProcessing = "Your items has been placed and is on it's way to being processed"
        static let trackOrder = "Track Order"
        static let goBack = "Go Back"
    }
    
    //MARK: Account
    struct Account {
        static let logout = "Logout"
        static let orders = "Orders"
        static let details = "My Details"
        static let deliveryAddress = "Delivery Address"
        static let paymentMethods = "Payment Methods"
        static let promoCodes = "Promo Codes"
        static let notifications = "Notifications"
    }
    
    //MARK: Delivery Address
    struct DeliveryAddress {
        static let title = "Delivery Address"
        static let home = "House"
        static let office = "Office"
        static let name = "Name"
        static let namePlaceholder = "Enter name"
        static let phone = "Phone"
        static let phonePlaceholder = "Enter phone number"
        static let address = "Address"
        static let addressPlaceholder = "Enter address"
        static let addAddress = "Add Address"
        static let updateAddress = "Update Address"
        static let editAddress = "Edit Address"
        static let ok = "OK"
    }
    
    //MARK: Payment Methods
    struct Payment {
        static let title = "Payment Cards"
        static let cardNumber = "Card Number"
        static let cardNumberPlaceholder = "Enter card number"
        static let name = "Name"
        static let namePlaceholder = "Enter name"
        static let month = "MM"
        static let monthPlaceholder = "Enter month"
        static let year = "YYYY"
        static let yearPlaceholder = "Enter year"
        static let addCard = "Add Payment Card"
        static let cardholderName = "CARDHOLDER NAME"
        static let expires = "EXPIRES"
        static let ok = "OK"
    }
    
    //MARK: Promo Code
    struct PromoCode {
        static let title = "Promo Codes"
        static let validUntil = "Valid Until"
    }
    
    //MARK: Notifications
    struct Notification {
        static let title = "Notifications"
        static let readAll = "Read All"
        static let ok = "OK"
    }
    
    //MARK: Orders
    struct Order {
        static let title = "Orders"
        static let orderTitle = "Order"
        static let orderID = "Order ID"
        static let items = "Items"
        static let deliveryType = "Delivery Type"
        static let paymentType = "Payment Type"
        static let status = "Status"
        static let orderDetails = "Order Details"
        static let shipping = "Shipping"
        static let discount = "Discount"
        static let total = "Total"
        static let payment = "Payment"
        static let ok = "OK"
    }
    
    struct Profile {
        static let title = "Personal Information"
        static let fullName = "Full Name"
        static let fullNamePlaceholder = "Enter full name"
        static let username = "Username"
        static let usernamePlaceholder = "Enter username"
        static let email = "Email"
        static let phone = "Phone Number"
        static let phonePlaceholder = "Enter phone number"
        static let selectCountry = "Select Country"
        static let password = "Password"
        static let update = "Update"
        static let changePassword = "Change Password"
        static let ok = "OK"
    }
    
    //MARK: Password Change
    struct PasswordChange {
        static let title = "Change Password"
        static let currentPassword = "Current Password"
        static let currentPasswordPlaceholder = "Enter current password"
        static let newPassword = "New Password"
        static let newPasswordPlaceholder = "Enter new password"
        static let confirmPassword = "Confirm Password"
        static let confirmPasswordPlaceholder = "Confirm new password"
        static let update = "Update"
        static let ok = "OK"
    }
    
    //MARK: Review
    struct Review {
        static let title = "Write Review"
        static let thankYouMessage = "Thank you for trusting and choosing our products. Your honest feedback helps us serve better and helps other customers make informed choices!"
        static let writePlaceholder = "Write Review..."
        static let submit = "Submit"
    }
    
    //MARK: Order Status
    struct OrderStatus {
        // Order Status
        static let placed = "Placed"
        static let accepted = "Accepted"
        static let delivered = "Delivered"
        static let cancelled = "Cancelled"
        static let rejected = "Rejected"
        
        // Delivery Type
        static let delivery = "Delivery"
        static let pickup = "Pickup"
        
        // Payment Type
        static let cashPayment = "Cash Payment"
        static let cardPayment = "Card Payment"
        
        // Payment Status
        static let processing = "Processing"
        static let success = "Success"
        static let error = "Error"
        static let refunded = "Refunded"
    }
}
