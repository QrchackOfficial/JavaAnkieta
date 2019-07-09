<%@ page import="bean.ConnectionProvider" %>
<%@ page import="bean.Survey" %>
<%@ page import="pl.qrchack.Constants" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<jsp:useBean id="obj" class="bean.LoginBean"/>
<jsp:setProperty name="obj" property="*"/>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <%
        Integer surveyid = Integer.parseInt(request.getParameter("id"));
        String title = Survey.getTitleBySurveyId(surveyid);
    %>
    <title><%=title%> - <%=Constants.appName%>
    </title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%
    if (request.getParameter("submit") != null) {
        int row = 1;
        int numrows = Integer.parseInt(request.getParameter("numrows"));
        try {
            Connection con = ConnectionProvider.getCon();
            while (row <= numrows) {
                PreparedStatement ps = con.prepareStatement(
                        "insert into answers(id, questionid, surveyid, answer) values(null, ?, ?, ?);"
                );
                ps.setInt(1, Integer.parseInt(request.getParameter("question" + row + "id")));
                ps.setInt(2, surveyid);
                ps.setInt(3, Integer.parseInt(request.getParameter("question" + row)));

                ps.executeUpdate();
                ps.close();
                row++;
            }
            Survey.addResponseCounter(surveyid);
            response.sendRedirect("answer_done.jsp");
        } catch (SQLException e) {
            throw e;
        }
    }
%>
<div class="container form-center" style="max-width:800px">
    <p>
    <h1 class="text-center mb-5 mt-4">
        <%=title%>
    </h1>
    </p>
    <form action="?id=<%=request.getParameter("id")%>" method="post" class="text-center">
        <%
            ResultSet questions = Survey.getQuestionsBySurveyId(surveyid);
            int rows = 0;
            while (questions.next()) {
                rows++;
                out.println("\n\t\t<h4 class='mt-5'>" + questions.getString("question") + "</h4>");
                out.println("\t\t<input type='hidden' name='question" + rows + "id' value='" + questions.getInt("id") + "'>");
                for (int i = 1; i <= 4; i++) {
                    if (questions.getString("answer" + i) != null) {
                        // include answer values if present
                        if (!questions.getString("answer" + i).equals("")) {
                            out.print(
                                    "\t\t<div class=\"custom-control custom-radio text-justify\">\n" +
                                            "\t\t\t" +
                                            "<input class=\"custom-control-input\" type='radio' id='question" + rows + "answer" + i + "' name='question" + rows + "' value='" + i + "' required>\n" +
                                            "\t\t\t<label class=\"custom-control-label\" for='question" + rows + "answer" + i + "'>" + questions.getString("answer" + i) + "</label>" +
                                            "\n" + "\t\t</div>\n"
                            );
                        }
                    }
                }
            }
            out.println("\t\t<input type='hidden' id='numrows' name='numrows' value='" + rows + "'>");
        %>
        <button id="btnSubmit" class="btn btn-success mt-4" type="submit" name="submit" value="submit">
            <i data-feather="check"></i>
            Submit
        </button>
    </form>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.9.0/feather.min.js"></script>
<script>
    var rowNum = <%=rows%>;

    $(document).ready(function () {
        feather.replace();
        $('[data-toggle="tooltip"]').tooltip()
    });
</script>
</body>
</html>