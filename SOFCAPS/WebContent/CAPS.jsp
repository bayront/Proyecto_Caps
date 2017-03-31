<%@page import="java.sql.ResultSet"%>
<%@page import="Datos.DT_Rol"%>
<%@taglib prefix="msg" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 0);
	response.setDateHeader("Expires", -1);
%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="grupo CAPS">
    <title>CAPS PONELOYA</title>
    <%
	HttpSession hts = request.getSession(false);
	hts.removeAttribute("login");
	hts.invalidate();
	%>
    <!-- Bootstrap Core CSS -->
<!--     <link href="ajax/estilos/css/bootstrap.min.css" rel="stylesheet" type="text/css"> -->
    <link href="plugins/home_page/css/slider.css" rel="stylesheet" type="text/css">
    <link href="plugins/bootstrap/bootstrap.css" rel="stylesheet">

    <!-- Fonts -->
<!--     <link href="ajax/estilos/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"> -->
	<link href="font-awesome-4.7.0/css/font-awesome.css" rel="stylesheet">
	<link href="plugins/home_page/css/animate.css" rel="stylesheet" />
    <!-- Squad theme CSS -->
    <link href="plugins/home_page/css/style.css" rel="stylesheet">
	<link href="plugins/home_page/css/default.css" rel="stylesheet">
	<link href="plugins/select2/select2.css" rel="stylesheet">
<!-- 	<link href="ajax/estilos/css/prueba.css" rel="stylesheet" type="text/css"> -->
</head>
    <nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header page-scroll">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-main-collapse">
                    <i class="fa fa-bars"></i>
                </button>
                    <a class="ajax-link" href="CAPS.jsp">
                    <h1>CAPS PONELOYA </h1>
                	</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse navbar-right navbar-main-collapse">
		      <ul class="nav navbar-nav">
		        <li class="active"><a href="#intro">CAPS</a></li>
				<li><a href="#service">Informacion</a></li>
				<li><a href="#about">Acerca de Nosotros</a></li>
				<li><a href="#slider">Poneloya</a></li>
				<li data-toggle="modal" data-target="#popUpWindow"><a href="#popUpWindow">Iniciar Sesión </a></li>
		      </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

	<!-- Section: intro -->
    <section id="intro" class="intro">
	
		<div class="slogan">
			<h3 style="font-size:3.5em;">CAPS PONELOYA</h3>
			<h4>COMITE DE AGUA POTABLE Y SANEAMIENTO DE PONELOYA</h4>
		</div>
		<div class="page-scroll">
			<a href="#service" class="btn btn-circle">
				<i class="fa fa-angle-double-down animated"></i>
			</a>
		</div>
    </section>
	<!-- /Section: intro -->
