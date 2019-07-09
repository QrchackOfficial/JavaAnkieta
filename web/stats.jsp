<%@page import="bean.Survey" %>
<%@page import="pl.qrchack.Constants" %>
<%@page import="java.sql.ResultSet" %>
<jsp:useBean id="obj" class="bean.LoginBean"/>
<jsp:setProperty name="obj" property="*"/>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Statistics - <%=Constants.appName%>
    </title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.css">--%>
    <link rel="stylesheet" href="css/style.css">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.9.0/feather.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
</head>
<body>
<%
    Integer uid = 0;
    if (session.getAttribute("uid") == null) {
        response.sendRedirect("login.jsp");
    } else {
        uid = (Integer) session.getAttribute("uid");
    }
    Integer surveyid = Integer.parseInt(request.getParameter("id"));
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
                        <a class="nav-link" href="dashboard.jsp">
                            <span data-feather="home"></span>
                            Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="stats.jsp">
                            <span data-feather="bar-chart-2"></span>
                            Statistics
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
        <main role="main" class="ml-sm-auto col-lg-10">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3">
                <h2><%=Constants.entryName%>: <%=Survey.getTitleBySurveyId(surveyid)%>
                </h2>
            </div>
            <div>
                <%
                    ResultSet questions = Survey.getQuestionsBySurveyId(surveyid);
                    int rows = 0;
                    while (questions.next()) {
                        rows++;
                %>
                <h3 class="text-center mt-6">
                    <%=questions.getString("question")%>
                </h3>
                <canvas id="chart<%=rows%>" style="margin-bottom:40px"></canvas>
                <script>
                    var chart = new Chart($("#chart<%=rows%>"), {
                        type: 'pie',
                        data: {
                            labels: [
                                <%
                                for (int i = 1; i <= 4; i++) {
                                    if (questions.getString("answer" + i) != null) {
                                        // include answer values if present
                                        if (!questions.getString("answer" + i).equals("")) {
                                            if (i < 4)
                                                out.print("'" + questions.getString("answer" + i) + "', ");
                                            else
                                                out.print("'" + questions.getString("answer" + i) + "'");
                                        }
                                    }
                                }
                                %>
                            ],
                            datasets: [{
                                label: '<%=questions.getString("question")%>',
                                data: [
                                    <%=Survey.getAnswerCountByQuestionId(questions.getInt("id"),1)%>,
                                    <%=Survey.getAnswerCountByQuestionId(questions.getInt("id"),2)%>,
                                    <%=Survey.getAnswerCountByQuestionId(questions.getInt("id"),3)%>,
                                    <%=Survey.getAnswerCountByQuestionId(questions.getInt("id"),4)%>
                                ],
                                backgroundColor: [
                                    '#17a2b8',
                                    '#ffc107',
                                    '#28a745',
                                    '#dc3545'
                                ]
                            }]
                        }
                    });
                </script>
                <%
                    }
                %>
            </div>
            <p class="text-muted small text-center">
                Please don't forget to <a href="logout.jsp">sign out</a> when you're done!
            </p>
        </main>
    </div>
</div>

<script>
    feather.replace();
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    })
</script>
</body>
</html>
