<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.html">Usuario</a></li>
			<li><a href="#">Crear usuario</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
		
		
				<div class="box-header">
						<div class="box-name">
							<i class="fa fa-search"></i> <span>Crear Usuario</span>
						</div>
						<div class="box-icons">
							<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
							</a> <a class="expand-link"> <i class="fa fa-expand"></i>
							</a>
						</div>
						<div class="no-move"></div>
				</div>


				<div class="box-content">
				
				<form class="form-horizontal" role="form" id="defaultForm" method="POST" action="validators.html">
				
					<input type="hidden" id="opcion" name="opcion" value="guardar">
					<input type="hidden" id="actual" name="actual"> 
					<input type="hidden" id="Usuario_ID" name="Usuario_ID">
					
					
					<div class="form-group">
						<label class="col-sm-2 control-label text-info">Login</label>
						<div class="col-sm-5"><input id="login" name="login" type="text" class="form-control"  autofocus></div>
					</div> 
					<div class="form-group">
						<label class="col-sm-2 control-label text-info">Password</label>
							<div class="col-sm-5"><input id="pass" name="pass" type="text" class="form-control" ></div>
					</div>
					
					<div class="form-group">
						<div class="col-sm-5"><input type="hidden" id="usuario_id" name="usuario_id" type="text" 
						class="form-control" maxlength="8" ></div>
					</div>
					
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
					<i class="fa fa-th"></i> <span>Lista de Usuario</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar2" class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a id="expandir2" class="expand-link"> <i class="fa fa-expand"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
				<input type="hidden" id="usuario_id" name="usuario_id">
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="tabla_usuario">
					<thead>
						<tr>
							<th>Login</th>
							<th>Password</th>
							<th></th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<div>
	<form id="frmEliminarUsuario" action="" method="POST">
		<input type="hidden" id="usuario_id" name="usuario_id" value="">
		<input type="hidden" id="opcion" name="opcion" value="eliminar">

