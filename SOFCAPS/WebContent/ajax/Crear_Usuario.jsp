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
		
		
	<!-- AQUI INICIA EL DIV PARA EL TITULO-->
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
	<!-- AQUI TERMINA EL TITULO  -->
			
			

			<div class="box-content">
				<form class="form-horizontal" role="form" id="defaultForm" method="POST" action="validators.html">
				
					<input type="hidden" id="opcion" name="opcion" value="guardar">
					<div class="form-group">
						<label class="col-sm-2 control-label text-info">Login</label>
						<div class="col-sm-5"><input id="login" name="login" type="text" class="form-control"  autofocus></div>
					</div> 
					<div class="form-group">
						<label class="col-sm-2 control-label text-info">Password</label>
							<div class="col-sm-5"><input id="pass" name="pass" type="text" class="form-control" ></div>
					</div>
					<!--  
					<div class="form-group">
						<label class="col-sm-3 control-label">Pais</label>
						<div class="col-sm-5">
							<select class="populate placeholder" name="country"
								id="s2_country">
								<option value="">-- Select a country --</option>
								<option value="fr">France</option>
								<option value="de">Germany</option>
								<option value="it">Italy</option>
								<option value="jp">Japan</option>
								<option value="ru">Russia</option>
								<option value="gb">United Kingdom</option>
								<option value="us">United State</option>
							</select>
						</div>
					</div>
					-->
					
					<div class="form-group">
<!-- 						<label for="usuario_id" class="col-sm-2 control-label text-info">ID_Usuario</label> -->
						<div class="col-sm-5"><input type="hidden" id="usuario_id" name="usuario_id" type="text" class="form-control" maxlength="8" ></div>
					</div>
						
						
					<div class="form-group">
						<div class="col-sm-3">
							<button type="submit" class="btn btn-info btn-label-left">
								<span><i class="glyphicon glyphicon-save text-info"></i></span><font color="black">Crear</font>
							</button>
						</div>
						
<!-- 						<div class="col-sm-3"> -->
<!-- 							<button type="cancel" class="btn btn-info btn-label-left"> -->
<!-- 								<span><i class="glyphicon glyphicon-refresh"></i></span> <font color="black">Modificar </font> -->
<!-- 							</button> -->
<!-- 						</div> -->
<!-- 						<div class="col-sm-2"> -->
<!-- 							<button type="submit" class="btn btn-info btn-label-left"> -->
<!-- 								<span><i class="fa fa-clock-o txt-info"></i></span><font color="black"> Anular </font> -->
<!-- 							</button> -->
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


<script type="text/javascript">
	// Run Select2 plugin on elements
	function DemoSelect2() {
		$('#s2_with_tag').select2({
			placeholder : "Select OS"
		});
		$('#s2_rol').select2();
	}
	
	
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
		LoadSelect2Script(DemoSelect2);
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
	
	
//al hacer click al boton listar volver a llenar los datos en el dataTable
// 	$("#btn_listar").on("click", function() {
// 		$("#cuadro2").slideUp("slow");
// 		$("#cuadro1").slideDown("slow");
// 		listar();//listar al presionar boton del formulario de registro
// 	});
	
	
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
	
	var limpiar_texto = function() {//limpiar texto del formulario
		$("#opcion").val("guardar");
		$("#usuario_id").val("");
		$("#login").val("").focus();
		$("#pass").val("");
	}
	
	
	

</script>

