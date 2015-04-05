/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Persistence;

import Model.Jogador;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Gabruel
 */
public class JogadorDAO {
    private Connection connection;
    
    public JogadorDAO() throws DAOException{
        this.connection = ConnectionFactory.getConnection();
    }
    
    public List<Jogador> consulta(String nome, String sobrenome, String apelido, String dNasc, 
            String ap, String dAp, String altura, String peso, int pagina) throws SQLException{
        List<Jogador> lista = new ArrayList<Jogador>();
        int offset = pagina*10;

        PreparedStatement statement;
        ResultSet set;
        String SQL = "SELECT nome, sobrenome, apelido, datanasc_dia, datanasc_mes, datanasc_ano, aposentado, aposenta_data, altura, peso "
                      +  "FROM jogador "
                      +  "WHERE nome LIKE '%"+nome+"%' "
                      +  "AND sobrenome LIKE '%"+sobrenome+"%' "
                      +  "AND apelido LIKE '%"+apelido+"%' ";
        
        if (!"".equals(dNasc)){
            String data[];
            data = dNasc.split("-");
            SQL += "AND datanasc_dia = "+data[2]+" "
                    +  "AND datanasc_mes = "+data[1]+" "
                    +  "AND datanasc_ano = "+data[0]+" ";
        }
        
        if ("on".equals(ap)){
            SQL += "AND aposentado = 1 ";
            if (!"".equals(dAp)){
                SQL += "AND aposenta_data= "+dAp+" ";
            }
        }
        
        if (!"".equals(altura))
            SQL += "AND altura= "+altura+" ";
        
        if (!"".equals(peso))
            SQL += "AND peso="+peso+" ";
            
        SQL += "ORDER BY nome LIMIT 10 OFFSET "+offset;
        
        System.out.println(SQL);
        statement = connection.prepareStatement(SQL);
        
        set = statement.executeQuery();
        
        while(set.next()){
            Jogador j = new Jogador();
            j.setNome(set.getString(1));
            j.setSobrenome(set.getString(2));
            j.setApelido(set.getString(3));
            j.setDia(set.getString(4));
            j.setMes(set.getString(5));
            j.setAno(set.getString(6));
            if (set.getInt(7) == 1){
                j.setAposentado(true);
                j.setDataAp(set.getString(8));
            } else {
                j.setAposentado(false);
                j.setDataAp("-");
            }
            j.setAltura(set.getString(9));
            j.setPeso(set.getString(10));
            
            lista.add(j);
        }
        
        return lista;
    }
    
    public int qtdRows(String nome, String sobrenome, String apelido, String dNasc, 
            String ap, String dAp, String altura, String peso) throws SQLException{
        PreparedStatement statement;
        ResultSet set;
        
        String SQL = "select count(*) from ( ";
        
        SQL += "SELECT nome, sobrenome, apelido, datanasc_dia, datanasc_mes, datanasc_ano, aposentado, aposenta_data, altura, peso "
                + "FROM jogador "
                + "WHERE nome LIKE '%" + nome + "%' "
                + "AND sobrenome LIKE '%" + sobrenome + "%' "
                + "AND apelido LIKE '%" + apelido + "%' ";

        if (!"".equals(dNasc)) {
            String data[];
            data = dNasc.split("-");
            SQL += "AND datanasc_dia = " + data[2] + " "
                    + "AND datanasc_mes = " + data[1] + " "
                    + "AND datanasc_ano = " + data[0] + " ";
        }

        if ("on".equals(ap)) {
            SQL += "AND aposentado= 1 ";
            if (!"".equals(dAp)) {
                SQL += "AND aposenta_data= " + dAp + " ";
            }
        }

        if (!"".equals(altura)) {
            SQL += "AND altura= " + altura + " ";
        }

        if (!"".equals(peso)) {
            SQL += "AND peso=" + peso + " ";
        }

        SQL += "ORDER BY nome ";
                
        
        SQL += ") as f";

        statement = connection.prepareStatement(SQL);

        set = statement.executeQuery();
        set.next();
        return set.getInt(1);
    }
}
