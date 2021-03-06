 

<%@page import="database.Estados"%>
<%@page import="java.sql.SQLException"%>
<%@page import="database.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reportes </title>
        <link rel="stylesheet" href="assets/style.css">
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
        <script type="text/javascript" src="assets/jQuery/jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="assets/bootstrap/js/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="header">     
            <h2>Reporte 
                <%
                    int op = Integer.parseInt(request.getParameter("op"));
                    Estados est= new Estados();
                    try {
                            est.obtenerDatos();
                        } catch (Exception e) {
                            out.write(e.getMessage());
                        }
                    switch (op) {
                        case 1:
                            out.write(" diario");
                            break;

                        case 2:
                            out.write(" semanal");
                            break;

                        case 3:
                            out.write(" mensual");
                            break;
                    }
                %>
            </h2>
        </div>
        <div class="row">
            <div class="col-3 col-s-3 menu">
                <ul>
                    <li><a class="text-white" href="datos.jsp?op=1">Diario (<% out.write(est.diario+"");%>) </a></li>
                    <li><a class="text-white" href="datos.jsp?op=2">Semanal (<% out.write(est.semanal+"");%>)</a></li>
                    <li><a class="text-white" href="datos.jsp?op=3">Mensual (<% out.write(est.mensual+"");%>)</a></li>
                </ul>
            </div>




            <div class="col-6 col-s-9">
                <h3>No hay datos</h3>
            </div>
            <div class="col-3 col-s-12">
                <div class="aside">
                    <h2>Reporte de Eventos del sistema</h2>
                    <p></p>
                </div>
            </div>
        </div>
        <div class="footer">
            <p>Sistema de recolección de desechos flotantes</p>
        </div>
    </body>
</html>
