/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Persistence;

import Model.Pais;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Gabruel
 */
public class ProcedureDAO {
    private Connection connection;
    
    public ProcedureDAO() throws DAOException{
        this.connection = ConnectionFactory.getConnection();
    }
    
    public String detalhes(int id) throws SQLException{
        String SQL = "{ ? = call dadostime( ? ) }";
        CallableStatement statement;
        
        statement = connection.prepareCall(SQL);
        statement.registerOutParameter(1, Types.VARCHAR);
        statement.setInt(2, id);
        statement.execute();
        
        //set = statement.executeQuery();
        
        String retorno = statement.getString(1);
        System.out.println(retorno);
        return retorno;
    }
    
    public List<Float> aproveitamento(int id) throws SQLException{
        String SQL = "{ ? = call aproveitamento( ?, ?, ? ) }";
        CallableStatement statement;
        List<Float> list = new ArrayList<Float>();
        
        statement = connection.prepareCall(SQL);
        statement.registerOutParameter(1, Types.REAL);
        statement.registerOutParameter(2, Types.REAL);
        statement.registerOutParameter(3, Types.REAL);
        statement.setInt(4, id);
        statement.execute();
        
        //set = statement.executeQuery();
        list.add(statement.getFloat(1));
        list.add(statement.getFloat(2));
        list.add(statement.getFloat(3));
        Float retorno1 = statement.getFloat(1);
        Float retorno2 = statement.getFloat(2);
        Float retorno3 = statement.getFloat(3);
        String retorno = retorno1 + " " + retorno2 + " " + retorno3;
        System.out.println(retorno);
        return list;
    }
}
