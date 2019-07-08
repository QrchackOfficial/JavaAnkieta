<%@ page import="bean.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<jsp:useBean id="obj" class="bean.LoginBean"/>
<jsp:setProperty name="obj" property="*"/>
<%
    if (session.getAttribute("uid") == null) {
        response.sendRedirect("login.jsp");
    }
    Integer uid = Integer.parseInt(session.getAttribute("uid").toString());
    try {
        Connection con = ConnectionProvider.getCon();
        PreparedStatement ps = con.prepareStatement(
                "insert into JavaAnkieta.surveys(id, name, owner_uid, created, answers) values(null,?,?,?,0);",
                Statement.RETURN_GENERATED_KEYS
        );
        ps.setString(1, "Title goes here");
        ps.setInt(2, uid);
        ps.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
        ps.execute();
        ResultSet rs = ps.getGeneratedKeys();
        int key = 0;
        if (rs.next()) {
            key = rs.getInt(1);
            response.sendRedirect("edit.jsp?id=" + key);
        } else {
            // TODO handle this
            throw new Exception("uh oh! something happened");
        }
    } catch (SQLException e) {
        throw e;
    }
%>