<!-- 		Modal -->
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

	/*
	function DemoSelect2() {
		$('#s2_with_tag').select2({
			placeholder : "Select OS"
		});
		$('#s2_rol').select2();
	}*/
	
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
	
	function abrirDialogo() {
		OpenModalBox(
				"<div><h3>Borrar Usuario</h3></div>",
				"<p Style='text-align: center;'>Esta seguro de borrar este usuario?</p>",
				"<div Style='text-align: center; margin-bottom: -10px;'>"+
				"<button type='button' id='eliminar_usuario' class='btn btn-primary' onclick='CloseModalBox()'>Borrar </button>"
				+ "<button type='button' class='btn btn-secondary' Style='margin-left: 10px;' onclick='CloseModalBox()'> Cancelar</button>"
				+ "</div>");
		eliminar();
		
	}
	
	var eliminar = function(){
		$("#eliminar_usuario").on("click", function(){
			frmElim= $("#frmEliminarUsuario").serialize();
			console.log("datos a eliminar: " + frmElim);
			$.ajax({
				method:"POST",
				url:"SL_Usuario",
				data: frmElim
			}).done(function(info){
				iniciarTabla();
				console.log(info);
			});
			
			CloseModalBox();
			
		});
		
	}
	
	$(document).ready(function() {

		//cargar scripts dataTables
		LoadDataTablesScripts2(AllTables);
		
		// Crear UI spinner
		$("#ui-spinner").spinner();
	
		// Añadir Tooltip para formularios
		$('.form-control').tooltip();

		//Cargar ejemplo para validaciones
		LoadBootstrapValidatorScript(DemoFormValidator);

		//MODALS
		$('#abrir_modal').on('click',function(e) {
			OpenModalBox(
			"<div><h3>Buscar Usuario</h3></div>",
			"<div class='table-responsive'>"
			+ "<table class='table table-bordered table-striped table-hover table-heading table-datatable'"+
			"id='datatable-filter'>"
			+ "<thead>"
			+ "<tr>"
			+ "<th><label><input type='text' name='login'/></label></th>"
			+ "<th><label><input type='text' name='pass'/></label></th>"
			+ "<th></th>"
			+ "</tr>"														
			+ "</thead>"														
			+ "<tbody>"														
			+ "<tr><td>1</td><td>Ubuntu</td><td>16%</td><td></td></tr>"														
			+ "<tr><td>2</td><td>Debian</td><td>14.1%</td><td></td></tr>"														
			+ "<tr><td>3</td><td>Arch Linux</td><td>10.8%</td><td></td></tr>"														
			+ "</tbody>"														
			+ "<tfoot>"														
			+ "<tr><th Style='color: #5d96c3;'>Primer Nombre</th>"+
			"<th Style='color: #5d96c3;'>Primer Apellido</th>"+
			"<th Style='color: #5d96c3;'>Medidor</th><th></th></tr>"														
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
	            { "data": "login" },
	            { "data": "pass" },
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
	        });
	    });
	}	
	
	
	function iniciarTabla(){
		colapsar_desplegar($("#colapsar_desplegar1"));
		console.log("cargando dataTable");
		var tablaUsuario = $('#tabla_usuario').DataTable( {
			"destroy": true,
			'bProcessing': false,
			'bServerSide': false,
			ajax: {
				"method":"GET",
				"url":"./SL_Usuario",
			},
			"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
        	"bJQueryUI": true,
			"language":idioma_esp,
			"columns": [
	            { "data": "login" },
	            { "data": "pass" },
	            {"defaultContent":"<button type='button' class='editarConsumo btn btn-primary' data-toggle='tooltip' "+
					"data-placement='bottom' title='Editar'>"+
					"<i class='fa fa-pencil-square-o'></i> </button>  "+
					"<button type='button' class='eliminar btn btn-danger' data-toggle='tooltip' "+
					"data-placement='bottom' title='Eliminar'>"+
					"<i class='fa fa-trash-o'></i> </button>"}
	            ],
	            "dom":"<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
					 +"<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
					 +"<rt>"
					 +"<'row'<'form-inline'"
					 +"<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",
	            "buttons":[{
					"text": "<i class='fa fa-user-plus'></i>",
					"titleAttr": "Agregar usuario",
					"className": "btn btn-success",
					"action": function() {
						agregar_nuevo_consumo();
					}
				},{
	                extend:    'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o"></i>',
	                titleAttr: 'excel'
	            },{
	                extend:    'csvHtml5',
	                text:      '<i class="fa fa-file-text-o"></i>',
	                titleAttr: 'csv'
	            },{
	                extend:    'pdfHtml5',
	                text:      '<i class="fa fa-file-pdf-o"></i>',
	                titleAttr: 'pdf'
	            }]
		});
		
 		seleccionarEliminarUsuario('#tabla_usuario tbody', tablaUsuario);
	}
	
	var agregar_nuevo_consumo = function() {
		limpiar_texto();
		colapsar_desplegar($("#colapsar_desplegar2"));
		colapsar_desplegar($("#colapsar_desplegar1"));
		expandir($("#expandir1"));
	}
	
	var cancelar = function() {
		limpiar_texto();
		expandir($("#expandir1"));
		colapsar_desplegar($("#colapsar_desplegar1"));
		colapsar_desplegar($("#colapsar_desplegar2"));
	}
	
	var limpiar_texto = function() {//limpiar texto del formulario
		$("#login").val("guardar");
		$("#pass").val("");
	}
	
	var seleccionarEditarConsumo = function(tbody, table) {
		console.log("seleccinar editar usuario");
		
		table.rows().every(function(index	) {
			console.log(table.row(index).data());
		});
	}
	
	var seleccionarEliminarUsuario = function(tbody, table) {
		//console.log("seleccionar eliminar consumo");
		$(tbody).on("click", "button.eliminar", function() {
			var datos = table.row($(this).parents("tr")).data();//mismo evento para el boton eliminar
			console.log(datos);
			var usuario_id = $("#frmEliminarUsuario #usuario_id").val(datos.usuario_ID);//solo se obtiene el id que es oculto
			abrirDialogo();
		});
		
		table.rows().every(function(index	) {
			console.log(table.row(index).data());
		});
	}
	
	
	// CREAR USUARIO

	/*function DemoSelect2() {
		$('#s2_with_tag').select2({
			placeholder : "Select OS"
		});
		$('#s2_rol').select2();
	}*/
	
	
	$(document).ready(function() {
		// Create UI spinner
		$("#ui-spinner").spinner();
		
		// Create Wysiwig editor for textare
		TinyMCEStart('#wysiwig_simple', null);
		TinyMCEStart('#wysiwig_full', 'extreme');
		// Add slider for change test input length
		FormLayoutExampleInputLength($(".slider-style"));
		// Add tooltip to form-controls
		$('.form-control').tooltip();
//		LoadSelect2Script(DemoSelect2);
		// Load example of form validation
		LoadBootstrapValidatorScript(DemoFormValidator);
		// Add drag-n-drop feature to boxes
		WinMove();
	});
	
 	//llamar a la funcio listar para que llene el dataTable
  	$(document).on("ready", function(window, document, JSON){
  		$("#defaultForm");
  		guardar();//activar evento de guardar
  	});
 	
	//metodo guardar donde activa el evento submit del formulario de registro
	var guardar = function() {
		$("form").on("submit", function(e) {
			e.preventDefault();//detiene el evento
			var frm = $(this).serialize();//parsea los datos del formulario
			console.log(frm);
			$.ajax({//enviar datos por ajax
			method:"POST",
			url:"SL_Usuario",
			data: frm//datos a enviar
			}).done(function(info) {//informacion que el servlet le reenvia al jsp
			console.log(info);
			limpiar_texto();
			iniciarTabla();
			mostrar_mensaje(info);//se envia a verificar que mensaje respondioel servlet
			//listar();//volver a listar datos
			
			});
		});
	}
	
	var agregar_nuevo_usuario = function() {
		limpiar_texto();
		$("#defaultForm");
	}
	
	
	//revise los mensaje que envian el guardar y eliminar (metodos)
	var mostrar_mensaje = function(info) {
		var text ="", color="";
		console.log("info: " + info.respuesta);
		if (info.respuesta =="BIEN"){//si la respuesta fue BIEN pasa el if y luego
			texto="<strong>Bien!</strong>, se guardaron los cambios correctamente";
			color = "#379911";
			$("#defaultForm");
// 			$("#cuadro1").slideDown("slow");
			//websocket.send("ACTUALIZADO");//se envia un mensaje al serverendpoint para que avise actualizar a las otras sesiones
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
	
	var limpiar_texto = function() {//limpiar texto del formulario
		$("#opcion").val("guardar");
		$("#usuario_id").val("");
		$("#login").val("").focus();
		$("#pass").val("");
	}
	
</script>


















