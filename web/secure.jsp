<%@ page import="java.sql.*" %>
<html>
<body>
<%
    String accNum = request.getParameter("account_number");
    if(accNum != null) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://db:3306/testdb?useSSL=false&serverTimezone=UTC", "root", "root");

            // SECURE: Parameterized Query [cite: 4]
            String query = "SELECT account_number, balance FROM accounts WHERE account_number = ?";
            
            ps = conn.prepareStatement(query);
            ps.setString(1, accNum); // Input is safely bound as a string [cite: 5]
            
            out.println("<p><b>Executing Safe Query via PreparedStatement</b></p><hr>");
            
            rs = ps.executeQuery();
            boolean found = false;
            
            while(rs.next()) {
                found = true;
                out.println("<b>Account:</b> " + rs.getString(1) + " | ");
                out.println("<b>Balance:</b> " + rs.getString(2) + "<br>");
            }
            if(!found) {
                out.println("No account found matching that number.");
            }
        } catch(Exception e) {
            out.println("<p style='color:red;'><b>Error:</b> " + e.getMessage() + "</p>");
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e){}
            try { if(ps != null) ps.close(); } catch(Exception e){}
            try { if(conn != null) conn.close(); } catch(Exception e){}
        }
    }
%>
</body>
</html>
