/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Persistence;

import Model.Esporte;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Gabruel
 */
public class EsporteDAO {
    private Connection connection;
    
    public EsporteDAO() throws DAOException{
        this.connection = ConnectionFactory.getConnection();
    }
    
    public List<Esporte> listar() throws SQLException{
        List<Esporte> lista = new ArrayList<Esporte>();
        String SQL = "SELECT nome FROM esporte order by nome";
        PreparedStatement statement;
        ResultSet set;
        
        System.out.println(SQL);
        statement = connection.prepareStatement(SQL);
        
        set = statement.executeQuery();
        
        while(set.next()){
            Esporte p = new Esporte();
            p.setNome(set.getString("nome"));
            lista.add(p);
        }
        
        return lista;
    }
}
