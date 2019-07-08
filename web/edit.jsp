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
    <title>Dashboard - <%=Constants.appName%>
    </title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%
    if (session.getAttribute("uid") == null) {
        response.sendRedirect("login.jsp");
    }
    Integer uid = Integer.parseInt(session.getAttribute("uid").toString());
    if (request.getParameter("submit") != null) {
        Integer surveyid = Integer.parseInt(request.getParameter("id"));
        Survey.clearSurvey(surveyid);
        int row = 1;
        int numrows = Integer.parseInt(request.getParameter("numrows"));
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps = con.prepareStatement(
                    "update JavaAnkieta.surveys set name=? where id=?"
            );
            ps.setString(1, request.getParameter("title"));
            ps.setInt(2, surveyid);
            ps.executeUpdate();
            ps.close();
            while (row <= numrows) {
                ps = con.prepareStatement(
                        "insert into JavaAnkieta.questions(id, survey_id, question, answer1, answer2, answer3, answer4, qorder) values(null,?,?,?,?,?,?,?);"
                );
                ps.setInt(1, Integer.parseInt(request.getParameter("id")));
                ps.setString(2, request.getParameter("question" + row));
                ps.setString(3, request.getParameter("question" + row + "answer1"));
                ps.setString(4, request.getParameter("question" + row + "answer2"));
                ps.setString(5, request.getParameter("question" + row + "answer3"));
                ps.setString(6, request.getParameter("question" + row + "answer4"));
                ps.setInt(7, row);
                ps.executeUpdate();
                ps.close();
                row++;
            }
        } catch (SQLException e) {
            throw e;
        }
    }
%>
<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top flex-md-nowrap">
    <a href="" class="navbar-brand">
        <img src="img/logo_white.svg" width="22" height="22" class="d-inline-block align-center">
        <%=Constants.appName%>
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown"
            aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item active">
                <a class="nav-link" href="#">
                    <i data-feather="home"></i>
                    Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <i data-feather="bar-chart-2"></i>
                    Statistics
                </a>
            </li>
            <li class="nav-item">
                <a href="logout.jsp" class="nav-link">
                    <i data-feather="log-out"></i>
                    Sign out
                </a>
            </li>
        </ul>
    </div>
</nav>
<div class="container">
    <div class="row">
        <nav class="col-md-2 d-none d-lg-block sidebar">
            <div class="sidebar-sticky">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="dashboard.jsp">
                            <span data-feather="home"></span>
                            Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <span data-feather="bar-chart-2"></span>
                            Statistics
                        </a>
                    </li>
                </ul>

                <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                    <span>My <%=Constants.entryName%>s</span>
                    <a class="d-flex align-items-center text-muted" href="#">
                        <span data-feather="plus-circle"></span>
                    </a>
                </h6>
                <ul class="nav flex-column mb-2">
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <span data-feather="file-text"></span>
                            Survey 1
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <span data-feather="file-text"></span>
                            Survey 2
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <span data-feather="file-text"></span>
                            Survey 3
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
        <%
            Integer surveyid = Integer.parseInt(request.getParameter("id"));
            ResultSet questions = Survey.getQuestionsBySurveyId(surveyid);
        %>
        <main role="main" class="ml-sm-auto col-lg-10">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3">
                <h3>Editing <%=Constants.entryName%>: <%=Survey.getTitleBySurveyId(surveyid)%>
                </h3>
            </div>
            <div class="text-center line-bottom">
                <form action="?id=<%=request.getParameter("id")%>" method="post" class="formEdit">
                    <%
                        out.print(
                                "<div class='container text-center'>" +
                                        "<div class='form-group row'>" +
                                        "<input class='form-control form-control-lg text-center' type='text' name='title' value='" + Survey.getTitleBySurveyId(surveyid) + "'>" +
                                        "</div>" +
                                        "</div>"
                        );
                        int rows = 0;
                        while (questions.next()) {
                            rows++;
                            out.print(
                                    "<div class='container text-center' id='row" + rows + "'>" +
                                            "<div class='form-group row'>" +
                                            "<input name='question" + rows + "' class='form-control form-control-lg text-center' type='text'" +
                                            "value='" + questions.getString("question") + "' required>" +
                                            "</div>"
                            );
                            for (int i = 1; i <= 4; i++) {
                                out.print(
                                        "<div class='form-group row'>" +
                                                "<input name='question" + rows + "answer" + i + "' class='form-control form-control-sm text-center'" +
                                                "type='text' "
                                );
                                if (questions.getString("answer" + i) != null) {
                                    // include answer values if present
                                    out.print("value='" + questions.getString("answer" + i) + "'");
                                }
                                out.print(
                                        "placeholder='Answer " + i + "'>" +
                                                "</div>"
                                );
                            }
                            if (rows != 1) {
                                out.println(
                                        "<p>" +
                                                "<button class='btn btn-sm btn-danger' onclick='removeRow(" + rows + ")'>" +
                                                "<i data-feather='delete'></i>" +
                                                " Delete Question" +
                                                "</button>" +
                                                "</p>"
                                );
                            }
                            out.println("</div>");
                        }
                        out.println("<input type='hidden' id='numrows' name='numrows' value='" + rows + "'>");
                    %>
                    <div id="btnAdd" class="btn btn-primary" onclick="addRow()">
                        <i data-feather="plus"></i>
                        Add
                    </div>
                    <button id="btnSave" class="btn btn-success" type="submit" name="submit" value="submit">
                        <i data-feather="check"></i>
                        Save changes
                    </button>
                </form>
                <div class="mt-4">
                    <p class="text-muted small text-center">
                        Please don't forget to <a href="logout.jsp">sign out</a> when you're done!
                    </p>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.9.0/feather.min.js"></script>
<script>
    var rowNum = <%=rows%>;

    function addRow() {
        rowNum++;
        var row = "<div class='container text-center' id='row" + rowNum + "'>" +
            "     <div class='form-group row'>" +
            "         <input name='question" + rowNum + "' class='form-control form-control-lg text-center' type='text' placeholder='Question " + rowNum + "' required>" +
            "     </div>" +
            "     <div class='form-group row'>" +
            "         <input name='question" + rowNum + "answer1' type='form-control form-control-sm text-center' type='text' placeholder='Answer 1'>" +
            "     </div>" +
            "     <div class='form-group row'>" +
            "         <input name='question" + rowNum + "answer2' type='form-control form-control-sm text-center' type='text' placeholder='Answer 2'>" +
            "     </div>" +
            "     <div class='form-group row'>" +
            "         <input name='question" + rowNum + "answer3' type='form-control form-control-sm text-center' type='text' placeholder='Answer 3'>" +
            "     </div>" +
            "     <div class='form-group row'>" +
            "         <input name='question" + rowNum + "answer4' type='form-control form-control-sm text-center' type='text' placeholder='Answer 4'>" +
            "     </div>" +
            "     <p>" +
            "         <button class='btn btn-sm btn-danger' onclick=removeRow(" + rowNum + ")>" +
            "             <i data-feather='delete'></i>" +
            "               Delete Question" +
            "         </button>" +
            "     </p>" +
            "</div>";
        $("#btnAdd").before(row);
        $("#numrows").val(rowNum);
        feather.replace();
    }

    function removeRow(num) {
        $("#row" + num).remove();
        rowNum--;
        $("#numrows").val(rowNum);
    }

    $(document).ready(function () {
        feather.replace();
        $('[data-toggle="tooltip"]').tooltip()
    });
</script>
</body>
</html>