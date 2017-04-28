<%@page import="Entidades.Mes"%>
<%@page import="Datos.DT_consumo_bomba, java.util.* ,java.sql.ResultSet;"%>
<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%> 
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Recibos de caja</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-search"></i> <span>Informe de la Bomba</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a> <a class="close-link"> <i class="fa fa-times"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content">
				<form class="form-horizontal" role="form" id ="formReporteBomba">
					<input type="hidden" id="cliente_ID" name="cliente_ID">
					
					<div class="form-group">
						<%
							DT_consumo_bomba cb =DT_consumo_bomba.getInstance();
						
							ArrayList<Mes> listaMeses = new ArrayList<Mes>();
							listaMeses = cb.listaMeses();
							
						%>
					
							<label class="col-sm-2 control-label">Elija el mes:</label>
								<div class="col-sm-5">
									<select id="meses" class="populate placeholder">
									<option value="" >--Seleccione un mes del año--</option>
									<%
										for(int i = 0; i < listaMeses.size(); i++){
										%>
											<option value="<%=listaMeses.get(i).getNombre() %>"> <%=listaMeses.get(i).getNombre() %></option>
										<%
											}
								%>	
									</select>
								</div>
						</div>

	
					
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-4">
							<button type="submit" class="btn btn-primary btn-label-left" onclick="imprimir();">
								<span><i class="fa fa-save"></i></span> Generar reporte
							</button>
						</div>
						<div class="col-sm-2">
							<button type="button" class="btn btn-default btn-label-left" >
								<span><i class="fa fa-mail-reply txt-danger"></i></span> Cancelar
							</button>
						</div>
					</div>
					
				</form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">


function imprimir()

{	
	var valor = "";
	

		
	valor = $('#meses').val();
	

	
	window.open("SL_reporte_bomba?meses="+valor, '_blank');
	
	console.log("El mes jsp"+" "+valor);
	
}





// Run Select2 plugin on elements
function DemoSelect2(){
	$('#meses').select2();
}



$(document).ready(function() {
	// Add slider for change test input length
	FormLayoutExampleInputLength($( ".slider-style" ));
	// Initialize datepicker
	//$('#input_date').datepicker({setDate: new Date()});
	// Load Timepicker plugin

	// Add tooltip to form-controls
	LoadSelect2Script(DemoSelect2);
	// Load example of form validation
	LoadBootstrapValidatorScript(DemoFormValidator);
	// Add drag-n-drop feature to boxes
	WinMove();

})
</script>