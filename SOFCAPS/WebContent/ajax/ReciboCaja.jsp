<%@page import="Entidades.Factura_Maestra"%>
<%@page import="Entidades.Contrato"%>
<%@page import="Entidades.Reconexion"%>
<%@page import="Entidades.Serie"%>
<%@page import="Datos.DT_reciboCaja, java.util.* ,java.sql.ResultSet;"%>
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
					<i class="fa fa-edit"></i> <span>Recibo de caja</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content">
				<form class="form-horizontal" role="form" id ="formReciboCaja">
					<input type="hidden" id="cliente_ID" name="cliente_ID">
					<div class="form-group has-error has-feedback">
						<label class="col-sm-2 control-label">Fecha:</label>
						<div class="col-sm-3">
							<input type="text" id="input_date" class="form-control"
								placeholder="Date" readonly > <span
								class="fa fa-calendar txt-danger form-control-feedback"></span>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">Nombre del cliente:</label>
						<div class="col-sm-5">
							<input id = "nombreClienteCompleto" type="text" class="form-control" placeholder="Seleccione el nombre del cliente"
								data-toggle="tooltip" data-placement="bottom"
								title="Tooltip para el nombre del cliente" readonly>
						</div>
						<div class="col-sm-5 col-md-3">
							<button type="button" class="blue" id="abrir_modal">
								<span><i class="fa fa-search"></i></span> Buscar Cliente
							</button>
						</div>
					</div>
					
					<div class="form-group">
						<%
							DT_reciboCaja rc =DT_reciboCaja.getInstance();
						
							ArrayList<Serie> listaSeries = new ArrayList<Serie>();
							listaSeries = rc.listaSeries();
						%>
					
							<label class="col-sm-2 control-label">En concepto de:</label>
								<div class="col-sm-5">
									<select id="concepto" class="populate placeholder">
									<option value="" >--Seleccione un concepto a pagar--</option>
									<%
										for(int i = 0; i < listaSeries.size(); i++){
										%>
											<option value="<%=listaSeries.get(i).getSerie_ID() %>"> <%=listaSeries.get(i).getDescripcion() %></option>
										<%
											}
								%>	
									</select>
								</div>
						</div>
						
						<div class="clearfix"></div>
						
						<div class="form-group has-success has-feedback">
							<label class="col-sm-2 control-label">Facturas: </label>
								<div class="col-sm-4">
									<select id="factura"
										class="populate placeholder">
										<option value="">--Seleccione la factura--</option>
									</select>
								</div>
						</div>
						
						<div class="form-group has-success has-feedback">
							<label class="col-sm-2 control-label">Contratos:</label>
								<div class="col-sm-4">
									<select id="contrato" class="populate placeholder">
										<option value="">--Seleccione el contrato--</option>
									</select>
								</div>
						</div>
						
						<div class="form-group has-success has-feedback">
							<label class="col-sm-2 control-label">Reconexiones: </label>
								<div class="col-sm-4">
									<select id="reconexion"
										class="populate placeholder">
										<option value="">--Seleccione la orden de reconexión--</option>
									</select>
								</div>
						</div>
						
						<div class="form-group has-error has-feedback">
						<label class="col-sm-2 control-label">Monto total: </label>
						<div class="col-sm-2">
							<input type="number" id="montoTotal" class="form-control"
								placeholder="C$ 0.00" > <span
								class="fa fa-money txt-danger form-control-feedback"></span>
						</div>
					</div>
	
					
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-3">
							<button type="cancel" class="btn btn-warning btn-label-left">
								<span><i class="fa fa-location-arrow txt-danger"></i></span> Agregar a la lista
							</button>
						</div>
						<div class="col-sm-2">
							<button type="submit" class="btn btn-primary btn-label-left">
								<span><i class="fa fa-save"></i></span> Guardar
							</button>
						</div>
						<div class="col-sm-2">
							<button type="button" class="btn btn-default btn-label-left" >
								<span><i class="fa fa-mail-reply"></i></span> Cancelar
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
// Run Select2 plugin on elements
function DemoSelect2(){
	$('#concepto').select2();
	$('#contrato').select2();
	$('#factura').select2();
	$('#reconexion').select2();
}

function DemoTimePicker(){
	$('#input_time').timepicker({setDate: new Date()});
}
/////////////////////////////Funciones para activar y desactivar los select////////////////////////////////////
function desactivarSelect(select){
	$(select).attr('disabled', 'disabled');
}
function activarSelect(select){
	$(select).removeAttr('disabled');
}
	
