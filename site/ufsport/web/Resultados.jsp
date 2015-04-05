<%-- 
    Document   : Resultados
    Created on : 05/06/2014, 18:50:52
    Author     : Gabruel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Model.VitoriasCasaFora" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.css" type="text/css" media="screen">
        <link rel="stylesheet" href="css/responsive.css" type="text/css" media="screen">
        <link rel="stylesheet" href="css/style.css" type="text/css" media="screen">
        <link rel="stylesheet" href="css/touchTouch.css" type="text/css" media="screen">
        <link rel="stylesheet" href="css/kwicks-slider.css" type="text/css" media="screen">
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300' rel='stylesheet' type='text/css'>
        <title>JSP Page</title>
        
        <script type="text/javascript">
            function first(){
                document.getElementById('idNext').value = '1';
                document.getElementById('tabela').submit();
            }
            
            function prev(){
                document.getElementById('idNext').value = <%=request.getAttribute("n2")%>;
                document.getElementById('tabela').submit();
            }
            
            function next(){
                document.getElementById('idNext').value = <%=request.getAttribute("n3")%>;
                document.getElementById('tabela').submit();
            }
            
            function last(){
                document.getElementById('idNext').value = <%=request.getAttribute("n4")%>;
                document.getElementById('tabela').submit();
            }
        </script>
        
    </head>
    <body>
        <section class="container">
            <article id="form">
                <header>
                    <h1>Resultado da busca por vitórias em: <%= request.getParameter("tipo") %></h1>
                </header>
                <form id="tabela" method="Post">
                    <%
                        List<VitoriasCasaFora> vitorias = (List<VitoriasCasaFora>)request.getAttribute("lista");
                        if(vitorias.isEmpty()){
                            %><p>Resultado vazio</p><%
                        } else {
                            %>
                            <input type="hidden" name="dataIni" value="<%= request.getParameter("dataIni")%>">
                            <input type="hidden" name="dataFim" value="<%= request.getParameter("dataFim")%>">
                            <input type="hidden" name="tipo" value="<%= request.getParameter("tipo")%>">
                            <input type="hidden" name="atual" value="<%= request.getParameter("next")%>">
                            <input type="hidden" id="idNext" name="next" value="">
                            <table>
                                <thead>
                                    <th width="100px">Vitorias</th>
                                    <th width="100px">Time</th>
                                    <th width="100px">Pais</th>
                                    <th width="100px">Esporte</th>
                                </thead>
                            <%
                            for(VitoriasCasaFora v : vitorias){
                                out.println("<tr>" + 
                                                "<td>" + v.getVitorias() + "</td>" + 
                                                "<td>" + v.getNome()+ "</td>" + 
                                                "<td>" + v.getPais() + "</td>" + 
                                                "<td>" + v.getEsporte() + "</td>" +
                                            "</tr>");
                            }
                            %></table>
                            
                            <%
                            //int paginaAtual = Integer.parseInt(request.getParameter("next"));
                            //int nLinhas = (int) request.getAttribute("maxRows");
                            //int nPag = ( nLinhas + 9 ) / 10;
                            //boolean hasPrev = paginaAtual != 1;
                            //boolean hasNext = paginaAtual != nPag;
                            %>
                            <div class="buttons-wrapper">
                                
                                <a class="btn btn-1" data-type="submit" onClick="first();">Início</a>
                                <a class="btn btn-1" data-type="submit" onClick="prev();">Anterior</a>
                                <a class="btn btn-1" data-type="submit" onclick="atual();" id="idAtual">Página <%=request.getParameter("next")%></a>
                                <a class="btn btn-1" data-type="submit" onClick="next();">Próxima</a>
                                <a class="btn btn-1" data-type="submit" onClick="last();">Fim</a>
                                
                            <%
                        }
                    %>
                </form>
            </article>
        </section>
    </body>
</html>
