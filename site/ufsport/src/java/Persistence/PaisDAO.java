/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Persistence;

import Model.Pais;
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
public class PaisDAO {
    private Connection connection;
    
    public PaisDAO() throws DAOException{
        this.connection = ConnectionFactory.getConnection();
    }
    
    public List<Pais> listar() throws SQLException{
        List<Pais> lista = new ArrayList<Pais>();
        String SQL = "SELECT nome, sigla2letras FROM pais order by nome";
        PreparedStatement statement;
        ResultSet set;
        
        System.out.println(SQL);
        statement = connection.prepareStatement(SQL);
        
        set = statement.executeQuery();
        
        while(set.next()){
            Pais p = new Pais();
            p.setNome(set.getString("nome"));
            p.setSigla(set.getString("sigla2letras"));
            
            lista.add(p);
        }
        
        return lista;
    }
}
