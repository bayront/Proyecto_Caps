<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.html">Tarifa</a></li>
			<li><a href="#">Crear tarifa</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
		
		
	<!-- AQUI INICIA EL DIV PARA EL TITULO-->
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-search"></i> <span>Crear Tarifa</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			
			<div class="box-icons">
					<a id="colapsar_desplegar1" class="collapse-link"> <i
						class="fa fa-chevron-up"></i></a> <a id="expandir1"
						class="expand-link"> <i class="fa fa-expand"></i></a>
				</div>
			

			<div class="box-content">
				 
					
				<form class="form-horizontal" role="form" id="formTarifa" method="post" action="validators.html">
				
					<input type="hidden" id="opcion" name="opcion" value="guardar">
					<input type="hidden" id="actual" name="actual"> 
					<input type="hidden" id="Tarifa_ID" name="Tarifa_ID">
					<div class="form-group">
						<label class="col-sm-2 control-label text-info">limite Inferior</label>
						<div class="col-sm-5"><input id="lim_Inf" name="lim_Inf" type="text" class="form-control"  autofocus></div>
					</div> 
					<div class="form-group">
						<label class="col-sm-2 control-label text-info">Limite Superior</label>
							<div class="col-sm-5"><input id="lim_Sup" name="lim_Sup" type="text" class="form-control" ></div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label text-info">monto</label>
							<div class="col-sm-5"><input id="monto" name="monto" type="text" class="form-control" ></div>
					</div>
					
<!-- 					<div class="form-group"> -->
<!-- 						<label for="Tarifa_ID" class="col-sm-2 control-label text-info">Tarifa ID</label> -->
<!-- 						<div class="col-sm-5"><input id="Tarifa_ID" name="Tarifa_ID" type="text" class="form-control" maxlength="8" ></div> -->
<!-- 					</div> -->
						
						
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-3">
							<button  id="btnEnviar" type="submit" class="btn btn-info btn-label-left">
								<span><i class="glyphicon glyphicon-save text-info"></i></span><font color="black">Guardar</font>
							</button>
						</div>
					<div class="col-sm-3">
							<button type="button" class="btn btn-info btn-label-left" onclick="cancelar();">
								<span><i class="fa fa-clock-o txt-info"></i></span><font color="black"> Cancelar</font>
							</button>
						</div>
					</div>
						
						
					<div class="col-sm-offset-2 col-sm-8">
							<p class="mensaje"></p>
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
					<i class="fa fa-th"></i> <span>Lista de Tarifas</span>
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
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="tabla_tarifa">
					<thead>
						<tr>
							<th>Limite Inferior</th>
							<th>Limite Superior</th>
							<th>Monto</th>
							<th></th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>

<div>
	<form id="frmEliminarTarifa" action="" method="POST">
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
	// Iniciar dataTables
	function AllTables() {
		//cargar PDF Y EXCEL
		$.getScript('plugins/datatables/nuevo/jszip.min.js', function(){
			$.getScript('plugins/datatables/nuevo/pdfmake.min.js',function(){
				$.getScript('plugins/datatables/nuevo/vfs_fonts.js',function(){
					console.log("PDF Y EXCEL cargado");
					iniciarTabla();
				});
			});
		});
		LoadSelect2Script(MakeSelect2);
	}
	
	function MakeSelect2() {
		$('select').select2();
		$('.dataTables_filter').each(
				function() {
					$(this).find('label input[type=text]').attr('placeholder',
							'Buscar');
				});
	}
	
