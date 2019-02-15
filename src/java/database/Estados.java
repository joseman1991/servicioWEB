package database;

import java.sql.SQLException;

public class Estados extends Conexion {

    public int diario;
    public int semanal;
    public int mensual;

    public void obtenerDatos() throws SQLException {
        abrirConexion();
        consulta = connection.prepareCall("{call obtenerConteo(1)}");
        datos = consulta.executeQuery();
        if (datos.next()) {
            diario = datos.getInt(1);
        }
        consulta = connection.prepareCall("{call obtenerConteo(2)}");
        datos = consulta.executeQuery();
        if (datos.next()) {
            semanal = datos.getInt(1);
        }
        consulta = connection.prepareCall("{call obtenerConteo(3)}");
        datos = consulta.executeQuery();
        if (datos.next()) {
            mensual = datos.getInt(1);
        }
        cerrarConexion();

    }

}
