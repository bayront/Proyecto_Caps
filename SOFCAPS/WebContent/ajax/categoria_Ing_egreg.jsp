	<%@page import="Datos.DT_categoria_Ing_Engre, java.util.*, Entidades.TipoCategoria, java.sql.ResultSet ;"%>
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.html">Dashboard</a></li>
			<li><a href="#">Consumos</a></li>
			<li><a href="#">Crear Consumo</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-search"></i> <span>Registros de consumos</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content">
				<form class="form-horizontal" role="form" id="defaultForm" method="post" action="">

					<div class="form-group">

						<!-- PARA COLOR NEGRO DEJAR CON CLASE *control-label* -->
						<label class="col-sm-4 control-label">Nombre de la categoria:</label>
						<div class="col-sm-4">
							<!-- PARA COLOR NEGRO DEJAR CON CLASE *form-control* -->
							<input  id= "nombreCategoria" name="nombreCategoria" type="text" class="form-control"
								placeholder="" data-toggle="tooltip"
								data-placement="bottom" title="Tooltip para nombre">
						</div>
 
					</div>
					
					<%
						DT_categoria_Ing_Engre dt = DT_categoria_Ing_Engre.getInstance();
						ArrayList<TipoCategoria> lista = new ArrayList<TipoCategoria>();
						lista = dt.listaCategoriaIE();
						
						ResultSet rs = dt.cargarDatosTabla();
						
					%>

					<div class="form-group">
						<label class="col-sm-3 control-label">Tipo de categoria:</label>
						<div class="col-sm-5">
							<select class="populate placeholder" name="tipoCategoria"
								id="tipoCategoria">
								<option value="">-- Seleccione --</option>
								<%
									for(int i = 0; i < lista.size(); i++){
								%>
										<option value="<%=lista.get(i).getTipoCategoria_ID() %>"> <%=lista.get(i).getDescripcion() %></option>
								<%
									}
								%>
							</select>
						</div>
					</div>
					
					<div class="clearfix"></div>
					
					<div class="form-group">
					<!-- Tipos de botones para enviar -->
					
					
						<div class="col-sm-offset-2 col-sm-2">
							<button type="submit" onclick="guardar();" class="btn btn-primary btn-label-left">
								<span><i class="fa fa-download"></i></span> Guardar
							</button>
						</div>
						
						
						<div class="col-sm-offset-2 col-sm-2">
							<button type="cancel" class="btn btn-default btn-label-left">
								<span><i class="fa fa-clock-o txt-danger"></i></span> Cancelar
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name text-center">
					<i class="fa fa-th"></i> <span>Lista caregorias de ingreso y egreso</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar2" class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a id="expandir2" class="expand-link"> <i class="fa fa-expand"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
<!-- 				<div style="display: block; text-align: center;"> -->
<!-- 					<button type="button" class="btn btn-default btn-app-sm btn-circle" id="center_button"> -->
<!-- 						<i class=" fa fa-plus"></i> -->
<!-- 					</button> -->
<!-- 				</div> -->
				<table class="table table-bordered table-striped table-hover table-heading table-datatable"
					id="tbl_CategoriaIE">
					<thead>
						<tr>
							<th>Id</th>
							<th>Nombre de la categoria</th>
							<th>Tipo de la categoria</th>
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>
						<%
							rs.beforeFirst();
					    	while(rs.next())
					    	{
					    %>
					        <tr>
					            <td><%=rs.getInt(1)%></td>
					            <td><%=rs.getString(2)%></td>
					            <td><%=rs.getString(3)%></td>
					            <td>
					            	<button type="button" class="editarConsumo btn btn-primary" data-toggle="tooltip" data-placement="bottom" title="Editar"><i class="fa fa-pencil-square-o"></i> </button>
									<button type="button" class="eliminarConsumo btn btn-danger" data-toggle="tooltip" data-placement="bottom" title="Eliminar"><i class="fa fa-trash-o"></i> </button>
								</td>					            
					        </tr>
					      <%
					      	} 
					      %>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<div>
	<form id="frmEliminarCategoria" action="" method="POST">
		<input type="hidden" id="tarifa_ID" name="tarifa_ID" value="">
		<input type="hidden" id="opcion" name="opcion" value="eliminar">

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
	</form>
</div>

