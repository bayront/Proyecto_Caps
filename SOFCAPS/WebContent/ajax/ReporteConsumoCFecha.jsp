
<%@page import="Datos.DT_consumo_bomba, java.util.* ,java.sql.ResultSet;"%>
<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%> 
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Consumo clientes</a></li>
		</ol>
	</div>
</div>	

<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-search"></i> <span>Consumo de clientes</span>
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
				<div class="form-group">
					<!-- FORMA PARA CREAR PERIODOS DE TIEMPO CON JQUERY UI -->
						<label class="col-sm-4 control-label">Periodo de fechas</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="FECHITA1"
								placeholder="fecha de inicio">
						</div>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="FECHITA2"
								placeholder="fecha de fin">
						</div>
					</div>
					
					
					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-3">
							<button type="submit"  id="imprimir3" class="fa fa-print fa-2x"
							data-toggle='tooltip' "data-placement='bottom' onclick="imprimir();">
								<span></span> Imprimir
							</button>
						</div>
						
					</div>
						<div class= "clearfix"></div>
							<div class= "clearfix"></div>
								<div class= "clearfix"></div>
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
	var v = "";
	

		
	valor = $('#FECHITA1').val();
	v = $('#FECHITA2').val();
	

	
	window.open("SL_ReporteConsumoCFecha?FECHITA1="+valor+"&FECHITA2="+v, '_blank');
	
	console.log("El mes jsp"+" "+valor);
	console.log("El mes jsp"+" "+v);
	
}





// Run Select2 plugin on elements
function DemoSelect2(){
	$('#meses').select2();
}



$(document).ready(function() {
	
	$('#FECHITA1').datepicker({
		setDate : new Date(),
		dateFormat: 'dd/mm/yy',
		changeMonth: true,
  changeYear: true,
		onSelect: function(dateText, inst) {
			$("#insert").val(dateText);
	}
	});
	
	$('#FECHITA2').datepicker({
		setDate : new Date(),
		dateFormat: 'dd/mm/yy',
		changeMonth: true,
  changeYear: true,
		onSelect: function(dateText, inst) {
			$("#insert").val(dateText);
	}
	});

	
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