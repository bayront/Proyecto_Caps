<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="Entidades.*, Datos.*, java.sql.ResultSet;"%>
<!DOCTYPE html>
<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
%>

<html>
<!-- ************************************ADMINISTRADOR********************************* -->
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author" content="Dashboard">
	<meta name="keyword"
		content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
	
	<title>Error | APS</title>
	<link rel="shortcut icon" href="assets/img/favicon.ico" />
<%-- 	<jsp:include page="links.jsp" flush="true" /> --%>
</head>

<%
	String nombre_usuario = "";
	nombre_usuario = (String) session.getAttribute("nombre_usuario");
	nombre_usuario = nombre_usuario==null?"":nombre_usuario;
	
	DT_Vw_rol_opciones dtvro = DT_Vw_rol_opciones.getInstance();

	Usuario us = new Usuario();
	us = (Usuario)session.getAttribute("userVerificado");
	
	Rol r = new Rol();
	r = (Rol)session.getAttribute("Rol");
	
	String url="";
	url = request.getRequestURI();
	System.out.println("url: "+url);
	int index = request.getRequestURI().lastIndexOf("/");
	System.out.println("index: "+index);
	String miPagina = request.getRequestURI().substring(index);
	System.out.println("miPagina: "+miPagina);
	boolean permiso = false;
	String opcionActual = "";
	
	
	ResultSet rs;
	
	if(us != null && r != null)
	{
		rs=dtvro.obtenerOpc(r);
		while(rs.next())
		{
			opcionActual = rs.getString("opciones");
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
		response.sendRedirect("../CAPS.jsp");
		return;
	}
	if(!permiso)
	{
		System.out.println("Pagina de error");
		response.sendRedirect("pag_Error.jsp");
		return;
	}

%>
<body>

	<div id="container">
<%-- 		<jsp:include page="menu.jsp" flush="true" /> --%>

		<!-- **********************************************************************************************************************************************************
      CONTENIDO PRINCIPAL
      *********************************************************************************************************************************************************** -->

		<div id="main-content">
			<div class="wrapper">

				<!-- Otro Formulario de Elementos 1-->
				<div class="row mt">
					<div class="col-xs-12 col-md-12 col-lg-12">
						<div class="form-panel">
							<div class="panel-heading">
							</div>
							<div class="panel-body">
								<div class="col-xs-12 col-md-12 col-lg-12">
									<section class="error-wrapper text-center">
										<h1><b>Comité de Agua Potable y Saneamiento de Poneloya</b></h1>
							            <h1>
							            	<img class="img-responsive" width="450px" height="330px" 
							            	alt="" src="img/gota_prohibida.png" style="margin: 0 auto;">
							            </h1>
							            <h2>Estimado usuario <b color:blue;><%=nombre_usuario %></b></h2>
							            <h2>Lo sentimos, </h2>
							            <h3>el rol <b><%=rs.getString("nomRol")%></b> no cuenta con los permisos suficientes para acceder a esta opción</h3>
							            <br>
							            <br>
							           <div style="background-color: #d7f9ec; width: 300px; margin: 0 auto; border-radius: 15px;
							           border-color: #4c8676; border-width: 2px; border-style: groove;" class="img-responsive"> 
							           		<a style="font-size: 26px;" class="back-btn" href="index.jsp">
							           			<h4 class="fa fa-home"> Regresar a Inicio</h4>
							           		</a>
							          	</div>
							        </section>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- row mt -->
			</div>
			<!-- wrapper -->


			<!-- **********************************************************************************************************************************************************
      CONTENIDO DE PIÉ DE PÁGINA
  *********************************************************************************************************************************************************** -->

			<!--Inicio del Footer-->
<%-- 			<div><jsp:include page="footer.jsp" flush="true" /> --%>
			</div>
			<!--Fin footer-->
		</div>
		<!--Fin main-content-->
	</div>
	<!--Fin container-->
</body>
</html>