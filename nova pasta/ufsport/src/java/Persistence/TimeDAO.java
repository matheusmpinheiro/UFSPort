/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Persistence;

import Model.Time;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Gabruel
 */
public class TimeDAO {
    private Connection connection;
    
    public TimeDAO() throws DAOException{
        this.connection = ConnectionFactory.getConnection();
    }
    
    public List<Time> consulta(String nome, String esporte, String pais, int pagina) throws SQLException{
        List<Time> lista = new ArrayList<Time>();
        int offset = pagina*10;
        
        PreparedStatement statement;
        ResultSet set;
        String SQL = "SELECT nome, esporte, estadio, pais " +
                    "FROM time " +
                    "WHERE nome LIKE '%"+nome+"%' " +
                    "AND esporte LIKE '%"+esporte+"%' " +
                    "AND pais LIKE '%"+pais+"%' " +
                    "ORDER BY nome, id_time LIMIT 10 OFFSET " + offset;
        System.out.println(SQL);
        statement = connection.prepareStatement(SQL);
        
        set = statement.executeQuery();
        
        while(set.next()){
            Time t = new Time();
            t.setEsporte(set.getString(2));
            t.setNome(set.getString(1));
            t.setPais(set.getString(4));
            if (set.getString(3) == null)
                t.setEstadio("-");
            else
                t.setEstadio(set.getString(3));
            lista.add(t);
        }
        
        return lista;
    }
    
    public int qtdRows(String nome, String esporte, String pais) throws SQLException{
        PreparedStatement statement;
        ResultSet set;
        
        String SQL = "select count(*) from ( "
                + "SELECT nome, esporte, estadio, pais " +
                "FROM time " +
                "WHERE nome LIKE '%"+nome+"%' " +
                "AND esporte LIKE '%"+esporte+"%' " +
                "AND pais LIKE '%"+pais+"%' " +
                "ORDER BY nome, id_time ) as f";

        statement = connection.prepareStatement(SQL);

        set = statement.executeQuery();
        set.next();
        return set.getInt(1);
    }
    
    public List<Integer> listaIds() throws SQLException{
        List<Integer> lista = new ArrayList<Integer>();
        PreparedStatement statement;
        ResultSet set;
        
        String SQL = "select id_time from time";
        
        statement = connection.prepareStatement(SQL);
        
        set = statement.executeQuery();
        
        while(set.next()){
            lista.add(set.getInt(1));
        }
        return lista;
    }
    
    public int maxRows() throws SQLException{
        PreparedStatement statement;
        ResultSet set;
        
        String SQL = "select count(id_time) from time";

        statement = connection.prepareStatement(SQL);

        set = statement.executeQuery();
        set.next();
        return set.getInt(1);
    }
}