// 	function abrirDialogo() {
// 		OpenModalBox(
// 				"<div><h3>Borrar Tarifa</h3></div>",
// 				"<p Style='text-align: center;'>Esta seguro de borrar esta tarifa?</p>",
// 				"<div Style='text-align: center; margin-bottom: -10px;'>"+
// 				"<button type='button' id='eliminar_tarifa' class='btn btn-primary' onclick='CloseModalBox()'>Borrar </button>"
// 				+ "<button type='button' class='btn btn-secondary' Style='margin-left: 10px;' onclick='CloseModalBox()'> Cancelar</button>"
// 				+ "</div>");
// 	}

	$(document).ready(function() {

		//cargar scripts dataTables
		LoadDataTablesScripts2(AllTables);
		
		// Crear UI spinner
		$("#ui-spinner").spinner();

		// Inicializar DatePicker
		$('#fecha_fin').datepicker({
		setDate : new Date()
		});
	
		// Añadir Tooltip para formularios
		$('.form-control').tooltip();

		//Cargar ejemplo para validaciones
		LoadBootstrapValidatorScript(DemoFormValidator);

		//MODALS
		$('#abrir_modal').on('click',function(e) {
			OpenModalBox(
			"<div><h3>Buscar Tarifa</h3></div>",
			"<div class='table-responsive'>"
			+ "<table class='table table-bordered table-striped table-hover table-heading table-datatable'"+
			"id='datatable-filter'>"
			+ "<thead>"
			+ "<tr>"
			+ "<th><label><input type='text' name='lim_Inf'/></label></th>"
			+ "<th><label><input type='text' name='lim_Sup'/></label></th>"
			+ "<th><label><input type='text' name='monto'/></label></th>"
			+ "<th></th>"
			+ "</tr>"														
			+ "</thead>"														
			+ "<tbody>"														
			+ "<tr><td>1</td><td>Ubuntu</td><td>16%</td><td></td></tr>"														
			+ "<tr><td>2</td><td>Debian</td><td>14.1%</td><td></td></tr>"														
			+ "<tr><td>3</td><td>Arch Linux</td><td>10.8%</td><td></td></tr>"														
			+ "</tbody>"														
			+ "<tfoot>"														
			+ "<tr><th Style='color: #5d96c3;'>Limite Inferior</th>"+
			"<th Style='color: #5d96c3;'>Limite Superior</th>"+
			"<th Style='color: #5d96c3;'>Monto</th><th></th></tr>"														
			+ "</tfoot>"														
			+ "</table>"														
			+ "</div>",
			"<div Style='text-align: center; margin-bottom: -10px;'><button type='button' class='btn btn-secondary' onclick='CloseModalBox()'>Cancelar</button></div>");
			filtrarTabla();		
		});
	
		// Add Drag-n-Drop feature				
		WinMove();	
		
		//add tooltip
		$('[data-toggle="tooltip"]').tooltip();
	});
	
	function filtrarTabla(){
		    // Setup - add a text input to each footer cell
		    $('#datatable-filter thead th label input').each( function () {
		        var title = $(this).attr("name");
		        $(this).attr("placeholder", "Buscar por " + title);
		    } );
		 
		    // DataTable
		    var table = $('#datatable-filter').DataTable({
		    	"destroy": true,
		    	"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
		    	"bJQueryUI": true,
				"language":idioma_esp,
				"columns": [
		            { "data": "lim_Inf" },
		            { "data": "lim_Sup" },
		            { "data": "monto" },
		            {"defaultContent":"<button type='button' class='seleccionar btn btn-primary'>"+
						"Seleccionar</button>"}
		            ],
		    });
		 
		    // Apply the search
		    table.columns().every( function () {
		        var that = this;
		        $( 'input', this.header() ).on( 'keyup change', function () {
		            if ( that.search() !== this.value ) {
		                that.search( this.value) .draw();
		            }
		        } );
		    } );
	}
	
	function iniciarTabla(){
		colapsar_desplegar($("#colapsar_desplegar1"));
		console.log("cargando dataTable");
		var tablaTarifa = $('#tabla_tarifa').DataTable( {
			"destroy": true,
			'bProcessing': false,
			'bServerSide': false,
// 			"aaSorting": [[ 0, "asc" ]],
 	//		"sDom": "T<'box-contents'<'col-sm-4'f><'col-sm-4'B><'col-sm-4 text-right'l><'clearfix'>>rt<'box-content'<'col-sm-6'i><'col-sm-6 text-right'p><'clearfix'>>",
			"ajax": {
				"method":"GET",
				"url":"./SL_tarifa",
 				"dataSrc":"aaData"
			},
			"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
// 			"sAjaxSource": "./SL_consumo",
        	"bJQueryUI": true,
//         	pagingType: 'full_numbers',	
			"language":idioma_esp,
// 			"oLanguage":idioma_esp,
			"columns": [
	            { "data": "lim_Inf" },
	            { "data": "lim_Sup" },
	            { "data": "monto" },
	            {"defaultContent":"<button type='button' class='editarTarifa btn btn-primary' data-toggle='tooltip' "+
					"data-placement='bottom' title='Editar Tarifas'>"+
					"<i class='fa fa-pencil-square-o'></i> </button>  "+
					
					"<button type='button' class='eliminar btn btn-danger'>"+
					"<i class='fa fa-trash-o'></i>"+
					"</button>"}
					
	            ],
	            "dom":"<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
					 +"<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
					 +"<rt>"
					 +"<'row'<'form-inline'"
					 +"<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",//'Bfrtip',
// 				"dom": 'Bfrtip',
	            "buttons":[{
					"text": "<i class='fa fa-user-plus'></i>",
					"titleAttr": "Agregar tarifa",
					"className": "btn btn-success",
					"action": function() {
						agregar_nuevo_tarifa();
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
//
		obtener_datos_editar('#tabla_tarifa tbody', tablaTarifa);
		obtener_id_eliminar('#tabla_tarifa tbody', tablaTarifa);

	}
	
	var agregar_nuevo_tarifa = function() {
		limpiar_texto();
		colapsar_desplegar($("#colapsar_desplegar2"));
		colapsar_desplegar($("#colapsar_desplegar1"));
	}
	
	var cancelar = function() {
		limpiar_texto();
		colapsar_desplegar($("#colapsar_desplegar1"));
		colapsar_desplegar($("#colapsar_desplegar2"));
	}
	
	var guardar = function() {
	$("#formTarifa").on("submit", function(e) { //recordar numeral
		e.preventDefault();//detiene el evento
		var frm = $(this).serialize();//parsea los datos del formulario
		console.log(frm);
		$.ajax({//enviar datos por ajax
			method:"post",
			url:"./SL_tarifa",
			data: frm//datos a enviar
			}).done(function(info) {//informacion que el servlet le reenvia al jsp
			console.log(info);
//				mostrar_mensaje(info);//se envia a verificar que mensaje respondioel servlet
				limpiar_texto();
				iniciarTabla();//volver a listar datos
			});
		});
	}
	$(document).ready(function() {
		// Create UI spinner
		$("#ui-spinner").spinner();
		
		// Add tooltip to form-controls
		$('body').tooltip();
		// Load example of form validation
		LoadBootstrapValidatorScript(DemoFormValidator);
		// Add drag-n-drop feature to boxes
		WinMove();
		guardar();//activar evento de guardar
		limpiar_texto();
		
	});
	
	var obtener_datos_editar = function(tbody, table) {
		$(tbody).on("click", "button.editarTarifa", function() {//activar evento click en boton actualizar que esta en el dataTable
			var datos = table.row($(this).parents("tr")).data();//obtener la fila tr que es padre del boton que se toco y oobtener datos
			console.log(datos);
			var lim_Inf = $("#lim_Inf").val(datos.lim_Inf);
			var lim_Sup = $("#lim_Sup").val(datos.lim_Sup);
			var monto =	$("#monto").val(datos.monto);
			var Tarifa_ID = $("#Tarifa_ID").val(datos.tarifa_ID);
			var opcion = $("#opcion").val("actualizar");//settear datos en el formulario de edicion
			console.log($("#opcion").val());
			colapsar_desplegar($("#colapsar_desplegar1"));
			colapsar_desplegar($("#colapsar_desplegar2"));
		});
	}
	
	function abrirDialogo() {
		OpenModalBox(
				"<div><h3>Borrar Tarifa</h3></div>",
				"<p Style='text-align: center;'>Esta seguro de borrar esta tarifa?</p>",
				"<div Style='text-align: center; margin-bottom: -10px;'>"+
				"<button type='button' id='eliminar_tarifa' class='btn btn-primary'>Borrar </button>"
				+ "<button type='button' class='btn btn-secondary' Style='margin-left: 10px;' onclick='CloseModalBox()'> Cancelar</button>"
				+ "</div>");
		eliminar();
	}
	
	var obtener_id_eliminar = function(tbody, table) {
		$(tbody).on("click", "button.eliminar", function() {
			var datos = table.row($(this).parents("tr")).data();//mismo evento para el boton eliminar
			console.log(datos);	
			var tarifa_ID = $("#frmEliminarTarifa #tarifa_ID").val(datos.tarifa_ID);//solo se obtiene el id que es oculto
			abrirDialogo();
		});
	}
	
	var eliminar = function() {
		$("#eliminar_tarifa").on("click", function() {
// 			var usuario_id= $("#frmEliminarTarifa #tarifa_ID").val();//se obtiene el id del usuario que esta oculto
// 			var opcion = $("#frmEliminarTarifa #opcion").val();//se obtiene la opcion que esta oculta
			frmElim = $("#frmEliminarTarifa").serialize();
			console.log("datos a eliminar: " + frmElim);
			$.ajax({
				method:"POST",
				url:"SL_tarifa",
				data: frmElim
			}).done(function(info) {
// 			mostrar_mensaje(info);
				iniciarTabla();
				console.log(info);
			});
			CloseModalBox();
		});
	}
	
</script>
<script type="text/javascript">
	
// 	var guardar = function() {
// 	$("#defaultForm").on("submit", function(e) { //recordar numeral
// 		e.preventDefault();//detiene el evento
// 		var frm = $(this).serialize();//parsea los datos del formulario
// 		$.ajax({//enviar datos por ajax
// 			method:"post",
// 			url:"./SL_tarifa",
// 			data: frm//datos a enviar
// 			}).done(function(info) {//informacion que el servlet le reenvia al jsp
// 			console.log(info);
// //				mostrar_mensaje(info);//se envia a verificar que mensaje respondioel servlet
// //				limpiar_texto();
// 			//listar();//volver a listar datos
		
// 			});
// 		});
// 	}
	var limpiar_texto = function() {//limpiar texto del formulario
		$("#opcion").val("guardar");
		$("#lim_Inf").val("");
		$("#lim_Sup").val("");
		$("#monto").val("");
		//$("#Tarifa_ID").val("");
	}
	
	$(document).ready(function() {
		// Create UI spinner
		$("#ui-spinner").spinner();
		
		// Add tooltip to form-controls
		$('body').tooltip();
		// Load example of form validation
		LoadBootstrapValidatorScript(DemoFormValidator);
		// Add drag-n-drop feature to boxes
		WinMove();
//  		guardar();//activar evento de guardar
		limpiar_texto();
		
	});
	
//al hacer click al boton listar volver a llenar los datos en el dataTable
// 	$("#btn_listar").on("click", function() {
// 		$("#cuadro2").slideUp("slow");
// 		$("#cuadro1").slideDown("slow");
// 		listar();//listar al presionar boton del formulario de registro
// 	});
	
	
	//metodo guardar donde activa el evento submit del formulario de registro
	
	//revise los mensaje que envian el guardar y eliminar (metodos)
	var mostrar_mensaje = function(info) {
		var text ="", color="";
		console.log("info: " + info.respuesta);
		if (info.respuesta =="BIEN"){//si la respuesta fue BIEN pasa el if y luego
			texto="<strong>Bien!</strong>, se guardaron los cambios";
			color = "#379911";
			$("#formTarifa");
// 			$("#cuadro1").slideDown("slow");
			websocket.send("ACTUALIZADO");//se envia un mensaje al serverendpoint para que avise actualizar a las otras sesiones
			limpiar_texto();
		}
		else if(info.respuesta =="ERROR"){
			texto="<strong>ERROR</strong>, no se ejecuto la consulta correctamente";
			color = "#C9302C";
		}else if(info.respuesta =="ACTUALIZADO"){//aqui se resive la respuesta del serverendpoint y todos las sesiones se actualizan
			texto="<strong>DATO ACTUALIZADOS</strong>, otro usuario ha actualizado la base de datos";
			color = "#ea8f1a";
			listar();//actulizar datos del datatable
		}else{
			texto="<strong>Opcion vacia!</strong>, opcion no solicitada";
			color = "#ddblld";
		}
		$(".mensaje").html(texto).css({"color":color});
		$(".mensaje").fadeOut(7000, function() {//se muestra el mensaje por un tiempo y luego se oculta
			$(this).fadeIn(5000);
			$(this).html("");
		});
	}
	
	
	
</script>