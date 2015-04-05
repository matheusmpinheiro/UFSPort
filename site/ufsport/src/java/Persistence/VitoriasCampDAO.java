/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Persistence;

import Model.VitoriasCamp;
import Model.VitoriasPais;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Gabruel
 */
public class VitoriasCampDAO {
    private Connection connection;
    
    public VitoriasCampDAO() throws DAOException{
        this.connection = ConnectionFactory.getConnection();
    }
    
    public List<VitoriasCamp> consulta(String esporte, String tipo, int pagina) throws SQLException{
        List<VitoriasCamp> lista = new ArrayList<VitoriasCamp>();
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
        String SQL = "select t1.nome, nomeTeam, vitorias, esporte "
                    + "from vitorias_campeonatos t1, ( "
                    +         "select "+tipo+"(vitorias) as "+aux1+", id_campeonato "
                    +         "from vitorias_campeonatos "
                    +         "group by id_campeonato) t2 "
                    + "where t2."+aux1+" = t1.vitorias "
                    + "AND esporte like '%"+esporte+"%' "
                    + "AND t1.id_campeonato = t2.id_campeonato "
                    + "order by vitorias "+aux2+", nometeam, nome LIMIT 10 OFFSET " + offset;
        
        statement = connection.prepareStatement(SQL);
        
        set = statement.executeQuery();
        
        while(set.next()){
            VitoriasCamp vitoria = new VitoriasCamp();
            vitoria.setEsporte(set.getString(4));
            vitoria.setNome(set.getString(1));
            vitoria.setNometeam(set.getString(2));
            vitoria.setVitorias(set.getInt(3));
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
                + "select t1.nome, nomeTeam, vitorias, esporte "
                + "from vitorias_campeonatos t1, ( "
                +         "select "+tipo+"(vitorias) as "+aux1+", id_campeonato "
                +         "from vitorias_campeonatos "
                +         "group by id_campeonato) t2 "
                + "where t2."+aux1+" = t1.vitorias "
                + "AND esporte like '%"+esporte+"%' "
                + "AND t1.id_campeonato = t2.id_campeonato "
                + "order by vitorias ) as f";

        statement = connection.prepareStatement(SQL);

        set = statement.executeQuery();
        set.next();
        return set.getInt(1);
    }
}
