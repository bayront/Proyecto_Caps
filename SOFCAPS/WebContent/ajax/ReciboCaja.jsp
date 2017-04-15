<%@page import="Entidades.Factura_Maestra"%>
<%@page import="Entidades.Contrato"%>
<%@page import="Entidades.Reconexion"%>
<%@page import="Entidades.Serie"%>
<%@page import="Datos.DT_reciboCaja, java.util.*, java.sql.ResultSet;"%>
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
					<i class="fa fa-search"></i> <span>Recibo de caja</span>
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
				<form class="form-horizontal" role="form">
					<input type="hidden" id="cliente_ID" name="cliente_ID">
					<div class="form-group has-error has-feedback">
						<label class="col-sm-2 control-label">Fecha:</label>
						<div class="col-sm-3">
							<input type="text" id="input_date" class="form-control"
								placeholder="Date"> <span
								class="fa fa-calendar txt-danger form-control-feedback"></span>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">Nombre del cliente:</label>
						<div class="col-sm-5">
							<input id = "nombreClienteCompleto" type="text" class="form-control" placeholder="Seleccione el nombre del cliente"
								data-toggle="tooltip" data-placement="bottom"
								title="Nombre completo del cliente">
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
							
							ArrayList<Factura_Maestra> listaFacturas = new ArrayList<Factura_Maestra>();
							listaFacturas = rc.listaFacturas();
							
							ArrayList<Contrato> listaContratos = new ArrayList<Contrato>();
							listaContratos = rc.listaContratos();
							
							ArrayList<Reconexion> listaReconexiones = new ArrayList<Reconexion>();
							listaReconexiones = rc.listaReconexiones();
						%>
					
							<label class="col-sm-2 control-label">En concepto de:</label>
								<div class="col-sm-5">
									<select id="concepto" class="populate placeholder">
									<%
										for(int i = 0; i < listaSeries.size(); i++){
										%>
											<option value="<%=listaSeries.get(i).getIdserie() %>"> <%=listaSeries.get(i).getSignificado() %></option>
										<%
										}
									%>	
									</select>
								</div>
						</div>
						
						<div class="clearfix"></div>
						
						<div class="form-group has-success has-feedback">
							<label class="col-sm-2 control-label">Contratos:</label>
								<div class="col-sm-5">
									<select id="contrato"
										class="populate placeholder">
											<%
										for(int i = 0; i < listaContratos.size(); i++){
										%>
											<option value="<%=listaContratos.get(i).getContrato_ID() %>"> <%=listaContratos.get(i).getNumContrato() %></option>
										<%
										}
									%>
									</select>
								</div>
						</div>
						
						<div class="form-group has-success has-feedback">
							<label class="col-sm-2 control-label">Facturas: </label>
								<div class="col-sm-5">
									<select id="factura"
										class="populate placeholder">
											<%
										for(int i = 0; i < listaFacturas.size(); i++){
										%>
											<option value="<%=listaFacturas.get(i).getFactura_Maestra_ID() %>"> <%=listaFacturas.get(i).getNumFact() %></option>
										<%
										}
									%>
									</select>
								</div>
						</div>
						
						<div class="form-group has-success has-feedback">
							<label class="col-sm-2 control-label">Reconexiones: </label>
								<div class="col-sm-5">
									<select id="reconexion"
										class="populate placeholder">
											<%
										for(int i = 0; i < listaReconexiones.size(); i++){
										%>
											<option value="<%=listaReconexiones.get(i).getReconexion_ID() %>"> <%=listaReconexiones.get(i).getReconexion_ID() %></option>
										<%
										}
									%>
									</select>
								</div>
						</div>
	
					
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-2">
							<button type="cancel" class="btn btn-default btn-label-left">
								<span><i class="fa fa-clock-o txt-danger"></i></span> Cancel
							</button>
						</div>
						<div class="col-sm-2">
							<button type="submit" class="btn btn-warning btn-label-left">
								<span><i class="fa fa-clock-o"></i></span> Send later
							</button>
						</div>
						<div class="col-sm-2">
							<button type="submit" class="btn btn-primary btn-label-left">
								<span><i class="fa fa-clock-o"></i></span> Submit
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
	$('#s2_with_tag').select2({placeholder: "Seleccione categaria..."});
	$('#concepto').select2();
	$('#contrato').select2();
	$('#factura').select2();
	$('#reconexion').select2();
}
// Run timepicker
function DemoTimePicker(){
	$('#input_time').timepicker({setDate: new Date()});
}
	
///////////////////funsión que crea un dataTable para traer en cliente mediante un dialogo////////////
function filtrarTabla(){
	console.log("buscarCliente");
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
			        "carga": 1//para decirle al servlet que cargue solo clinte
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
		console.log("cambiar cliente");
		var datos = table.row($(this).parents("tr")).data();
		console.log(datos);
		$("#nombreClienteCompleto").val(datos.nombre1 + " " + datos.nombre2 + " " + datos.apellido1 + " " + datos.apellido2);
		$("#cliente_ID").val(datos.cliente_ID);
		
		CloseModalBox();
	});
}

$(document).ready(function() {
	// Add slider for change test input length
	FormLayoutExampleInputLength($( ".slider-style" ));
	// Initialize datepicker
	$('#input_date').datepicker({setDate: new Date()});
	// Load Timepicker plugin
	LoadTimePickerScript(DemoTimePicker);
	// Add tooltip to form-controls
	$('.form-control').tooltip();
	LoadSelect2Script(DemoSelect2);
	// Load example of form validation
	LoadBootstrapValidatorScript(DemoFormValidator);
	// Add drag-n-drop feature to boxes
	WinMove();
	
	//cargar scripts dataTables
	LoadDataTablesScripts2();
	
	//MODAL para mostrar una tabla con el cliente
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
