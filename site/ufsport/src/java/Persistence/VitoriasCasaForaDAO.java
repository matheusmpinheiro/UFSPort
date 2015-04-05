/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Persistence;

import Model.VitoriasCasaFora;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Gabruel
 */
public class VitoriasCasaForaDAO {
    private Connection connection;
    
    public VitoriasCasaForaDAO() throws DAOException{
        this.connection = ConnectionFactory.getConnection();
    }
    
    public List<VitoriasCasaFora> consulta(String dataIni, String dataFim, int tipo, int pagina) throws SQLException{
        List<VitoriasCasaFora> lista = new ArrayList<VitoriasCasaFora>();
        int offset = pagina*10;
        PreparedStatement statement;
        ResultSet set;
        String SQL = "select b.count as vitorias, nome, pais, esporte "
                + "FROM time, ( "
                + "     select COUNT(1), id_time"+tipo+" "
                + "     from jogo "
                + "     WHERE vencedor=id_time"+tipo+" "
                + "     AND data BETWEEN '"+ dataIni +"' AND '"+ dataFim +"' "
                + "     group by id_time"+tipo+" ) b "
                + "WHERE id_time=id_time"+tipo+" "
                + "order by vitorias DESC, id_time LIMIT 10 OFFSET " + offset;
        System.out.println(SQL);
        statement = connection.prepareStatement(SQL);
        
        set = statement.executeQuery();
        
        while(set.next()){
            VitoriasCasaFora vitoria = new VitoriasCasaFora();
            vitoria.setEsporte(set.getString(4));
            vitoria.setNome(set.getString(2));
            vitoria.setPais(set.getString(3));
            vitoria.setVitorias(set.getInt(1));
            lista.add(vitoria);
        }
        
        return lista;
    }
    
    public int qtdRows(String dataIni, String dataFim, int tipo) throws SQLException{
        PreparedStatement statement;
        ResultSet set;
        String SQL = "select count(*) from ( "
                + "select b.count as vitorias, nome, pais, esporte "
                + "FROM time, ( "
                + "     select COUNT(1), id_time" + tipo + " "
                + "     from jogo "
                + "     WHERE vencedor=id_time" + tipo + " "
                + "     AND data BETWEEN '" + dataIni + "' AND '" + dataFim + "' "
                + "     group by id_time" + tipo + " ) b "
                + "WHERE id_time=id_time" + tipo + " "
                + "order by vitorias DESC ) as f";
System.out.println(SQL);
        statement = connection.prepareStatement(SQL);

        set = statement.executeQuery();
        set.next();
        return set.getInt(1);
    }
}
