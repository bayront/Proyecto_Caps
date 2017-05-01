<%@page import="Datos.DTCliente"%>
<%@page import="java.sql.ResultSet"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<!--///////////////////////div donde se muestra un Dialogo /////////////////////////////// -->
<div id="dialog" class= "col-xm-offset-1 col-xm-10">
	<div class="contenido" style="margin-left: 20px;"></div>
</div> 
<!--///////////////////////Directorios donde estan los jsp /////////////////////////////// -->
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Reportes</a></li>
		</ol>
	</div>
</div>

<!-- inicio formulario por egresos -->

<div id = "porE">
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box" style="top: 0px; left: 0px; opacity: 1;">

			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-edit"></i> <span>Reporte</span>
				</div>
<!-- 				<div class="box-icons"> -->
<!-- 					<a id="colapsar_desplegar1" class="collapse-link" onclick="validar(colap1);"> <i -->
<!-- 						class="fa fa-chevron-up"></i></a>  -->
<!-- 						<a id="expandir1" class="expand-link"  onclick="validar(expand1);">  -->
<!-- 						<i class="fa fa-expand"></i></a> -->
<!-- 				</div> -->
<!-- 				<div class="no-move"></div> -->
			</div>

			<div class="box-content">
				
			

					
					<h4 class="page-header"
						Style="text-align: center; font-size: xx-large;">Informe de Compromiso de pago</h4>

					<div class="clearfix"></div>
					
						<div class="form-group has-feedback">
						<label class="col-sm-4 text-gpromedix control-label">Nombre cliente:</label>
						<%
						
						DTCliente dtn = DTCliente.getInstance();
						ResultSet rs = dtn.cargarNombre();
						%>
						<div class="col-sm-5">
							
								<select id="tippe" name="tippe" class="populate placeholder" required>
								
									
									<option value="0">SELECCIONE</option>
										<%
										while(rs.next())
										{
										%>
										<option value="<%=rs.getString("Cliente_ID")%>"><%=rs.getString("nombre_completo")%></option>
										<%
										} 
										%>
								</select>
							
						</div>
						<div class= "clearfix"></div>
						<div class="form-group">
						<div class="col-sm-offset-4 col-sm-3">
							<button type="submit"  id="imprimirr" class="fa fa-print fa-2x"
							data-toggle='tooltip' "data-placement='bottom' onclick="imprimirr();">
								<span></span> Imprimir
							</button>
						</div>
						
					</div>
					<div class= "clearfix"></div>
					<div class= "clearfix"></div>
		
		
		</div>
	</div>
<!-- inicio formulario se -->

<script type="text/javascript">

//Inicializar DatePicker



function imprimirr()

{	
	

	var cat = "";
	
	
	
	cat = $('#tippe').val();
	
	
	
	
	
	if(cat==0){
		cat = "";
	}

	
	
	window.open("SLAP?tippe="+cat, '_blank');
	
	console.log("El paramtero del jsp SLAP cat"+" "+cat);
	

}




$(document).ready(function() {
	
	
	$('#porE').show();
	

		
});


	
</script>