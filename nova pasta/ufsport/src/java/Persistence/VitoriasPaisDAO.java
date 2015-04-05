/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Persistence;

import Model.VitoriasCasaFora;
import Model.VitoriasPais;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Gabruel
 */
public class VitoriasPaisDAO {
    private Connection connection;
    
    public VitoriasPaisDAO() throws DAOException{
        this.connection = ConnectionFactory.getConnection();
    }
    
    public List<VitoriasPais> consulta(String esporte, String tipo, int pagina) throws SQLException{
        List<VitoriasPais> lista = new ArrayList<VitoriasPais>();
        int offset = pagina*10;
        String aux1, aux2;
        if (tipo.equals("max")){
            aux1 = "maximo";
            aux2 = "DESC";
        } else {
            aux1 = "minimo";
            aux2 = "";
        }
        PreparedStatement statement;
        ResultSet set;
        String SQL = "select vitorias, nome, t1.pais, t1.esporte "
                    + "from times_vitorias t1, ( "
                    + 	"select "+tipo+"(vitorias) as maximo, pais, esporte "
                    + 	"from times_vitorias "
                    + 	"where esporte like '%"+esporte+"%' "
                    + 	"group by pais, esporte) t2 "
                    + "where t2."+aux1+" = t1.vitorias and t2.pais=t1.pais "
                    + "order by vitorias "+aux2+" LIMIT 10 OFFSET " + offset;
        
        statement = connection.prepareStatement(SQL);
        
        set = statement.executeQuery();
        
        while(set.next()){
            VitoriasPais vitoria = new VitoriasPais();
            vitoria.setEsporte(set.getString(4));
            vitoria.setNome(set.getString(2));
            vitoria.setPais(set.getString(3));
            vitoria.setVitorias(set.getInt(1));
            lista.add(vitoria);
        }
        
        return lista;
    }
    
    public int qtdRows(String esporte, String tipo) throws SQLException{
        PreparedStatement statement;
        ResultSet set;
        String aux1;
        if (tipo.equals("max")){
            aux1 = "maximo";
        } else {
            aux1 = "minimo";
        }
        String SQL = "select count(*) from ( "
                + "select vitorias, nome, t1.pais, t1.esporte "
                + "from times_vitorias t1, ( "
                + 	"select "+tipo+"(vitorias) as maximo, pais, esporte "
                + 	"from times_vitorias "
                + 	"where esporte like '%"+esporte+"%' "
                + 	"group by pais, esporte) t2 "
                + "where t2."+aux1+" = t1.vitorias and t2.pais=t1.pais "
                + "order by vitorias ) as f";

        statement = connection.prepareStatement(SQL);

        set = statement.executeQuery();
        set.next();
        return set.getInt(1);
    }
}