<script type="text/javascript">
	
	// Run Select2 plugin on elements
	function DemoSelect2() {
		
		$('#tipoCategoria').select2();
	}
	
	
	function cargarValoresDataTable(id, nombre, descripcion)
	{
		
	}
	

	function guardar()
	{
		var nombreCategoria ="";
		var tipoCategoria = "";
		
		nombreCategoria = $("#nombreCategoria").val();
		tipoCategoria = $("#tipoCategoria").val();
		
		$.ajax
		({
			url: "SL_ajax_table_categoriaIE",
			type: "post",
			datatype: 'html',
			data: {'nombreCategoria' :nombreCategoria, 'tipoCategoria':tipoCategoria},
			success: function(data)
			{
				$('#tbl_CategoriaIE').html(data);
				$('#tbl_CategoriaIE').dataTable().fnDestroy();
				$('#tbl_CategoriaIE').dataTable();
 				LoadDataTablesScripts(AllTables);
 				$('#tbl_CategoriaIE').dataTable({ 
 					"aaData": orgContent,
 		            "bLengthChange": true //used to hide the property  
					
 				});
			}
			
		});
		
	}
	
</script>
	<script type="text/javascript">
	var listarT = function() {
		$('#tbl_CategoriaIE').dataTable({
			"destroy": true,
			'bProcessing': false,
			'bServerSide': false,
			//ajax: {
			//	"method":"GET",
			//	"url":"./SL_consumo",
			//	"data": {
			 //       "carga": 1//para decirle al servlet que cargue consumos + cliente + contrato
			  //  },
			//	"dataSrc":"aaData"
			//},
			"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
        	"bJQueryUI": true,
			"language":idioma_esp,
// 			"columns": [
// 	            { "data": "fecha_fin" },
// 	            { "data": "lectura_Actual" },
// 	            { "data": "consumoTotal" },
// 	            { "data": "cliente.nombreCompleto" },
// 	            { "data": "contrato.numContrato" },
// 	            { "data": "contrato.numMedidor" },
// 	            {"defaultContent":"<button type='button' class='editarConsumo btn btn-primary' data-toggle='tooltip' "+
// 					"data-placement='bottom' title='Editar'>"+
// 					"<i class='fa fa-pencil-square-o'></i> </button>  "+
// 					"<button type='button' class='eliminarConsumo btn btn-danger' data-toggle='tooltip' "+
// 					"data-placement='bottom' title='Eliminar'>"+
// 					"<i class='fa fa-trash-o'></i> </button>"}
// 	            ],
				"sDom":"Bfrtip",
// 	            "dom":"<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
// 					 +"<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
// 					 +"<rt>"
// 					 +"<'row'<'form-inline'"
// 					 +"<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",
	            "buttons":[{
					"text": "<i class='fa fa-user-plus'></i>",
					"titleAttr": "Agregar usuario",
					"className": "btn btn-success",
					"action": function() {
						agregar_nuevo_consumo();
					}
				},
				{
	                extend:    'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o"></i>',
	                titleAttr: 'excel'
	            },
	            {
	                extend:    'csvHtml5',
	                text:      '<i class="fa fa-file-text-o"></i>',
	                titleAttr: 'csv'
	            },
	            {
	                extend:    'pdfHtml5',
	                text:      '<i class="fa fa-file-pdf-o"></i>',
	                titleAttr: 'pdf'
	            }]
		});
	}

	function AllTables() {
		//cargar PDF Y EXCEL
		$.getScript('plugins/jquery/jquery-2.1.0.min.js', function(){
			$.getScript('plugins/datatables/nuevo/jquery.dataTables.js', function(){
				$.getScript('plugins/datatables/nuevo/jszip.min.js', function(){
					$.getScript('plugins/datatables/nuevo/pdfmake.min.js',function(){
						$.getScript('plugins/datatables/nuevo/vfs_fonts.js',function(){
							console.log("PDF Y EXCEL cargado");
							listarT();
						});
					});
				});
			});
		});
		//LoadSelect2Script(MakeSelect2);
	}
	
	$(document).ready(function() {
		
		LoadDataTablesScripts(AllTables);
		//crear los datepickers
		LoadTimePickerScript(AllTimePickers);
		// Create UI spinner
		$("#ui-spinner").spinner();
		
		// Create Wysiwig editor for textare
		TinyMCEStart('#wysiwig_simple', null);
		TinyMCEStart('#wysiwig_full', 'extreme');
		// Add slider for change test input length
		FormLayoutExampleInputLength($(".slider-style"));
		// Initialize datepicker
		$('#input_date').datepicker({
			setDate : new Date()
		});
		// Add tooltip to form-controls
		$('.form-control').tooltip();
		LoadSelect2Script(DemoSelect2);
		// Load example of form validation
		LoadBootstrapValidatorScript(DemoFormValidator);
		// Add drag-n-drop feature to boxes
		WinMove();
		
	});
</script>