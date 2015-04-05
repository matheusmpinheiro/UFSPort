/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package libs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

/**
 *
 * @author Gabruel
 */
public class TesteBD {
    private Connection conn;
    private Statement stmt;
    
    public TesteBD(){
        try{
            Class.forName("org.postgresql.Driver").newInstance();
            String conexao="jdbc:postgresql://localhost/EsportesNew";
            String usuario="postgres", senha="postgresql";
            conn = DriverManager.getConnection(conexao, usuario, senha);
            stmt = conn.createStatement();
            
            System.out.println("Conexão OK");
            
            conn.close();
        } catch(Exception e){
            e.printStackTrace();
            System.out.println("Erro");
        }
    }
    
    public static void main(String args[]){
        TesteBD t = new TesteBD();
    }
}
