# Secure User System

This is a PHP-based web application demonstrating advanced cryptographic security principles for user authentication and encrypted content management.

## Core Components

| Component | Purpose | Security Implementation |
|-----------|---------|------------------------|
| **Security.php** | Cryptographic operations | AES-256-CBC, HMAC-SHA256, bcrypt |
| **functions.php** | Database operations | Encrypted storage, MAC verification |
| **config.php** | Security headers & session | CSP, XSS protection, secure cookies |
| **Database** | Data persistence | All sensitive data encrypted |

## Features

- User registration and authentication
- AES-256-CBC encryption for all sensitive data
- bcrypt password hashing with custom salts
- HMAC-SHA256 integrity verification
- Per-user encryption keys
- Secure session management
- Encrypted content posting system

## Tech Stack

- **Frontend**: HTML5 + CSS3
- **Database**: MariaDB 10.4.32 / MySQL
- **Backend**: PHP 8.2.12
- **Encryption**: AES-256-CBC with OpenSSL
- **Hashing**: bcrypt (PASSWORD_BCRYPT)
- **Session Management**: PHP native sessions with security hardening

## Database Schema

```sql
users (id, username, password_hash, salt, encryption_key, iv, email, created_at)
posts (id, user_id, encrypted_content, iv, mac, created_at)
```

## Project Structure

```
secure-user-system/
├── includes/
│   ├── config.php          # Security configuration & headers
│   ├── functions.php       # Database class & core functions  
│   └── Security.php        # Cryptographic operations class
├── Database/
│   └── secure_user_system.sql  # Database schema with encrypted data
├── css/
│   └── style.css          # Styling for forms
├── Core PHP Files:
│   ├── index.php          # Entry point (redirects to login)
│   ├── login.php          # User authentication interface
│   ├── register.php       # User registration interface  
│   ├── dashboard.php      # Main user interface
│   ├── process_login.php  # Login processing logic
│   ├── process_register.php # Registration processing logic
│   ├── see_posts.php      # User's encrypted posts viewer
│   ├── allpost.php        # All users' posts viewer
│   ├── logout.php         # Session termination
│   └── test.php           # Development/testing interface
└── CSE447 Lab project.pdf # Project requirements specification
```

## Requirements Implementation

Based on Project requirements:

| Requirement | Implementation Details |
|-------------|----------------------|
| **1. Login/Register System** | Complete authentication system with `login.php`, `register.php` interfaces and dedicated processing scripts with form validation, error handling, and secure redirects |
| **2. Encrypted User Info Storage** | User emails encrypted using AES-256-CBC with individual IVs before database storage. Encryption keys managed per-user with secure random generation |
| **3. Password Hashing & Salting** | bcrypt hashing with PASSWORD_BCRYPT constant, custom 32-character hex salts generated via secure random bytes, password+salt combination before hashing |
| **4. Separate Credential Check** | Dedicated `loginUser()` method in Database class and `verifyPassword()` in Security class with prepared statements and secure comparison |
| **5. Key Management Module** | Complete Security.php class handles encryption/decryption, key generation, MAC operations. Per-user 256-bit encryption keys with global encryption key for system data |
| **6. Encrypted Post/View System** | Posts encrypted with user-specific keys using AES-256-CBC. Decryption on retrieval with MAC verification. Separate methods for personal and all-user post viewing |
| **7. Database Encryption Protection** | All sensitive data encrypted: emails (AES-256-CBC), passwords (bcrypt), posts (AES-256-CBC). Even with database access, no plaintext data recoverable |
| **8. MAC Integrity Check (Optional)** | HMAC-SHA256 implementation for all encrypted content. MAC verification before decryption with visual feedback for integrity status and tamper detection |

## Architecture

### Security Layered Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        PRESENTATION LAYER                       │
├─────────────────────────────────────────────────────────────────┤
│  login.php  │  register.php  │  dashboard.php  │  see_posts.php │
│             │                │                 │  allpost.php   │
└─────────────┴────────────────┴─────────────────┴────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────┐
│                      SECURITY MIDDLEWARE                        │
├─────────────────────────────────────────────────────────────────┤
│  • Session Management (HTTP-only, Secure Cookies)              │
│  • Security Headers (CSP, XSS, Frame Protection)               │
│  • Input Validation & Sanitization                             │
└─────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────┐
│                      APPLICATION LAYER                          │
├─────────────────────────────────────────────────────────────────┤
│  process_login.php  │  process_register.php  │  functions.php  │
└─────────────────────┴─────────────────────────┴─────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────┐
│                    CRYPTOGRAPHIC LAYER                          │
├─────────────────────────────────────────────────────────────────┤
│                         Security.php                            │
│  ┌─────────────────┬─────────────────┬─────────────────────────┐ │
│  │   ENCRYPTION    │    HASHING      │    INTEGRITY CHECK     │ │
│  │  AES-256-CBC    │ bcrypt + salt   │    HMAC-SHA256        │ │
│  │  Per-user keys  │ Secure random   │    MAC verification   │ │
│  └─────────────────┴─────────────────┴─────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────┐
│                        DATA LAYER                               │
├─────────────────────────────────────────────────────────────────┤
│  ┌─────────────────────┐    ┌─────────────────────────────────┐  │
│  │       USERS         │    │           POSTS                 │  │
│  │ • encrypted_email   │    │ • encrypted_content             │  │
│  │ • password_hash     │    │ • initialization_vector         │  │
│  │ • salt              │    │ • mac_signature                 │  │
│  │ • encryption_key    │    │ • user_id (FK)                  │  │
│  └─────────────────────┘    └─────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

