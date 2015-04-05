<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="pt">
    <head>
        <title>UFSport</title>
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
        <script type="text/javascript">
        
        function teste(n){
            if (n === 1)
                window.location.href = "pesquisaTimes.jsp";
            
            if (n === 2)
                window.location.href = "pesquisaJogador.html";
            
            if (n === 3)
                window.location.href = "pesquisaVitorias.html";
            
            if (n === 4)
                window.location.href = "pesquisaVitoriasPais.jsp";
            
            if (n === 5)
                window.location.href = "pesquisaVitoriasCamp.jsp";
        }
        </script>
        <script type="text/javascript">if ($(window).width() > 1024) {
                document.write("<" + "script src='js/jquery.preloader.js'></" + "script>");
            }</script>
        <script>

            jQuery(window).load(function() {
                $x = $(window).width();
                if ($x > 1024)
                {
                    jQuery("#content .row").preloader();
                }

                jQuery('.magnifier').touchTouch();
            }
        </script>


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
        function time(){
                $.ajax({
                    type: 'POST',
                    url: 'TimeDaVez',
                    success: function(data) {
                        $("#timedavez").append(data);
                    }
                });
            }
        </script>
    </head>

    <body onload="time()">

        <!-- header start -->
        <header>
            <div class="container clearfix">
                <div class="row" >
                    <div class="span12">
                        <div class="navbar navbar_">
                            <div class="container">
                                <h1 class="brand brand_"><a href="index.jsp"><img alt="" src="img/logo.png"> </a></h1>
                                <a class="btn btn-navbar btn-navbar_" data-toggle="collapse" data-target=".nav-collapse_">Menu <span class="icon-bar"></span> </a>
                                <div class="nav-collapse nav-collapse_  collapse">
                                    <ul class="nav sf-menu">
                                        <li class="active"><a href="index.jsp">Home</a></li>
                                        <li><a href="Noticia.html">Notícias</a></li>
                                        <li class="sub-menu"><a>Pesquisas</a>
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
        <div class="bg-content"  >
            <div class="container">
                <div class="row">
                    <div class="span12"> 
                    <br><br>

                        <!-- slider -->
                        <div class="flexslider">
                            <ul class="slides">
                                <li><a href="" onclick="teste(1);"> <img src="img/slide-1.jpg" alt="" ></a> </li>
                                <li><a href="" onclick="teste(2);"> <img src="img/slide-2.jpg" alt="" ></a> </li>
                                <li><a href="" onclick="teste(3);"> <img src="img/slide-3.jpg" alt="" ></a> </li>
                                <li><a href="" onclick="teste(4);"> <img src="img/slide-4.jpg" alt="" ></a> </li>
                                <li><a href="" onclick="teste(5);"> <img src="img/slide-6.jpg" alt="" ></a> </li>
                            </ul>
                        </div>
                        <span id="responsiveFlag"></span>  
                    </div>
                </div>

            </div>

            <div class="container" id="timedavez">
                <h2><b>Time da vez</b></h2>
            </div>

            <!-- footer -->
            <footer>
                <div class="container clearfix">
                    <ul class="list-social pull-right">
                        <li><a class="icon-1" href="https://www.facebook.com/ufsport"></a></li>
                    </ul>
                    <div class="privacy pull-left">&copy;UFSport 2014 | Desenvolvimento WEB | <a href="#" target="_blank">Contato</a> | Desenvolvido em parceria com <a href="http://www.sorocaba.ufscar.br" target="_blank">UFSCar</a></div>
                </div>
            </footer>
            <script type="text/javascript" src="js/bootstrap.js"></script>
        </div>
    </body>
</html>