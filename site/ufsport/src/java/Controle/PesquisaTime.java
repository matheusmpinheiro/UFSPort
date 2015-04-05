/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Controle;

import Model.Time;
import Persistence.DAOException;
import Persistence.TimeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Gabruel
 */
public class PesquisaTime extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PesquisaTime</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PesquisaTime at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter retorno = response.getWriter();
        String esporte = request.getParameter("esporte");
        String pais = request.getParameter("pais");
        String nome = request.getParameter("nome");
        int maxRows;
        int nPag;
        int n1, n2, n3, n4;
        
        int pagAtual = Integer.parseInt(request.getParameter("atual"));
        int pagNext = Integer.parseInt(request.getParameter("next"));
        
        try {
            TimeDAO dao = new TimeDAO();
            maxRows = dao.qtdRows(nome, esporte, pais);
            nPag = ( maxRows + 9 ) / 10;
            List<Time> lista;
            
            lista = dao.consulta(nome, esporte, pais, pagNext-1);
            boolean hasPrev = pagNext != 1;
            boolean hasNext = pagNext != nPag;
            if (hasPrev){
                n2 = pagNext-1;
            } else {
                n2 = 1;
            }
            
            if (hasNext){
                n3 = pagNext+1;
            } else {
                n3 = nPag;
            }
            
            n4 = nPag;
            
            request.setAttribute("lista", lista);
            request.setAttribute("n2", n2);
            request.setAttribute("n3", n3);
            request.setAttribute("n4", n4);
            
            
            RequestDispatcher dispatcher = null;
            
            dispatcher = request.getRequestDispatcher("/viewPesquisaTime.jsp");
            dispatcher.forward(request, response);
        } catch (DAOException | SQLException exception){
            Logger.getLogger(PesquisaVitoriasCasaFora.class.getName()).log(Level.SEVERE, null, exception);
            throw new ServletException(exception.getMessage());
        } 
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
