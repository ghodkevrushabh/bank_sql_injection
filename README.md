# SQL Injection Lab: Vulnerability & Remediation in Java

A containerized web application built with Java, JSP, and MySQL designed to demonstrate a classic UNION-based SQL Injection vulnerability and its proper remediation using Prepared Statements. 

This project operates as an educational "glass box" environment, intentionally displaying the executed backend queries to the frontend to visualize exactly how malicious payloads manipulate string concatenation in real-time.

## 🛠️ Tech Stack
* **Frontend:** HTML, CSS
* **Backend:** Java (JSP, JDBC)
* **Database:** MySQL 8.0
* **Server:** Apache Tomcat 9
* **Infrastructure:** Docker & Docker Compose

## 📁 Project Structure
```text
.
├── docker-compose.yml       # Orchestrates the Tomcat web server and MySQL database
├── Dockerfile               # Builds the Tomcat image and installs the MySQL JDBC connector
├── db/
│   └── init.sql             # Initializes the database schema, public accounts, and sensitive user data
└── web/
    ├── sqlInjection.html    # The vulnerable frontend application
    ├── sqlInjection.jsp     # The backend logic featuring unsafe string concatenation
    ├── secure.html          # The secure frontend application
    └── secure.jsp           # The remediated backend using PreparedStatement
