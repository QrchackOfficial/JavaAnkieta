<%@page import="bean.Survey" %>
<jsp:useBean id="obj" class="bean.LoginBean"/>
<jsp:setProperty name="obj" property="*"/>
<%
    Survey.deleteSurvey(Integer.parseInt(request.getParameter("id")));
    response.sendRedirect("dashboard.jsp?action=deleted");
%>