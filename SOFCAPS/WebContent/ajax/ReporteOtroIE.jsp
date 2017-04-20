<%@page import="Datos.DTOtros_Ing_Egreg"%>
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

<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box" style="top: 0px; left: 0px; opacity: 1;">

			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-edit"></i> <span>Informe Otros Ingresos y egresos</span>
				</div>
<!-- 				<div class="box-icons"> -->
<!-- 					<a id="colapsar_desplegar1" class="collapse-link" onclick="validar(colap1);"> <i -->
<!-- 						class="fa fa-chevron-up"></i></a>  -->
<!-- 						<a id="expandir1" class="expand-link"  onclick="validar(expand1);">  -->
<!-- 						<i class="fa fa-expand"></i></a> -->
<!-- 				</div> -->
				<div class="no-move"></div>
			</div>

			<div class="box-content">
				
				<div id="ow-server-footer" style="margin:-15px; margin-bottom:30px;">
					<a href="#" class="col-xs-6 col-sm-6 btn-info text-center" style="color:#2f2481; font-weight:800;"><i
					class="fa fa-list"></i> <span>Informe por período de fecha</span> </a>
					<a href="#" class="col-xs-6 col-sm-6 btn-info text-center" style="color:#2f2481; font-weight:800;"><i
					class="fa fa-plus-square"></i> <span>Informe por Ingresos</span></a>
					<a href="#" class="col-xs-6 col-sm-6 btn-info text-center" style="color:#2f2481; font-weight:800;"><i
					class="fa fa-plus-square"></i> <span>Informe por Egresos</span></a> 
				</div>
<!-- 				<form class="form-horizontal" role="form" id="defaultForm" -->
<!-- 					method="POST" action="./SL_Factura"> -->
<!-- 					<input type="hidden" id="opcion" name="opcion" value="generar"> -->
					
					<h4 class="page-header"
						Style="text-align: center; font-size: xx-large;">Otros Ingresos y egresos</h4>

					<div class="clearfix"></div>
					<div class="form-group has-feedback">
						<label class="col-sm-2 text-gpromedix control-label">Mes:</label>
						<%
						DTOtros_Ing_Egreg dtn = DTOtros_Ing_Egreg.getInstance();
						ResultSet rs = dtn.mes();
						%>
						<div class="col-sm-4 has-rpromedix">
							<div class="combo-contenedor">
								<select id="parameter1" name="parameter1" class="populate placeholder" required>
									<option value="0">SELECCIONE</option>
										<%
										while(rs.next())
										{
										%>
										<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
										<%
										} 
										%>
								</select>
							</div>
						</div>
<!-- 						<label class="col-sm-2 text-gpromedix control-label">Año:</label> -->
<%-- 						<% --%>
<!--  						rs = dtn.anio(); -->
						
<%-- 						%> --%>
						<div class="col-sm-4 has-rpromedix">
							<div class="combo-contenedor">
							<label class="col-sm-2 text-gpromedix control-label">Año:</label>
						<%
						rs = dtn.anio();
						%>
								<select id="a" name="a" class="populate placeholder" required>
									<option value="0">SELECCIONE</option>
										<%
										while(rs.next())
										{
										%>
										<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
										<%
										} 
										%>
								</select>
							</div>
						</div>
					</div>
					
					
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-3">
							<button type="submit"  id="imprimir" class="fa fa-print fa-2x"
							data-toggle='tooltip' "data-placement='bottom' onclick="imprimir();">
								<span></span> Imprimir
							</button>
						</div>
						
					</div>
				
			</div>
		</div>
	</div>
</div>

<form class="form-horizontal" role="form" id="defaultForm" 
			method="POST" action="./SL_Factura"> 
<!-- 			<input type="hidden" id="opcion" name="opcion" value="generar">  -->
	<h4 class="page-header"
						Style="text-align: center; font-size: xx-large;">Otros Ingresos y egresos</h4>

					<div class="clearfix"></div>
					<div class="form-group has-feedback">
						<label class="col-sm-2 text-gpromedix control-label">Ingresos:</label>
						<%
						DTOtros_Ing_Egreg dt = DTOtros_Ing_Egreg.getInstance();
						ResultSet rt = dt.ing();
						%>
						<div class="col-sm-4 has-rpromedix">
							<div class="combo-contenedor">
								<select id="ing" name="ing" class="populate placeholder" required>
									<option value="0">SELECCIONE</option>
										<%
										while(rt.next())
										{
										%>
										<option value="<%=rt.getString(1)%>"><%=rt.getString(1)%></option>
										<%
										} 
										%>
								</select>
							</div>
						</div>
<!-- 						<label class="col-sm-2 text-gpromedix control-label">Año:</label> -->
<%-- 						<% --%>
<!--  						rs = dtn.anio(); -->
						
<%-- 						%> --%>
						<div class="col-sm-4 has-rpromedix">
							<div class="combo-contenedor">
							<label class="col-sm-2 text-gpromedix control-label">Año:</label>
						<%
						rs = dtn.ing();
						%>
								<select id="a" name="a" class="populate placeholder" required>
									<option value="0">SELECCIONE</option>
										<%
										while(rs.next())
										{
										%>
										<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
										<%
										} 
										%>
								</select>
							</div>
						</div>
					</div>
					
					
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-3">
							<button type="submit"  id="imprimir" class="fa fa-print fa-2x"
							data-toggle='tooltip' "data-placement='bottom' onclick="imprimir();">
								<span></span> Imprimir
							</button>
						</div>

</div>
</form>

<script type="text/javascript">

//Inicializar DatePicker

function imprimir()

{	
	var valor = "";
	var v = "";
	var descripcion ="";
	var monto = "";
		
	valor = $('#parameter1').val();
	v =  $('#a').val();
	descripcion = $("#descripcion").val();
	monto = $("#monto").val();
	
	
	if(valor == 0)
	{
		valor = "";
	}if(v==0){
		v = "";
	}

	
	window.open("SL_ReporteOtros?parameter1="+valor+"&a="+v+"&monto="+monto, '_blank');
	console.log("La fecha del jsp"+" "+parameter1);
	console.log("El paramtero del jsp"+" "+valor);
	console.log("El paramtero del jsp anio"+" "+v);

}


	
</script>