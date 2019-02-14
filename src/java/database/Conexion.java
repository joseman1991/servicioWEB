package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Conexion {

    public PreparedStatement consulta;
    public ResultSet datos;
    public Connection connection;

    public void abrirConexion() throws SQLException {
        try {
            String url;
            String usuario = ("postgres");
            String clave = ("postgres");
            String BaseDeDatos = ("sistemabasura");
            String puerto = ("5432");
            String servidor = ("localhost");
            Class.forName("org.postgresql.Driver");
            url = "jdbc:postgresql://" + servidor + ":" + puerto + "/" + BaseDeDatos;
               connection = DriverManager.getConnection(url, usuario, clave);
        } catch (ClassNotFoundException e) {
            System.out.println(e.getMessage());
        }
    }

    public void cerrarConexion() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
            }
        }
    }
}
