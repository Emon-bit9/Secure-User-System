# Secure User System

This is a PHP-based web application demonstrating advanced cryptographic security principles for user authentication and encrypted content management.

## Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Frontend      │    │    Backend       │    │   Database      │
├─────────────────┤    ├──────────────────┤    ├─────────────────┤
│ login.php       │───►│ process_login.php│───►│ users           │
│ register.php    │───►│ process_register │───►│ └─encrypted     │
│ dashboard.php   │───►│ functions.php    │───►│ posts           │
│ see_posts.php   │───►│ Security.php     │───►│ └─encrypted     │
│ allpost.php     │    │ config.php       │    │ └─mac_verified  │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

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

## Technology Stack

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

## Installation

1. Import `Database/secure_user_system.sql`
2. Configure database settings in `includes/config.php`
3. Deploy to PHP-enabled web server
4. Access via web browser


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

Based on CSE447 Lab Project specifications:

| Requirement | Status | Implementation |
|-------------|--------|---------------|
| 1. Login/Register System | ✓ Complete | Full UI with form processing |
| 2. Encrypted User Info Storage | ✓ Complete | AES-256-CBC encryption |
| 3. Password Hashing & Salting | ✓ Complete | bcrypt + custom salt |
| 4. Separate Credential Check | ✓ Complete | Dedicated verification methods |
| 5. Key Management Module | ✓ Complete | Security class with full crypto operations |
| 6. Encrypted Post/View System | ✓ Complete | End-to-end encryption for content |
| 7. Database Encryption Protection | ✓ Complete | All sensitive data encrypted |
| 8. MAC Integrity Check (Optional) | ✓ Complete | HMAC-SHA256 verification |

