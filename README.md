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
```

🚀 Quick Start (Docker)
Ensure you have Docker and Docker Compose installed on your machine.

Clone the repository:

```
git clone <your-repository-url>
cd <repository-folder>
```

Build and spin up the containers:

```
docker-compose up --build -d
```
Note: MySQL may take 15-30 seconds to fully initialize the tables on the first run.

Access the Application:

Vulnerable Version: http://localhost:8080/sqlInjection.html

Secure Version: http://localhost:8080/secure.html

Tear down the environment:

```
docker-compose down -v
```
💥 The Vulnerability (Proof of Concept)
The vulnerable component of this application (sqlInjection.jsp) takes user input and directly concatenates it into the SQL query string:

```
// VULNERABLE CODE PATTERN
String query = "SELECT account_number, balance FROM accounts WHERE account_number = '" + accNum + "'";
```
The Exploit
Navigate to the vulnerable version and enter a standard account number: 1001. The application will return the balance normally.

To exploit the vulnerability and steal sensitive data from the hidden users table, inject the following payload:

```
1001' UNION SELECT username, password FROM users #
```
What Happens Under the Hood?
The ' after 1001 prematurely closes the string intended for the account_number.

The UNION operator tells the database to append a second result set to the original query.

SELECT username, password FROM users fetches the sensitive administrative credentials.

The # symbol comments out the trailing ' that the Java application forcefully appends, preventing a syntax error.

Result: The application leaks the usernames and passwords directly to the browser.

🛡️ The Remediation
The secure component (secure.jsp) mitigates this exact attack vector by abandoning string concatenation in favor of parameterized queries (PreparedStatement).

```
// SECURE CODE PATTERN
String query = "SELECT account_number, balance FROM accounts WHERE account_number = ?";
PreparedStatement ps = conn.prepareStatement(query);
ps.setString(1, accNum); 
```
When the exact same malicious payload is entered into the secure version, the database treats the input strictly as a literal string value rather than executable code. The database simply searches for an account literally named 1001' UNION SELECT username, password FROM users #, finds no match, and safely returns an empty result, entirely neutralizing the attack.

👤 Author
Vrushabh Rajkumar Ghodke
