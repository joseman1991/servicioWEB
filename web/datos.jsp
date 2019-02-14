 

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
                    <li><a class="text-white" href="datos.jsp?op=1">Diario</a></li>
                    <li><a class="text-white" href="datos.jsp?op=2">Semanal</a></li>
                    <li><a class="text-white" href="datos.jsp?op=3">Mensual</a></li>
                </ul>
            </div>




            <div class="col-6 col-s-9">
                <div class="table-responsive">
                    <table border="1" class="table table-hover">
                        <thead>
                            <tr>
                                <th>Nº</th>
                                <th>Estado</th>
                                <th>Hora</th>
                                <th>Fecha</th>
                            </tr>
                        </thead>
                        <tbody>



                            <%
                                Conexion con = new Conexion();
                                try {
                                    con.abrirConexion();
                                    con.consulta = con.connection.prepareCall("{call obtenerRegistros(?)}");
                                    int j = 0;
                                    con.consulta.setInt(1, op);
                                    con.datos = con.consulta.executeQuery();
                                    while (con.datos.next()) {
                                        out.write("<tr>");
                                        j++;
                                        out.write("<td>");
                                        out.write(j + "");
                                        out.write("</td>");
                                        out.write("<td>");
                                        out.write(con.datos.getString(1));
                                        out.write("</td>");
                                        out.write("<td>");
                                        out.write(con.datos.getString(2));
                                        out.write("</td>");
                                        out.write("<td>");
                                        out.write(con.datos.getString(3));
                                        out.write("</td>");
                                        out.write("</tr>");
                                    }
                                } catch (SQLException e) {
                                    out.write(e.getMessage());
                                } finally {
                                    con.cerrarConexion();
                                }
                            %>  
                        </tbody>
                    </table>
                </div>
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
