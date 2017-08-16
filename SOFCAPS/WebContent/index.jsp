<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8" import="Entidades.*, Datos.*, java.sql.ResultSet;"%> 
<!-- contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" -->
<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>SOFCAPS</title>
<%
	String nombre_usuario = "";
	nombre_usuario = (String) session.getAttribute("nombre_usuario");
	nombre_usuario = nombre_usuario==null?"":nombre_usuario;
// 	if(nombre_usuario.equals("")){
// 		response.sendRedirect("CAPS.jsp");
// 	}

	
	DT_Vw_rol_opciones dtvro = DT_Vw_rol_opciones.getInstance();

	Usuario us = new Usuario();
	us = (Usuario)session.getAttribute("userVerificado");
	
	Rol r = new Rol();
	r = (Rol)session.getAttribute("Rol");
	
	String url="";
	url = request.getRequestURI();
	//System.out.println("url: "+url);
	int index = request.getRequestURI().lastIndexOf("/");
	//System.out.println("index: "+index);
	String miPagina = request.getRequestURI().substring(index);
	//System.out.println("miPagina: "+miPagina);
	boolean permiso = false;
	String opcionActual = "";
	
	
	ResultSet rs;
	
	if(us != null && r != null)
	{
		rs=dtvro.obtenerOpc(r);
		while(rs.next())
		{
			opcionActual = rs.getString("opciones");
			System.out.println("opcionActual: "+opcionActual);
			if(opcionActual.equals(miPagina))
			{
				permiso = true;
				break;
			}
			else
			{
				permiso = false;
			}
		}
	}
	else
	{
		System.out.println("Pagina caps");
		response.sendRedirect("CAPS.jsp");
		return;
	}
	
	if(!permiso)
	{
		System.out.println("Pagina de error");
		response.sendRedirect("../pag_Error.jsp");
	}
%>

<meta name="description" content="description">
<meta name="author" content="team_CAPS">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="plugins/bootstrap/bootstrap.css" rel="stylesheet">
<link href="plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet">
<link href="font-awesome-4.7.0/css/font-awesome.css" rel="stylesheet">
<link href="plugins/datatables/nuevo/dataTables.bootstrap.css" rel="stylesheet">
<link href="plugins/datatables/nuevo/responsive.dataTables.min.css" rel="stylesheet">
<link href="plugins/fancybox/jquery.fancybox.css" rel="stylesheet">
<link href="plugins/fullcalendar/fullcalendar.css" rel="stylesheet">
<link href="plugins/xcharts/xcharts.min.css" rel="stylesheet">
<link href="plugins/select2/select2.css" rel="stylesheet">
<link href="plugins/bootstrapvalidator/bootstrapValidator.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
				<script src="http://getbootstrap.com/docs-assets/js/html5shiv.js"></script>
				<script src="http://getbootstrap.com/docs-assets/js/respond.min.js"></script>
		<![endif]-->