<!-- Section: services -->
    <section id="service" class="home-section text-center bg-gray">
		
		<div class="heading-about">
			<div class="container">
			<div class="row">
				<div class="col-lg-8 col-lg-offset-2">
					<div class="wow bounceInDown" data-wow-delay="0.4s">
					<div class="section-heading">
					<h2 style="font-size:2.55em;">Información</h2>
					<i class="fa fa-2x fa-angle-down"></i>
					</div>
					</div>
				</div>
			</div>
			</div>
		</div>
		
		<div class="container">
			<div class="row">
				<div class="col-lg-2 col-lg-offset-5">
					<hr class="marginbot-50">
				</div>
			</div>
		
        	<div class="row">
            	<div class="col-md-offset-1 col-md-4">
					<div class="wow fadeInUp" data-wow-delay="0.2s">
	                	<div class="service-box">
							<div class="service-icon">
								<img class="img-responsive img-rounded" style="width:100%;" src="plugins/home_page/img/delega.JPG" alt="" />
							</div>
	                	</div>
					</div>
            	</div>
            
				<div class="col-md-offset-2 col-md-5">
					<div class="wow fadeInUp" data-wow-delay="0.2s">
	                	<div class="service-box">
							<div class="service-desc">
								<h3>Misión</h3>
								<p class="forma">La organización distribuye el agua potable a todos sus clientes las 24 horas al día, 
								lleva un control exacto del consumo de agua por cada clientes para lograr así cada cierre de 
								mes concluir en tiempo y forma con la elaboración de las facturas correspondiente a cada 
								cliente y de paso, llevar un control ordenado y exacto de la cantidad de agua total.</p>
							</div>
	                	</div>
					</div>
          		</div>
          
          		<div>
          		</div>
        	</div>		
	  	</div>
	</section>
	
	
	
	<!-- Section: about -->
    <section id="about" class="home-section text-center">
		<div class="heading-about">
			<div class="container">
			<div class="row">
				<div class="col-lg-8 col-lg-offset-2">
					<div class="wow bounceInDown" data-wow-delay="0.4s">
					<div class="section-heading">
					<h2>Acerca de Nosotros</h2>
					<i class="fa fa-2x fa-angle-down"></i>
					</div>
					</div>
				</div>
			</div>
			</div>
		</div>
	
	<div class="container">

		<div class="row">
			<div class="col-lg-2 col-lg-offset-5">
				<hr class="marginbot-50">
			</div>
		</div>
        <div class="row">
            <div class="col-md-3">
				<div class="wow bounceInUp" data-wow-delay="0.2s">
                <div class="team boxed-grey">
                    <div class="inner">
						<h5>Mario Peralta</h5>
                        <p class="subtitle">Pixel Crafter</p>
                        <div class="avatar"><img src="plugins/home_page/img/3.jpg" alt="" class="img-responsive img-circle" /></div>
                    </div>
                </div>
				</div>
            </div>
            
              <div class="col-md-3">
				<div class="wow bounceInUp" data-wow-delay="0.2s">
                <div class="team boxed-grey">
                    <div class="inner">
						<h5>Mario Rodriguez</h5>
                        <p class="subtitle">Pixel Crafter</p>
                        <div class="avatar"><img src="plugins/home_page/img/3.jpg" alt="" class="img-responsive img-circle" /></div>
                    </div>
                </div>
				</div>
            </div>
      
			<div class="col-md-3">
				<div class="wow bounceInUp" data-wow-delay="0.5s">
                <div class="team boxed-grey">
                    <div class="inner">
						<h5>Ana Osorio</h5>
                        <p class="subtitle">Ruby on Rails</p>
                        <div class="avatar"><img src="plugins/home_page/img/2.jpg" alt="" class="img-responsive img-circle" /></div>

                    </div>
                </div>
				</div>
            </div>
			<div class="col-md-3">
				<div class="wow bounceInUp" data-wow-delay="0.8s">
                <div class="team boxed-grey">
                    <div class="inner">
						<h5>Roxana Rodriguez</h5>
                        <p class="subtitle">jQuery Ninja</p>
                        <div class="avatar"><img src="plugins/home_page/img/1.jpg" alt="" class="img-responsive img-circle" /></div>

                    </div>
                </div>
				</div>
            </div>
            <div class="clearfix" style="margin-bottom: 20px;"></div>
			<div class=" col-md-offset-2 col-md-3">
				<div class="wow bounceInUp" data-wow-delay="1s">
                <div class="team boxed-grey">
                    <div class="inner">
						<h5>Bayron Toruño</h5>
                        <p class="subtitle">Typographer</p>
                        <div class="avatar"><img src="plugins/home_page/img/4.jpg" alt="" class="img-responsive img-circle" /></div>

                    			</div>
                			</div>
						</div>
            		</div>
            		
            <div class="col-md-3">
				<div class="wow bounceInUp" data-wow-delay="1s">
                <div class="team boxed-grey">
                    <div class="inner">
						<h5>Freddy Ibarra</h5>
                        <p class="subtitle">Typographer</p>
                        <div class="avatar"><img src="plugins/home_page/img/4.jpg" alt="" class="img-responsive img-circle" /></div>

                    			</div>
                			</div>
						</div>
            		</div>
            
             <div class="col-md-3">
				<div class="wow bounceInUp" data-wow-delay="1s">
                <div class="team boxed-grey">
                    <div class="inner">
						<h5>Mijail Morales</h5>
                        <p class="subtitle">Typographer</p>
                        <div class="avatar"><img src="plugins/home_page/img/1.jpg" alt="" class="img-responsive img-circle" /></div>

                    			</div>
                			</div>
						</div>
            		</div>		
      		  </div>	
		</div>
	</section>
	<!-- /Section: about -->

	<!-- /Section: services -->
	
	<!-- Section: contact -->
    <section id="slider" class="home-section text-center">
		<div class="heading-contact">
			<div class="container">
			<div class="row">
				<div class="col-lg-8 col-lg-offset-2">
					<div class="wow bounceInDown" data-wow-delay="0.4s">
					<div class="section-heading">
					<h2>Poneloya</h2>
					<i class="fa fa-2x fa-angle-down"></i>

					</div>
					</div>
				</div>
			</div>
			</div>
		</div>
		<div class="container">
			<div class="slider-container">
				<ul id="slider" class="slider-wrapper">
				
           			<li class="slide-current">
                		<img src="plugins/home_page/img/cho.jpg" alt="Slider Imagen 1">
                			<div class="caption">
                    			<h3 class="caption-title">caps</h3>
                   				 <p>Caps Poneloya</p>
               				 </div>
           			</li>
 
	          		 <li>
		                <img src="plugins/home_page/img/mm.jpg" alt="Slider Imagen 2">
		                <div class="caption">
		                    <h3 class="caption-title">Caps</h3>
		                    <p>Caps Poneloya</p>
		                </div>
	            	</li>
 
            <li>
                <img src="plugins/home_page/img/leon.jpg" alt="Slider Imagen 3">
                <div class="caption">
                    <h3 class="caption-title"></h3>
                    <p>Caps Poneloya</p>
                </div>
            </li>
 
            <li>
                <img src="plugins/home_page/img/roca.jpg" alt="Slider Imagen 4">
                <div class="caption">
                    <h3 class="caption-title"></h3>
                    <p>Caps Poneloya</p>
                </div>
            </li>
        </ul>
 
        <!-- Sombras -->
        <div class="shadow"></div>
 
        <!-- Controles -->
        <ul id="slider-controls" class="slider-controls"></ul>
		</div>
		</div>
	</section>
	<!-- /Section: contact -->
	
	<footer>
		<div class="container">
			<div class="row">
				<div class="col-md-12 col-lg-12">
					<div class="wow shake" data-wow-delay="0.4s">
					<div class="page-scroll marginbot-30">
						<a href="#intro" id="totop" class="btn btn-circle">
							<i class="fa fa-angle-double-up animated"></i>
						</a>
					</div>
					</div>
					<p style="font-weight:800;">CAPS PONELOYA</p>
				</div>
			</div>	
		</div>
	</footer>
	
	<!-- ///////////////////////////////Login con Modal //////////////////////////////////////////-->

