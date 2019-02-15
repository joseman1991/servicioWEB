<%@page import="java.sql.SQLException"%><%@page import="database.Conexion"%><%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String user = request.getParameter("user").toString();
    String clave = request.getParameter("clave").toString();
    Conexion con = new Conexion();
    try {
        con.abrirConexion();
        con.consulta = con.connection.prepareStatement("select nombres, apellidos,idperfil from usuarios where nombreusuario=? and clave=?");
        con.consulta.setString(1, user);
        con.consulta.setString(2, clave);
        con.datos = con.consulta.executeQuery();
        if (con.datos.next()) {
            out.write(String.format("ok,%s,%s,%s", con.datos.getString(1), con.datos.getString(2),con.datos.getString(3)));
        } else {
            out.write(String.format("error,No data"));
        }
    } catch (SQLException e) {
        out.write(e.getMessage());
    } finally {
        con.cerrarConexion();
    }
%>