///////////////////funsión que crea un dataTable para traer en cliente y el contrato mediante un dialogo////////////
function filtrarTabla(){
	    $('#datatable-filter thead th label input').each( function () {
	        var title = $(this).attr("name");
	        $(this).attr("placeholder", title);
	    } );
	    var table = $('#datatable-filter').DataTable({
	    	"destroy": true,
	    	"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
	    	"bJQueryUI": true,
			"language":idioma_esp,
			ajax: {
				"method":"GET",
				"url":"./SL_Cliente",
				"data": {
			        "carga": 1//para decirle al servlet que cargue solo clinte + consumos
			    },
				"dataSrc":"aaData" 	
			},
			"columns": [
	            { "data": "nombre1"},
	            { "data": "nombre2"},
	            { "data": "apellido1"},
	            { "data": "apellido2"},
	            { "data": "cedula"},
	            {"defaultContent":"<button type='button' style='margin-left:15px;' class='activar btn btn-primary'"
	            +"title='Seleccionar cliente' id='seleccionarCl' >"
				+ "<i class='fa fa-upload'></i> </button>"}
	            ]
	    });
	 
	    // Aplicar la busqueda por columna
	    table.columns().every( function () {
	        var that = this;
	        $( 'input', this.header() ).on( 'keyup change', function () {
	            if ( that.search() !== this.value ) {
	                that.search( this.value) .draw();
	            }
	        } );
	    } );
	    cambiarCliente('#datatable-filter tbody', table);
}

/////////////////////////////funsión que setea el cliente y contrato en los input del formulario////////////////////
function cambiarCliente(tbody, table) {//parametro(id_tabla, objeto dataTable)
	$(tbody).on("click","button#seleccionarCl",function(){
		var datos = table.row($(this).parents("tr")).data();
		console.log(datos);
		$("#nombreClienteCompleto").val(datos.nombre1 + " " + datos.nombre2 + " " + datos.apellido1 + " " + datos.apellido2);
		$("#cliente_ID").val(datos.cliente_ID);
		
		var idCliente = $("#cliente_ID").val();
		
		if (idCliente != 0 || idCliente == ""){
			activarSelect("#concepto");
			$('#abrir_modal').attr("disabled", true);
		}else{
			if (idCliente == 0 || idCliente == ""){
				desactivarSelect("#concepto");
				$('#abrir_modal').attr("disabled", false);
			}
			
		}	
		CloseModalBox();
	});
}

function cargarSelectFactura(select) {//parametro id select
	var datos;
	//var cliente_ID_view;
	var total;
	var cliente_ID_form = $("#cliente_ID").val();
 	$.ajax({
         type: "GET",
         url: "./SL_ReciboCaja",
         dataType: "json",
         data: {"cliente_ID": cliente_ID_form, "idserie" : 1},
         success: function(response)
         {	
         	$(response.aaData).each(function(i, v) {
             		datos = response.aaData;
                 	$(select).empty();
                 	$(select).append("<option value=''>--Seleccione la factura--</option>");
                 	$(response.aaData).each(function(i, v) {
                 			$(select).append('<option value="' + v.numFact + '">' + v.numFact +'</option>');
                 			
         			});
                 	activarChangeFactura("#factura", response.aaData);             	
      			console.log("id cliente form: " + cliente_ID_form );
 			});  	        	
         }
 	});
}

function cargarSelectReconexion(select) {//parametro id select
	var datos;
	//var cliente_ID_view;
	var total;
	var cliente_ID_form = $("#cliente_ID").val();
 	$.ajax({
         type: "GET",
         url: "./SL_ReciboCaja",
         dataType: "json",
         data: {"cliente_ID": cliente_ID_form, "idserie" : 3},
         success: function(response)
         {	
         	$(response.aaData).each(function(i, v) {
             		datos = response.aaData;
                 	$(select).empty();
                 	$(select).append("<option value=''>--Seleccione la orden de reconexion--</option>");
                 	$(response.aaData).each(function(i, v) {
                 			$(select).append('<option value="' + v.numFact + '">' + v.numFact +'</option>');
                 			
         			});
                 	activarChangeFactura("#factura", response.aaData);             	
      			console.log("id cliente form: " + cliente_ID_form );
 			});  	        	
         }
 	});
}

