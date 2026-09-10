# Big Data Analytics - SQL Database & Query Analysis Project

A comprehensive SQL database project analyzing relational schemas, client invoices, customer points, pricing tiers, and payment methods. This project features database creation scripts, data manipulation language (DML), subqueries, joins, window functions, and aggregation techniques.

---

## 📋 Table of Contents
- [Project Overview](#project-overview)
- [Repository Structure](#repository-structure)
- [Database Schema & Tables](#database-schema--tables)
- [Key SQL Queries & Analysis](#key-sql-queries--analysis)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [License](#license)

---

## 🔍 Project Overview

This repository contains SQL scripts and database modeling exercises focused on managing relational client and invoice management systems (specifically `bda_june_2026_p1`). 

**Key Highlights:**
* **Database & Table Initialization:** DDL scripts for defining tables like `clients` with proper primary key constraints.
* **Complex Data Retrieval:** Filtering using `WHERE`, subqueries, date conversions (`STR_TO_DATE`), and pattern matching.
* **Multi-table Operations:** Inner joins linking client profiles, payments, invoices, and payment methods.
* **Advanced Analytical SQL:** Window functions (`DENSE_RANK`, `RANK`), multi-level subqueries, and conditional aggregations (`GROUP BY ... HAVING`).

---

## 📂 Repository Structure

```
├── sql/
│   └── BDA_2026_2_p1_1.sql       # Main SQL script with DDL, DML, and Analytical Queries
├── data/
│   ├── mosh_customers.csv        # Imported customer profiles & loyalty points data
│   ├── mosh_products.csv         # Product catalog and unit prices
│   ├── mosh_invoices.csv         # Invoice history, totals, and due dates
│   ├── mosh_payments.csv         # Payment transactions and client IDs
│   └── mosh_payment_methods.csv  # Mapping of payment method IDs to descriptions
├── README.md                     # Project documentation
└── .gitignore                    # standard Git ignore file
```

---

## 🗄️ Database Schema & Tables

The primary database used is `bda_june_2026_p1`. 

### Tables Included:
1. **`clients`**: Primary client records with detailed contact info (Address, City, State, Phone).
2. **`mosh_customers`**: Customer demographics, birth dates, and loyalty points.
3. **`mosh_products`**: Product details and unit prices.
4. **`mosh_invoices`**: Billing records containing invoice total, payment total, invoice date, and due date.
5. **`mosh_payments`**: Recorded payments linked to clients and invoices.
6. **`mosh_payment_methods`**: Key-value lookup for payment methods.

---

## ⚡ Key SQL Queries & Analysis

The file `BDA_2026_2_p1_1.sql` addresses several specific analytical and operational questions:

| Section | Description / Query Objective | Techniques Used |
| :--- | :--- | :--- |
| **Section 1 & 2** | Database creation and setting up `clients` table with initial inserts | `CREATE DATABASE`, `CREATE TABLE`, `INSERT INTO` |
| **Section 4.a** | Extract unique states where customers are located | `SELECT DISTINCT` |
| **Section 4.b** | Simulate a 10% price markup on all products (`unit_price * 1.1`) | Computed Column / Alias |
| **Section 4.c** | Filter invoices issued after June 30, 2019 | `STR_TO_DATE()`, Range filtering |
| **Section 4.d** | Identify high-value young customers (Born after 1990 with > 1000 points) | Date parsing & Logical `AND` |
| **Section 4.f** | Retrieve all products cheaper than Lettuce | Subquery scalar filtering |
| **Section 5.a - 5.b**| Join client, invoice, and payment method details | `INNER JOIN` across multiple entities |
| **Section 6.a** | Identify inactive clients with zero invoices | Subquery with `NOT IN` |
| **Section 6.b** | Clients with invoice totals exceeding Client 3's maximum invoice | Nested subqueries with `MAX()` |
| **Section 6.c** | Group and rank invoice totals per client | Window Functions (`RANK()`, `DENSE_RANK() OVER (...)`) |
| **Section 6.d** | Identify clients with at least 2 recorded invoices | `GROUP BY` with `HAVING COUNT() >= 2` |

---

## 🚀 Getting Started

### Prerequisites
* MySQL Server 8.0+ or any compatible relational database engine (e.g., MariaDB).
* MySQL Workbench, DBeaver, or command-line client.

### Execution Instructions

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/bda-sql-analysis.git
   cd bda-sql-analysis
   ```

2. **Execute the SQL Script:**
   Open `sql/BDA_2026_2_p1_1.sql` in your SQL client or execute via terminal:
   ```bash
   mysql -u root -p < sql/BDA_2026_2_p1_1.sql
   ```

3. **Import CSV Files (if executing step-by-step):**
   Ensure `mosh_customers`, `mosh_products`, `mosh_invoices`, `mosh_payments`, and `mosh_payment_methods` CSV files are imported into the `bda_june_2026_p1` database prior to executing the join and aggregation queries in sections 4 through 6.

---

## 📜 License

This project is open-source and available under the [MIT License](LICENSE).
