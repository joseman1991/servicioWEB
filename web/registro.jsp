<%@page import="java.sql.SQLException"%><%@page import="database.Conexion"%><%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String user = request.getParameter("user").toString();
    String clave = request.getParameter("clave").toString();
    String nombres = request.getParameter("nombres").toString();
    String apellidos = request.getParameter("apellidos").toString();
    int idperfil = Integer.parseInt(request.getParameter("idperfil").toString());

    Conexion con = new Conexion();
    try {
        con.abrirConexion();
        con.consulta = con.connection.prepareStatement("insert into usuarios values(default,?,?,?,?,?)");
        int i = 1;
        con.consulta.setString(i++, user);
        con.consulta.setString(i++, clave);
        con.consulta.setString(i++, nombres);
        con.consulta.setString(i++, apellidos);
        con.consulta.setInt(i++, idperfil);
        int res = con.consulta.executeUpdate();
        if (res > 0) {
            out.write(String.format("ok,Usuario registrado"));
        } else {
            out.write(String.format("error,Usuario no registrado"));
        }
    } catch (SQLException e) {
        out.write(e.getMessage());
    } finally {
        con.cerrarConexion();
    }
%>