function cargarSelectContrato(select) {//parametro id select
	var datos;
	var cliente_ID_view;
	var cliente_ID_form = $("#cliente_ID").val();
 	$.ajax({
         type: "GET",
         url: "./SL_ReciboCaja",
         dataType: "json",
         data: {"cliente_ID": cliente_ID_form, "idserie" : 2},
         success: function(response)
         {	
         	$(response.aaData).each(function(i, v) {
             		datos = response.aaData;
                 	$(select).empty();
                 	$(select).append("<option value=''>--Seleccione el contrato--</option>");
                 	$(response.aaData).each(function(i, v) {
                 			$(select).append('<option value="' + v.numContrato + '">' +"No. Contrato: " + v.numContrato + " - " + "No. Medidor: " + v.numMedidor +'</option>');
         			});
             		           	
      			console.log("id cliente form: " + cliente_ID_form );
 			});  	        	
         }
 	});
}

$(function () {
    $.datepicker.setDefaults($.datepicker.regional["es"]);
    $("#input_date").datepicker({
        dateFormat: 'yy/mm/dd',
        firstDay: 1
    }).datepicker("setDate", new Date());
 });

function activarChangeFactura(select, response) {
	$(select).change(function(){
		var factura = $("#factura").val();
		console.log("numfact selected: " + factura);
		$(response).each(function(i, v) {
 			if(factura == v.numFact){
 				console.log("resultado");
 				$("#montoTotal").val(v.pagoTotal);
 			}
		});
	});
}

////////////////////////////función que activa el evento change del select de concepto///////////////////
function activarChange(select) {
	$(select).change(function(){//cuando se elija otra opcion del select
		var concepto = $(select).val();
		console.log("id del concepto: " + concepto)
	 	if(concepto == 1){
			cargarSelectFactura("#factura");
			desactivarSelect("#contrato");
			desactivarSelect("#reconexion");
			activarSelect("#factura");
	 	}else if(concepto == 2){
			cargarSelectContrato('#contrato');
			desactivarSelect("#factura");
			desactivarSelect("#reconexion");
			activarSelect('#contrato');		
		}else if(concepto == 3){
			cargarSelectReconexion('#reconexion');
			desactivarSelect("#factura");
			desactivarSelect("#contrato");
			activarSelect("#reconexion");
		}else if(concepto == null || concepto == 0){
			desactivarSelect("#factura");
			desactivarSelect("#contrato");
			desactivarSelect("#reconexion");
		}
	});
}

$(document).ready(function() {
	// Add slider for change test input length
	FormLayoutExampleInputLength($( ".slider-style" ));
	// Initialize datepicker
	//$('#input_date').datepicker({setDate: new Date()});
	// Load Timepicker plugin
	LoadTimePickerScript(DemoTimePicker);
	// Add tooltip to form-controls
	$('.form-control').tooltip();
	LoadSelect2Script(DemoSelect2);
	// Load example of form validation
	LoadBootstrapValidatorScript(DemoFormValidator);
	// Add drag-n-drop feature to boxes
	WinMove();
	activarChange("#concepto");
	
	//cargar scripts dataTables
	LoadDataTablesScripts2();
	
	desactivarSelect("#contrato");
	desactivarSelect("#reconexion");
	desactivarSelect("#factura");
	desactivarSelect("#concepto");
	
	
	//MODAL para mostrar una tabla con el cliente y en contrato
	$('#abrir_modal').on('click',function(e) {
		OpenModalBox(
		"<div><h3>Buscar Cliente</h3></div>",
		"<div class='table-responsive'>"
		+ "<table class='table table-bordered table-striped table-hover table-heading table-datatable'"+
		"id='datatable-filter'>"
		+ "<thead>"
		+ "<tr>"
		+ "<th><label><input type='text' name='Nombre1'/></label></th>"
		+ "<th><label><input type='text' name='Nombre2'/></label></th>"
		+ "<th><label><input type='text' name='Apellido1'/></label></th>"
		+ "<th><label><input type='text' name='Apellido2'/></label></th>"
		+ "<th><label><input type='text' name='Número de cédula'/></label></th>"
		+ "<th></th>"
		+ "</tr>"														
		+ "</thead>"														
		+ "<tfoot>"														
		+ "<tr> <th Style='color: #5d96c3;'>Nombre1</th>"
		+ "<th Style='color: #5d96c3;'>Nombre2</th>"
		+ "<th Style='color: #5d96c3;'>Apellido1</th>"
		+ "<th Style='color: #5d96c3;'>Apellido2</th>"
		+"<th Style='color: #5d96c3;'>Número de cédula</th>"
		+"<th></th> </tr>"													
		+ "</tfoot>"														
		+ "</table>"														
		+ "</div>",
		"<div Style='text-align: center; margin-bottom: -5px;'><button type='button' class='btn-default btn-label-left btn-lg' "
		+"onclick='CloseModalBox()'><span><i class='fa fa-reply txt-danger'></i></span>Cancelar</button></div>");
		
		filtrarTabla();		
	});
})
</script>
