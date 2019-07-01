<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Dashboard - SurveyCreator</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%
    if (session.getAttribute("userid") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top flex-md-nowrap">
    <a href="" class="navbar-brand">
        <img src="img/logo_white.svg" width="22" height="22" class="d-inline-block align-center">
        SurveyCreator
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
<div class="container-fluid">
    <div class="row">
        <nav class="col-md-2 d-none d-md-block sidebar">
            <div class="sidebar-sticky">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">
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
                    <span>My Surveys</span>
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
        <main role="main" class="col-md9 ml-sm-auto col-lg-10 px-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3">
                <h3>Surveys</h3>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <div class="btn-group mr-2">
                        <button class="btn btn-primary">
                            <i data-feather="plus-square"></i>
                            Create new
                        </button>
                    </div>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-striped table-sm">
                    <thead>
                    <th>Title</th>
                    <th>Created</th>
                    <th>Answers</th>
                    <th>Actions</th>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <a href="">
                                Survey 1
                            </a>
                        </td>
                        <td>
                                <span class="badge badge-pill badge-secondary">
                                    15m ago
                                </span>
                        </td>
                        <td>
                            15
                        </td>
                        <td>
                            <div class="btn-toolbar mb-2 mb-md-0">
                                <div class="btn-group mr-2">
                                    <button type="button" class="btn btn-sm btn-warning">
                                        <i data-feather="edit"></i>
                                        Edit
                                    </button>
                                    <button type="submit" class="btn btn-sm btn-danger">
                                        <i data-feather="delete"></i>
                                        Delete
                                    </button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a href="">
                                Survey 2
                            </a>
                        </td>
                        <td>
                                <span class="badge badge-pill badge-secondary">
                                    25m ago
                                </span>
                        </td>
                        <td>
                            7
                        </td>
                        <td>
                            <div class="btn-toolbar mb-2 mb-md-0">
                                <div class="btn-group mr-2">
                                    <button type="button" class="btn btn-sm btn-warning">
                                        <i data-feather="edit"></i>
                                        Edit
                                    </button>
                                    <button type="submit" class="btn btn-sm btn-danger">
                                        <i data-feather="delete"></i>
                                        Delete
                                    </button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a href="">
                                Survey 3
                            </a>
                        </td>
                        <td>
                                <span class="badge badge-pill badge-secondary">
                                    3h ago
                                </span>
                        </td>
                        <td>
                            48
                        </td>
                        <td>
                            <div class="btn-toolbar mb-2 mb-md-0">
                                <div class="btn-group mr-2">
                                    <button type="button" class="btn btn-sm btn-warning">
                                        <i data-feather="edit"></i>
                                        Edit
                                    </button>
                                    <button type="submit" class="btn btn-sm btn-danger">
                                        <i data-feather="delete"></i>
                                        Delete
                                    </button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a href="">
                                Survey 4
                            </a>
                        </td>
                        <td>
                                <span class="badge badge-pill badge-secondary">
                                    12d ago
                                </span>
                        </td>
                        <td>
                            7
                        </td>
                        <td>
                            <div class="btn-toolbar mb-2 mb-md-0">
                                <div class="btn-group mr-2">
                                    <button type="button" class="btn btn-sm btn-warning">
                                        <i data-feather="edit"></i>
                                        Edit
                                    </button>
                                    <button type="submit" class="btn btn-sm btn-danger">
                                        <i data-feather="delete"></i>
                                        Delete
                                    </button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <p class="text-muted small text-center">
                Please don't forget to <a href="logout.jsp">sign out</a> when you're done!
            </p>
        </main>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.9.0/feather.min.js"></script>
<script>
    feather.replace();
</script>
</body>
</html>