<div class ="container">
<!-- 	<button type="button" class="btn btn-success" data-toggle="modal" data-target="#popUpWindow">Open Log In Window</button> -->
		<div class="modal fade" id="popUpWindow">
			<div class="modal-dialog">
				<div class="modal-content">
				<!-- /header -->
				<div class="modal-header">
				<h5 Style='color:#3276D7; font-weight: bold;'>CAPS de Poneloya: Autenticación de usuarios
				<button id="cerrar_dialogo" type="button" class=" close" data-dismiss="modal">&times;</button></h5>
				</div>
				<!-- body -->
				<div class="modal-body">
					<form action="./Autenticación" method="post">
					
						<div class="form-group">
							<input Style='border-color:#3276D7;' id="username" name="username" type="text" class="form-control" placeholder="Usuario" required>
						</div>
						<div class="form-group">
							<input Style='border-color:#3276D7;' id="password" name="password" type="password" class="form-control" placeholder="Contraseña" required>
						</div>
						<%
								DT_Rol dtr = DT_Rol.getInstance();
								ResultSet rs = dtr.cargarRol();
							%>
							
						<div class="form-group">
							<div class="col-xm-12 col-sm-12">
								<select Style='border-color:#3276D7;' class="populate placeholder Rol" name="rol" id="rol" required>
									<option value="0">SELECCIONE EL ROL</option>
									<%
										while (rs.next()) {
									%>
									<option value="<%=rs.getInt("Rol_ID")%>"><%=rs.getString("nomRol")%></option>
									<%
										}
									%>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="modal-footer">
								<button type="submit" class="btn btn-primary btn-block" Style='margin-top: 30px;' id="sesion">Iniciar sesión</button>
							</div>
						</div>
					</form>
					 <h6 Style='color:#3276D7; text-align:center;'> <label Style='color:red; font-size:20px; text-align:center;'>* </label> Esta cuenta es proporcionada por el administrador del sistema</h6>
					 <div id="msg">
					 <p Style='color:red; text-align:center; font-size:medium; font-weight:600;'><msg:out value="${msg}"/></p>
					 </div>
				</div>
				</div>
			</div>
		</div>
