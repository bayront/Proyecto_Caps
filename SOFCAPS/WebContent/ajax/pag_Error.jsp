<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="Entidades.*, Datos.*, java.sql.ResultSet;"%>
<!DOCTYPE html>
<%
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setDateHeader("Expires", -1);
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
								
									<section class="error-wrapper" ALIGN="center">
							            <h1><img alt="" src="img/denied.png"></h1>
							            <h2>Estimado usuario <%=nombre_usuario %></h2>
							            <h2>Lo sentimos</h2>
							            <h3>el rol <%=rs.getString("nomRol")%> no cuenta con los permisos suficientes para acceder a esta opción</h3>
							            <a class="back-btn" href="index.jsp"> Regresar a Inicio</a>
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