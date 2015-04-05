<%-- 
    Document   : viewPesquisaVitorias
    Created on : 06/06/2014, 00:37:12
    Author     : Gabruel
--%>

<%@page import="java.util.List"%>
<%@page import="Model.VitoriasCasaFora"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt">
    <head>
        <title>UfSport</title>
        <meta charset="utf-8">
        <!--Logo na aba -->
        <link rel="icon" href="http://icons.iconarchive.com/icons/visualpharm/icons8-metro-style/256/Sport-Activities-Running-icon.png" type="image/x-icon">

        <link rel="shortcut icon" href="http://dzyngiri.com/favicon.png" type="image/x-icon" />
        <meta name="description" content="Codester is a free responsive Bootstrap template by Dzyngiri">
        <meta name="keywords" content="free, template, bootstrap, responsive">
        <meta name="author" content="Inbetwin Networks">  
        <link rel="stylesheet" href="css/bootstrap.css" type="text/css" media="screen">
        <link rel="stylesheet" href="css/responsive.css" type="text/css" media="screen">
        <link rel="stylesheet" href="css/style.css" type="text/css" media="screen">
        <link rel="stylesheet" href="css/touchTouch.css" type="text/css" media="screen">
        <link rel="stylesheet" href="css/kwicks-slider.css" type="text/css" media="screen">
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300' rel='stylesheet' type='text/css'>
        <script type="text/javascript" src="js/jquery.js"></script>
        <script type="text/javascript" src="js/superfish.js"></script>
        <script type="text/javascript" src="js/jquery.flexslider-min.js"></script>
        <script type="text/javascript" src="js/jquery.kwicks-1.5.1.js"></script>
        <script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
        <script type="text/javascript" src="js/jquery.cookie.js"></script>    
        <script type="text/javascript" src="js/touchTouch.jquery.js"></script>
        <script type="text/javascript">if ($(window).width() > 1024) {
                document.write("<" + "script src='js/jquery.preloader.js'></" + "script>");
            }</script>
        <script src="js/forms.js"></script>
        
        <script>

            jQuery(window).load(function() {
            $x = $(window).width();
                    if ($x > 1024)
            {
            jQuery("#content .row").preloader(); }

            jQuery('.magnifier').touchTouch();       } </script>
        
        <!--[if lt IE 8]>
                <div style='text-align:center'><a href="http://www.microsoft.com/windows/internet-explorer/default.aspx?ocid=ie6_countdown_bannercode"><img src="http://www.theie6countdown.com/img/upgrade.jpg"border="0"alt=""/></a></div>  
        <![endif]-->
        <!--[if (gt IE 9)|!(IE)]><!-->
        <!--<![endif]-->
        <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <link rel="stylesheet" href="css/docs.css" type="text/css" media="screen">
    <link rel="stylesheet" href="css/ie.css" type="text/css" media="screen">
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400' rel='stylesheet' type='text/css'>
  <![endif]-->
        <script type="text/javascript">
            
            function first(){
                document.getElementById('idNext').value = '1';
                document.getElementById('idTabela').submit();
            }
            
            function prev(){
                document.getElementById('idNext').value = <%=request.getAttribute("n2")%>;
                document.getElementById('idTabela').submit();
            }
            
            function next(){
                document.getElementById('idNext').value = <%=request.getAttribute("n3")%>;
                document.getElementById('idTabela').submit();
            }
            
            function last(){
                document.getElementById('idNext').value = <%=request.getAttribute("n4")%>;
                document.getElementById('idTabela').submit();
            }
        </script>
    </head>

    <body>

        <!-- header start -->
        <header>
            <div class="container clearfix">
                <div class="row">
                    <div class="span12">
                        <div class="navbar navbar_">
                            <div class="container">
                                <h1 class="brand brand_"><a href="index.jsp"><img alt="" src="img/logo.png"> </a></h1>
                                <a class="btn btn-navbar btn-navbar_" data-toggle="collapse" data-target=".nav-collapse_">Menu <span class="icon-bar"></span> </a>
                                <div class="nav-collapse nav-collapse_  collapse">
                                    <ul class="nav sf-menu">
                                        <li><a href="index.jsp">Home</a></li>
                                        <li><a href="Noticia.html">Notícias</a></li>
                                        <li class="sub-menu active"><a>Pesquisas</a>
                                            <ul>
                                                <li><a href="pesquisaJogador.html">Jogadores</a></li>
                                                <li><a href="pesquisaTimes.jsp">Times</a></li>
                                                <li><a href="pesquisaVitorias.html">Vitoriosos em casa/fora</a></li>
                                                <li><a href="pesquisaVitoriasPais.jsp">Vitoriosos por país</a></li>
                                                <li><a href="pesquisaVitoriasCamp.jsp">Vitoriosos por campeonato</a></li>
                                                
                                            </ul>
                                        </li>
                                        <li><a href="Contato.html">Contato</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <div class="bg-content">
            <div class="container">
                <div class="separador1">
                    <br>
                </div>
                <div id="campos-pesquisa">
                <h2><b>Vitórias em casa ou fora</b></h2>

                <p>Escolha um período e o tipo de busca desejado para saber a quantidade de vitórias de cada
                    time nesse período. As datas são opcionais, se deseja saber a quantidade de vitórias de todos os tempos
                    basta deixá-las em branco!</p>

                

                    <form id="contact-form" method="post" action="PesquisaVitoriasCasaFora">
                        <fieldset>
                            <!--
                            <div>
                                <label class="name">
                                    <input type="text" value="Nome do Time">
                                    <br>
                                    <span class="error">*Nome inválido.</span> <span class="empty">*Este campo é obrigatório.</span> </label>
                            </div>
                            -->
                            <table>
                                <tr>
                                    <td width="25%">Data Inicial:</td>
                                    <td><input type="date" name="dataIni"></td>
                                </tr>
                                <tr>
                                    <td>Data final:</td>
                                    <td><input type="date" name="dataFim"></td>
                                </tr>
                                <tr>
                                    <td>Vitórias em:</td> 
                                    <td width="100px"><select name="tipo">
                                            <option value="casa">Casa</option>
                                            <option value="fora">Fora</option>
                                        </select></td>
                                </tr>
                            </table>
                            <!--<div>
                                <input type="submit" value="Buscar"><input type="reset" value="Limpar">
                            </div>-->
                            <br>
                            <div class="buttons-wrapper"> 
                                <input type="hidden" name="atual" value="0">
                                <input type="hidden" name="next" value="1">
                                <a class="btn btn-1" data-type="reset" onClick="document.getElementById('contact-form').reset()">Limpar</a> 
                                <a class="btn btn-1" data-type="submit" onClick="document.getElementById('contact-form').submit()">Buscar</a>
                            </div>
                        </fieldset>
                    </form>
                </div>   

                <div class="tabela">
                    <div align="center">
                    <form id="idTabela" method="Post">
                        <%
                            List<VitoriasCasaFora> vitorias = (List<VitoriasCasaFora>)request.getAttribute("lista");
                            if(vitorias.isEmpty()){
                                %><h5>Ooops... :'(</h5>
                                    <p>Sua consulta não retorno nenhum resultado... Tente outros parâmetros!<p><%
                            } else {
                                %>
                                <input type="hidden" name="dataIni" value="<%= request.getParameter("dataIni")%>">
                                <input type="hidden" name="dataFim" value="<%= request.getParameter("dataFim")%>">
                                <input type="hidden" name="tipo" value="<%= request.getParameter("tipo")%>">
                                <input type="hidden" name="atual" value="<%= request.getParameter("next")%>">
                                <input type="hidden" id="idNext" name="next" value="">
                                <table class="zebra">
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
                                <br>
                                <div class="buttons-wrapper" align="center">
                                
                                    <a class="btn btn-1" data-type="submit" onClick="first();">Início</a>
                                    <a class="btn btn-1" data-type="submit" onClick="prev();">Anterior</a>
                                    <a class="btn btn-1" data-type="submit" onclick="atual();" id="idAtual">Página <%=request.getParameter("next")%></a>
                                    <a class="btn btn-1" data-type="submit" onClick="next();">Próxima</a>
                                    <a class="btn btn-1" data-type="submit" onClick="last();">Fim</a>
                                </div>
                                <%
                            }
                        %>
                    </form>
                    </div>
                </div>
            </div>
            <div class="separador1">
                <br>
            </div>



            <!-- footer -->
            <footer>
                <div class="container clearfix">
                    <ul class="list-social pull-right">
                        <li><a class="icon-1" href="https://www.facebook.com/matheus.m.pinheiro.7?ref=tn_tnmn"></a></li>
                        <li><a class="icon-3" href="#"></a></li>
                    </ul>
                    <div class="privacy pull-left">&copy;UFSport 2014 | Desenvolvimento WEB | <a href="#" target="_blank">Contato</a> | Desenvolvido em parceria com <a href="http://www.sorocaba.ufscar.br" target="_blank">UFSCar</a></div>
                </div>
            </footer>
            <script type="text/javascript" src="js/bootstrap.js"></script>
        </div>
    </body>
</html>
