/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Gabruel
 */
public class ConnectionFactory {

    public static void closeConnection(Connection conn, PreparedStatement ps, ResultSet rs)
            throws DAOException {
        close(conn, ps, rs);
    }

    public static void closeConnection(Connection conn, PreparedStatement ps)
            throws DAOException {
        close(conn, ps, null);
    }

    public static void closeConnection(Connection conn)
            throws DAOException {
        close(conn, null, null);
    }

    private static void close(Connection conn, PreparedStatement ps, ResultSet rs)
            throws DAOException {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException exception) {
            throw new DAOException(exception.getMessage(), exception.fillInStackTrace());
        }
    }

    public static Connection getConnection() throws DAOException {
        try {
            Class.forName("org.postgresql.Driver").newInstance();
            String conexao = "jdbc:postgresql://localhost/EsportesNew";
            String usuario = "postgres", senha = "postgresql";
            Connection conn = DriverManager.getConnection(conexao, usuario, senha);
            return conn;

        } catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException exception) {
            System.out.println("Erro de conexão ao banco!");
            throw new DAOException(exception.getMessage(), exception.fillInStackTrace());
        }
    }
}