</head>
<body>
	<!--Start Header-->
	<div id="screensaver">
		<canvas id="canvas"></canvas>
		<i class="fa fa-lock" id="screen_unlock"></i>
	</div>
	<div id="modalbox">
		<div class="devoops-modal">
			<div class="devoops-modal-header">
				<div class="modal-header-name">
					<span>Basic table</span>
				</div>
				<div class="box-icons">
					<a class="close-link"> <i class="fa fa-times"></i>
					</a>
				</div>
			</div>
			<div class="devoops-modal-inner"></div>
			<div class="devoops-modal-bottom"></div>
		</div>
	</div>
	<header class="navbar">
		<div class="container-fluid expanded-panel">
			<div class="row">
				<div id="logo" class="col-xs-12 col-sm-2">
					
					<a href="index.jsp">CAPS de Poneloya</a>

				</div>
				<div id="top-panel" class="col-xs-12 col-sm-10">
					<div class="row">
						<div class="col-xs-8 col-sm-4">
							<a href="#" class="show-sidebar"> <i class="fa fa-bars"></i>
							</a>
						</div>
						<div class="col-xs-4 col-sm-8 top-panel-right">
							<ul class="nav navbar-nav pull-right panel-menu">
								<li class="dropdown"><a href="#"
									class="dropdown-toggle account" data-toggle="dropdown">
										<i class="fa fa-angle-down pull-right"></i>
										<div class="user-mini pull-right">
											<span class="welcome" style="font-size: 14px;">Bienvenid@ : </span>
											<span style="font-size: 14px;" ><%=nombre_usuario %></span>
										</div>
								</a>
									<ul class="dropdown-menu">
										<li><a href="CAPS.jsp"><i class="fa fa-power-off"></i>
											<span>Cerrar Sesión</span>
										</a></li>
									</ul></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</header>
	<!--End Header-->
	<!--Start Container-->
	<div id="main" class="container-fluid">
		<div class="row">
			<div id="sidebar-left" class="col-xs-2 col-sm-2">
				<ul class="nav main-menu">
					<li><a href="ajax/dashboard.html" class="active ajax-link">
						<i title="Inicio" data-placement="bottom" class="fa fa-home"></i> <span class="hidden-xs">Inicio</span>
					</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle">
							<i title="Secretaría" class="fa fa-folder-open"></i><span class="hidden-xs"> Área secretaría</span>
					</a>
						<ul class="dropdown-menu">
							<li><a class="ajax-link" href="ajax/crear_tarifa.jsp">
								<i class="fa fa-usd"></i> Gestión de tarifas</a>
							</li>
							<li><a class="ajax-link" href="ajax/crear-categoria.jsp">
								<i class="fa fa-archive"></i> Gestión de categorías</a>
							</li>
						</ul>
					</li>
					<li><a href="ajax/Cliente.jsp" class="ajax-link">
							<i title="Gestión Cliente" class="fa fa-group"></i> <span class="hidden-xs">Gestión de clientes</span>
					</a></li>
					<li><a href="ajax/Contrato.jsp" class="ajax-link">
							<i title="Gestión Contrato" class="fa fa-pencil-square-o"></i> <span class="hidden-xs">Gestión de contratos</span>
					</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle">
							<i title="Consumos" class="fa fa-tint"></i> <span class="hidden-xs">Consumos</span>
					</a>
						<ul class="dropdown-menu">
							<li><a class="ajax-link" href="ajax/consumo_bomba.jsp"> Consumo de la bomba</a></li>
							<li><a class="ajax-link" href="ajax/ver-consumos.jsp"> Consumo de los clientes</a></li>
						</ul>
					</li>
					<li><a href="ajax/facturacion.jsp" class="ajax-link">
							<i title="Facturación" class="fa fa-list-alt"></i> <span class="hidden-xs">Área facturación</span>
					</a></li>
					<li><a href="ajax/ReciboCaja.jsp" class="ajax-link">
							<i title="Recibo caja" class="fa fa-dashboard"></i> <span class="hidden-xs">Recibos de caja</span>
					</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle">
						<i title="Finanzas" class="fa fa-briefcase"></i> <span class="hidden-xs">Área finanzas</span></a>
						<ul class="dropdown-menu">
							<li><a class="ajax-link" href="ajax/OtrosIngEgreg.jsp" style="padding: 9px 10px 9px 30px;">
							<p style="height:auto; white-space:normal; margin-bottom:0px;">
							Gestión de ingresos y egresos</p></a></li>
							<li class="dropdown"><a href="#" class="dropdown-toggle" 
							style="min-width: auto; padding-left:30px;"><i title="Ingreso Egreso" class="fa fa-pencil-square-o"></i> 
							<span class="hidden-xs">Ingresos y Egresos</span></a>
								<ul class="dropdown-menu" style="min-width:auto;">
									<li><a style="padding:10px; padding-left:30px" class="ajax-link" 
									href="ajax/categoria_Ing_egreg.jsp">Categorías</a></li>
								</ul>
							</li>
						</ul>
					</li>
					<li><a href="ajax/Reconexion.jsp" class="ajax-link">
							<i title="Clientes morosos" class="fa fa-exclamation"></i> <span class="hidden-xs">Clientes morosos</span>
					</a></li>
					
					<li class="dropdown"><a href="#" class="dropdown-toggle">
					<i title="Usuarios" class="fa fa-user"></i> <span class="hidden-xs">Usuarios</span></a>
						<ul class="dropdown-menu">
							<li><a class="ajax-link" href="ajax/usuarito.jsp">Gestión de usuarios</a></li>
							<li><a class="ajax-link" href="ajax/Usuario_Rol.jsp">Usuarios y Roles</a></li>
						</ul>
					</li>
					<li class="dropdown"><a href="ajax/Roles_Opciones.jsp" class="ajax-link">
							<i title="Rol Opción" class="fa fa-unlock-alt"></i> <span class="hidden-xs">Roles y Opciones</span>
					</a></li>
						
						<li class="dropdown"><a href="#" class="dropdown-toggle">
							<i title="Reportes" class="fa fa-archive"></i> <span class="hidden-xs">Reportes</span></a>
							<ul class="dropdown-menu">
								<li><a class="ajax-link" href="ajax/ReporteOtroIE.jsp" style="padding: 9px 10px 9px 30px;">
								<p style="height:auto; white-space:normal; margin-bottom:0px;">
								Informe de ingresos y egresos </p></a></li>
								<li><a class="ajax-link" href="ajax/informeRecibosIngresos.jsp" style="padding: 9px 10px 9px 30px;">
								<p style="height:auto; white-space:normal; margin-bottom:0px;">
								Informe de recibos de caja</p></a></li>
								<li class="dropdown"><a href="#" class="dropdown-toggle" 
								style="min-width: auto; padding-left:30px;"><i title="Acuerdos de pago" class="fa fa-pencil-square-o"></i> 
								<span class="hidden-xs">Acuerdo pago</span></a>
									<ul class="dropdown-menu" style="min-width:auto;">
										<li><a style="padding:10px; padding-left:30px" class="ajax-link" 
										href="ajax/AcuerdoPago.jsp">Comprimiso Pago</a></li>
									</ul>
								</li>
								<li><a class="ajax-link" href="ajax/reporte_bomba.jsp" style="padding: 9px 10px 9px 30px;">
								<p style="height:auto; white-space:normal; margin-bottom:0px;">
								Informe de la Bomba </p></a></li>
								<li><a class="ajax-link" href="ajax/ConsumoClientesFiltros.jsp" style="padding: 9px 10px 9px 30px;">
								<p style="height:auto; white-space:normal; margin-bottom:0px;">
								Consumo de clientes </p></a></li>
								<li><a class="ajax-link" href="ajax/AguaPerdidaFB.jsp" style="padding: 9px 10px 9px 30px;">
								<p style="height:auto; white-space:normal; margin-bottom:0px;">
								informe de agua perdida</p></a></li>
							</ul>
						</li>
						
						
						
			</ul></div>
			<!--Start Content-->
			<div id="content" class="col-xs-12 col-sm-10">
				<div class="preloader">
					<img src="img/devoops_getdata.gif" class="devoops-getdata"
						alt="preloader" />
				</div>
				<div id="ajax-content"></div>
			</div>
			<!--End Content-->
		</div>
	</div>
	<!--End Container-->
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="plugins/jquery/jquery-2.1.0.min.js"></script>
<!-- 	<script src="plugins/datatables/nuevo/jquery-1.12.3.js"></script> -->
	<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="plugins/bootstrap/bootstrap.min.js"></script>
	<script src="plugins/tinymce/tinymce.min.js"></script>
	<script src="plugins/tinymce/jquery.tinymce.min.js"></script>
	
	<!-- All functions for this theme + document.ready processing -->
	<script src="js/devoops.js"></script>
	<script type="text/javascript">$("i[title]").tooltip();</script>
</body>
</html>
