<%@ page import="java.sql.*" %>
<html>
<body>
<%
    String accNum = request.getParameter("account_number");
    if(accNum != null) {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Reusing your database connection string [cite: 3, 13]
            conn = DriverManager.getConnection("jdbc:mysql://db:3306/testdb?useSSL=false&serverTimezone=UTC", "root", "root");
            stmt = conn.createStatement();

            // VULNERABLE: Direct string concatenation
            String query = "SELECT account_number, balance FROM accounts WHERE account_number = '" + accNum;
            
            out.println("<p><b>Executed Query:</b> " + query + "</p><hr>");
            
            rs = stmt.executeQuery(query);
            
            while(rs.next()) {
                out.println("<b>Account:</b> " + rs.getString(1) + " | ");
                out.println("<b>Balance:</b> " + rs.getString(2) + "<br>");
            }
        } catch(Exception e) {
            out.println("<p style='color:red;'><b>Database Error:</b> " + e.getMessage() + "</p>");
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e){}
            try { if(stmt != null) stmt.close(); } catch(Exception e){}
            try { if(conn != null) conn.close(); } catch(Exception e){}
        }
    }
%>
</body>
</html>

