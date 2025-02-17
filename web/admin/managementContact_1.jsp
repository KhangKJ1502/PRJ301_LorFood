<%@ page import="DBContext.ConnectDB, java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Dashboard - Management Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="css/styles.css" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style>
            body {
                background-color: #f8f9fa;
            }

            .card {
                margin-top: 50px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .card-header {
                background-color: #007bff;
                color: white;
                font-weight: bold;
                text-align: center;
            }

            .form-label {
                font-weight: bold;
            }

            .btn-primary {
                background-color: #007bff;
                border: none;
            }

            .btn-primary:hover {
                background-color: #0056b3;
            }

            .form-text a {
                color: #007bff;
            }

            .form-text a:hover {
                color: #0056b3;
                text-decoration: underline;
            }
        </style>
    </head>

    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand ps-3" href="index.html">Management Admin</a>
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">Settings</a></li>
                        <li><a class="dropdown-item" href="#!">Activity Log</a></li>
                        <li>
                            <hr class="dropdown-divider" />
                        </li>
                        <li><a class="dropdown-item" href="./signInAdmin.php">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Management</div>
                            <a class="nav-link" href="homeAdmin.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-address-book"></i></div>
                                User Management
                            </a>
                            <a class="nav-link" href="managementContact.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-address-book"></i></div>
                                Contact Management
                            </a>
                            <a class="nav-link" href="managementProduct.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-address-book"></i></div>
                                Product Management
                            </a>
                            <a class="nav-link" href="managementCategory.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-address-book"></i></div>
                                Category Management
                            </a>
                            <a class="nav-link" href="managementOrder.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-address-book"></i></div>
                                Order Management
                            </a>
                            <a class="nav-link" href="managementOrderDetail.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-address-book"></i></div>
                                Order Detail
                            </a>
                            <a class="nav-link" href="managementAdmin.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-address-book"></i></div>
                                Admin account
                            </a>
                               <a class="nav-link" href="ShippingMethodServlet?&action=showInfo">
                                <div class="sb-nav-link-icon"><i class="fas fa-address-book"></i></div>
                                Shipping Method
                            </a>
                            <a class="nav-link" href="PaymentMethodServlet?&action=showInfo">
                                <div class="sb-nav-link-icon"><i class="fas fa-address-book"></i></div>
                                Payment Method
                            </a>
                            <a class="nav-link" href="PaymentServlet?&action=show">
                                <div class="sb-nav-link-icon"><i class="fas fa-address-book"></i></div>
                                Payment Management
                            </a>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        Management Admin
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Contact Management</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">View Orders</li>
                        </ol>
                      
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Contact List
                            </div>
                            <div class="card-body">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Full Name</th>
                                            <th>Email</th>
                                            <th>Phone Number</th>
                                            <th>Complain</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            Connection conn = null;
                                            PreparedStatement stmt = null;
                                            ResultSet rs = null;

                                            try {
                                                conn = ConnectDB.getConnection();
                                                String sql = "SELECT contactID, fullname, Email, PhoneNumber, complain FROM contact";
                                                stmt = conn.prepareStatement(sql);
                                                rs = stmt.executeQuery();

                                                while(rs.next()) {
                                                    int contactID = rs.getInt("contactID");
                                                    String fullname = rs.getString("fullname");
                                                    String email = rs.getString("Email");
                                                    String phoneNumber = rs.getString("PhoneNumber");
                                                    String complain = rs.getString("complain");
                                        %>
                                        <tr>
                                            <td>   <%= contactID %>   </td>
                                            <td>   <%= fullname %>   </td>
                                            <td>   <%= email %>   </td>
                                            <td>   <%= phoneNumber %>   </td>
                                            <td>   <%= complain %>   </td>
                                            <td>
                                                <a href="<%= request.getContextPath() %>/deleteContact?id=<%= contactID %>" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this contact?')">Delete</a>
                                                <a href="<%= request.getContextPath() %>/admin/editContact.jsp?id=<%= contactID %>" class="btn btn-warning" onclick="return ">Edit</a>
                                                
                                            </td>
                                        </tr>
                                        <%
                                                }
                                            } catch (SQLException | ClassNotFoundException e) {
                                                e.printStackTrace();
                                            } finally {
                                                if (rs != null) rs.close();
                                                if (stmt != null) stmt.close();
                                                if (conn != null) conn.close();
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
    </body>

</html>
