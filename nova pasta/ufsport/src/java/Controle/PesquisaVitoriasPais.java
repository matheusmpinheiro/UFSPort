    /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Controle;

import Model.VitoriasPais;
import Persistence.DAOException;
import Persistence.VitoriasPaisDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
public class PesquisaVitoriasPais extends HttpServlet {

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
            out.println("<title>Servlet PesquisaVitoriasCasaFora</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PesquisaVitoriasCasaFora at " + request.getContextPath() + "</h1>");
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
        String tipo = request.getParameter("tipo");
        int maxRows;
        int nPag;
        int n1, n2, n3, n4;
        
        int pagAtual = Integer.parseInt(request.getParameter("atual"));
        int pagNext = Integer.parseInt(request.getParameter("next"));
        
        try {
            VitoriasPaisDAO dao = new VitoriasPaisDAO();
            maxRows = dao.qtdRows(esporte, tipo);
            nPag = ( maxRows + 9 ) / 10;
            List<VitoriasPais> lista;
            
            lista = dao.consulta(esporte, tipo, pagNext-1);
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
            
            dispatcher = request.getRequestDispatcher("/viewPesquisaPais.jsp");
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