</div>

	 <!-- Core JavaScript Files -->
<!--     <script src="ajax/estilos/js/jquery.min.js"></script> -->
<!--     <script src="ajax/estilos/js/bootstrap.min.js"></script> -->
	<script src="plugins/jquery/jquery-2.1.0.min.js"></script>
	<script src="plugins/bootstrap/bootstrap.min.js"></script>
	
    <script src="plugins/home_page/js/jquery.easing.min.js"></script>	
	<script src="plugins/home_page/js/jquery.scrollTo.js"></script>
	<script src="plugins/home_page/js/wow.min.js"></script>
    <!-- Custom Theme JavaScript -->
    <script src="plugins/home_page/js/custom.js"></script>
<!--     <script src="/contactform/contactform.js"></script>   -->
<!--     <script src="ajax/estilos/css/jquery-3.2.0.min.js"></script>   -->
    
    <script>
    
    function MakeSelect2() {
    	$('select').select2();
    	$('.select2-container').css({"width":"inherit", "text-align":"center", "font-size":"16px"});
    	$('ul.select2-results').css({"font-size":"16px", "text-align":"center"});
    }
        $(function() {
            var SliderModule = (function() {
                var pb = {};
                pb.el = $('#slider');
                pb.items = {
                    panel: pb.el.find('li')
                }
         
                // Variables Necesarias
                var SliderInterval,
                    currentSlider = 0,
                    nextSlider = 1,
                    lengthSlider = pb.items.panel.length;
         
                // Initialize
                pb.init = function(settings) {
                    this.settings = settings || {duration: 8000}
                    var output = '';
         
                    // Activamos nuestro slider
                    SliderInit();
         
                    for(var i = 0; i < lengthSlider; i++) {
                        if (i == 0) {
                            output += '<li class="active"></li>';
                        } else {
                            output += '<li></li>';
                        }
                    }
         
                    // Controles del Slider
                    $('#slider-controls').html(output).on('click', 'li', function (e){
                        var $this = $(this);
                        if (currentSlider !== $this.index()) {
                            changePanel($this.index());
                        };
                    });
                }
         
                var SliderInit = function() {
                    SliderInterval = setInterval(pb.startSlider, pb.settings.duration);
                }
         
                pb.startSlider = function() {
                    var panels = pb.items.panel,
                        controls = $('#slider-controls li');
         
                    if (nextSlider >= lengthSlider) {
                        nextSlider = 0;
                        currentSlider = lengthSlider-1;
                    }
         
                    // Efectos
                    controls.removeClass('active').eq(nextSlider).addClass('active');
                    panels.eq(currentSlider).fadeOut('slow');
                    panels.eq(nextSlider).fadeIn('slow');
         
                    // Actualizamos nuestros datos
                    currentSlider = nextSlider;
                    nextSlider += 1;
                }
         
                // Funcion para controles del slider
                var changePanel = function(id) {
                    clearInterval(SliderInterval);
                    var panels = pb.items.panel,
                        controls = $('#slider-controls li');
         
                    // Comprobamos el ID
                    if (id >= lengthSlider) {
                        id = 0;
                    } else if (id < 0) {
                        id = lengthSlider-1;
                    }
         
                    // Efectos
                    controls.removeClass('active').eq(id).addClass('active');
                    panels.eq(currentSlider).fadeOut('slow');
                    panels.eq(id).fadeIn('slow');
         
                    // Actualizamos nuestros datos
                    currentSlider = id;
                    nextSlider = id+1;
         
                    // Reactivamos el slider
                    SliderInit();
                }
         
                return pb;
            }());
            SliderModule.init({duration: 6000});
            $.getScript('plugins/select2/select2.min.js',MakeSelect2);
            $("button#cerrar_dialogo").on("click", function() {
				$("div#msg p").empty();
			});
            if($("div#msg p").text() == ""){
        		console.log("No se ha autenticado");
        	}else{
        		$('#popUpWindow').modal('show');
        	}
        });
		</script>
    
    
    
</body>
</html>