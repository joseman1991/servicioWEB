

<%@page import="java.sql.SQLException"%>
<%@page import="database.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <%
            String estado = request.getParameter("estado").toString();
            if (estado != null) {
                Conexion con = new Conexion();
                try {
                    con.abrirConexion();
                    con.consulta = con.connection.prepareStatement("insert into eventos(idestado) values (?)");
                    con.consulta.setInt(1, Integer.parseInt(estado));
                    con.consulta.executeUpdate();
                    switch (estado) {
                        case "1":
                            out.write("encendido");
                            break;

                        case "2":
                            out.write("apagado");
                            break;

                        case "3":
                            out.write("vaciado");
                            break;

                    }
                } catch (SQLException e) {
                    out.write(e.getMessage());
                } finally {
                    con.cerrarConexion();
                }

            }
        %>


    </body>
</html>
