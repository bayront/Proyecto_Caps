<!--Start Breadcrumb-->
<div class="row">
	<div id="breadcrumb" class="col-xs-12">
		<ol class="breadcrumb">
			<!--<li><a href="index.html">Home</a></li>-->
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Roles y Opciones</a></li>
		</ol>
	</div>
</div>
<!--End Breadcrumb-->
<!--Start Dashboard 1-->
<div id="dashboard-header" class="row">
	<div class="col-sm-12 col-md-12 text-center">
		<h3>Gestion de Roles y Opciones</h3>
	</div>
</div>
<!--End Dashboard 1-->
<!--Start Dashboard 2-->
<div class="row-fluid">
	<div id="dashboard_links" class="col-xs-12 col-sm-2 pull-right">
		<ul class="nav nav-pills nav-stacked"
		style="background: #4C9480 url(./img/devoops_pattern_b10.png) 0 0 repeat;">
			<li class="active"><a href="#" class="tab-link" id="Rol">Roles</a></li>
			<li><a href="#" class="tab-link" id="Opcion">Opciones</a></li>
			<li><a href="#" class="tab-link" id="Rol_Opcion">Asignar Permisos</a></li>
		</ul>
	</div>
	<div id="dashboard_tabs" class="col-xs-12 col-sm-10">
	
		<!--Start Dashboard Tab 1-->
		<div id="dashboard-Rol" class="row"
		style="visibility: visible; position: relative;">
		
			<div id="ow-marketplace" class="col-sm-12 col-md-12">
				<div id="ow-setting" style="width: 100px;">
					<a href="#"><i class="fa fa-folder-open"></i></a> <a href="#"><i
						class="fa fa-credit-card"></i></a> <a href="#"><i
						class="fa fa-ticket"></i></a>
				</div>
				<h4 class="page-header">Roles</h4>
			</div>
			
			<form class="form-horizontal formRol" role="form" id="defaultForm"
				method="post" action="./SL_Rol">
				
				<input type="hidden" id="metodo" name="metodo" class="form-control" value="guardar"/>
				<input type="hidden" id="rol_ID" name="rol_ID" class="form-control"/>
				<div class="form-group">
					<label class="col-sm-3 control-label">Nombre del Rol</label>
					<div class="col-sm-5">
						<input id="nomRol" type="text" class="form-control" name="nomRol" />
					</div>
				</div>
				<div class="clearfix"></div>
				
				<div class="form-group">
					<div class="col-sm-12 col-md-3 ">
							<button type="button" class="btn btn-default btn-label-left elimRol">
								<span><i class="fa fa-clock-o txt-danger"></i></span> Eliminar
							</button>
						</div>
						<div class="col-sm-12 col-md-3">
							<button type="button" class="btn btn-warning btn-label-left actRol">
								<span><i class="fa fa-clock-o"></i></span> Actualizar
							</button>
						</div>
						<div class="col-sm-12 col-md-3">
							<button type="button" class="btn btn-warning btn-label-left nuevoRol">
								<span><i class="fa fa-clock-o"></i></span> Nuevo
							</button>
						</div>
						<div class="col-sm-12 col-md-3">
							<button type="button" class="btn btn-primary btn-label-left guardarRol">
								<span><i class="fa fa-clock-o"></i></span> Guardar nuevo
							</button>
						</div>
				</div>
				<div class="clearfix"></div>
			</form>
			<legend></legend>
			<label class="col-sm-4 text-right control-label">Roles cargados</label>
			<div class="col-sm-6">
				<select class="populate placeholder" name="roles" id="roles">
					<option value="">ROLES</option>
				</select>
			</div>
			<div class="clearfix"></div>
			<div style="height: 15px;"></div>
		</div>
		<!--End Dashboard Tab 1-->
		
		<!--Start Dashboard Tab 2-->
		<div id="dashboard-Opcion" class="row" style="visibility: hidden; position: absolute;">
			<div id="ow-marketplace" class="col-sm-12 col-md-12">
				<div id="ow-setting" style="width: 100px;">
					<a href="#"><i class="fa fa-folder-open"></i></a> 
					<a href="#"><i class="fa fa-credit-card"></i></a> 
					<a href="#"><i class="fa fa-ticket"></i></a>
				</div>
				<h4 class="page-header">Opciones</h4>
				
				<form class="form-horizontal formOpcion" role="form" id="defaultForm"
				method="post" action="./SL_Opcion">
				
				<input type="hidden" id="metodo" name="metodo" class="form-control" value="guardar"/>
				<input type="hidden" id="opcion_ID" name="opcion_ID" class="form-control"/>
				<div class="form-group">
					<label class="col-sm-3 control-label">Nombre la Opcion</label>
					<div class="col-sm-5">
						<input id="opcion" type="text" class="form-control" name="opcion" />
					</div>
				</div>
				<div class="clearfix"></div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">Descripcion</label>
					<div class="col-sm-5">
						<textarea class="form-control" id="descripcion" name="descripcion" rows="3" cols="45"></textarea>
					</div>
				</div>
				<div class="clearfix"></div>
				
				<div class="form-group">
					<div class="col-sm-12 col-md-offset-2 col-md-3 ">
							<button type="submit" class="btn btn-default btn-label-left">
								<span><i class="fa fa-clock-o txt-danger"></i></span> Eliminar
							</button>
						</div>
						<div class="col-sm-12 col-md-3">
							<button type="submit" class="btn btn-warning btn-label-left">
								<span><i class="fa fa-clock-o"></i></span> Actualizar
							</button>
						</div>
						<div class="col-sm-12 col-md-3">
							<button type="submit" class="btn btn-primary btn-label-left">
								<span><i class="fa fa-clock-o"></i></span> Guardar
							</button>
						</div>
				</div>
				<div class="clearfix"></div>
			</form>
			<legend></legend>
			<label class="col-sm-4 text-right control-label">Opciones cargadas</label>
			<div class="col-sm-6">
				<select class="populate placeholder" name="opciones" id="opciones">
					<option value="">OPCION</option>
				</select>
			</div>
			<div class="clearfix"></div>
			<div style="height: 15px;"></div>
			</div>
		</div>
		<!--End Dashboard Tab 2-->
		
		<!--Start Dashboard Tab 3-->
		<div id="dashboard-Rol_Opcion" class="row"
		style="width: 100%; visibility: hidden; position: absolute;">
			<div class="col-xs-12">
				<h4 class="page-header">Asignar Opciones a Roles</h4>
			</div>

			<form class="form-horizontal formRolOpcion" role="form"
				id="defaultForm" method="post" action="./SL_RolOpcion">
				
				<input type="hidden" id="metodo" name="metodo" class="form-control" value="guardar" /> 
				<input type="hidden" id="opcion_ID" name="opcion_ID" class="form-control" /> 
				<input type="hidden" id="rol_ID" name="rol_ID" class="form-control" />
				
				<div class="form-group">
					<label class="col-sm-2 control-label">nombre Rol</label>
					<div class="col-sm-4">
						<input type="text" id="nom_Rol" class="form-control" placeholder="rol" data-toggle="tooltip"
						 data-placement="bottom" title="nombre del rol">
					</div>
					<label class="col-sm-2 control-label">nombre Opcion</label>
					<div class="col-sm-4">
						<input type="text" id="nom_opcion" class="form-control" placeholder="opcion" data-toggle="tooltip"
						 data-placement="bottom" title="nombre de la opcion">
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-2 text-right control-label">Roles</label>
					<div class="col-sm-4">
						<select class="populate placeholder" name="rol1" id="rol1">
							<option value="">ROLES</option>
						</select>
					</div>
					<label class="col-sm-2 text-right control-label">Opciones</label>
					<div class="col-sm-4">
						<select class="populate placeholder" name="opcion1" id="opcion1">
							<option value="">OPCIONES</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-12 col-md-offset-4 col-md-3">
						<button type="submit" style="margin-left: 25px;"
							class="btn btn-primary btn-label-left">
							<span><i class="fa fa-clock-o"></i></span> Guardar
						</button>
					</div>
					<div class="col-sm-12 col-md-3">
							<button type="button" class="btn btn-warning btn-label-left">
								<span><i class="fa fa-clock-o"></i></span> Nuevo
							</button>
						</div>
				</div>
				<div class="clearfix"></div>
			</form>
			<legend>--Registro de roles y opciones</legend>

			<label class="col-sm-4 text-right control-label">Rol</label>
			<div class="col-sm-6">
				<select class="populate placeholder" name="rol2" id="rol2">
					<option value="">ROL</option>
				</select>
			</div>
			<div class="clearfix"></div>
			<div style="height: 10px;"></div>
			<label class="col-sm-4 text-right control-label">Opcion del rol</label>
			<div class="col-sm-6">
				<select class="populate placeholder" name="opcion2" id="opcion2">
					<option value="">OPCION</option>
					<option value="fr">todo</option>
					<option value="de">algo</option>
					<option value="de">nada</option>
				</select>
			</div>
			<div class="clearfix"></div>
			<div style="height: 10px;"></div>
			<div class="col-sm-12 col-md-offset-4 col-md-3">
				<button type="button" class="blue" style="width: 120px;" id="actualizarRolOpcion">
					<span><i class="fa fa-clock-o"></i></span> Actualizar
				</button>
			</div>
			<div class="col-sm-12 col-md-4">
				<button type="button" class="blue" id="eliminarRolOpcion"
				style="width: 120px; background-color: #e68665;">
					<span><i class="fa fa-clock-o"></i></span> Eliminar
				</button>
			</div>
			<div class="clearfix"></div>
			<div style="height: 15px;"></div>
		</div>
		<!--End Dashboard Tab 3-->
		
	</div>
	<div class="clearfix"></div>
</div>
<!--End Dashboard 2 -->

<div style="height: 40px;"></div>

<script type="text/javascript">
var datos_Rol_Opciones;

function DemoSelect2() {
	$('#roles').select2();
	$('#opciones').select2();
	$('#rol1').select2();
	$('#opcion1').select2();
	$('#rol2').select2();
	$('#opcion2').select2();
}

//metodo para cargar sobre un select rol los registros
function cargarSelectRol(selectRol) {//parametro id select
	var datos;
	$.ajax({
        type: "GET",
        url: "./SL_Rol",
        dataType: "json",
        success: function(response)
        {
        	datos = response.aaData;
        	$(selectRol).empty();
        	var primer = 0;
        	$(response.aaData).each(function(i, v) {
        		console.log(v.rol_ID+": "+v.nomRol);//agregar datos al select
        		$(selectRol).append('<option value="' + v.rol_ID + '">' + v.nomRol + '</option>');
        		if(primer ==0){
        			if($(selectRol).parent("div").siblings("form").find("input[id*=Rol]").length){
        				$("input#nomRol	").val(v.nomRol);
            			$(selectRol).parent("div").siblings("form").find("input[id=rol_ID]").val(v.rol_ID);
        			}
        			if($(selectRol).parents("form").find("input[id*=Rol]").length){
        				$("input#nom_Rol").val(v.nomRol);
        				$(selectRol).parents("form").find("input[id=rol_ID]").val(v.rol_ID);
        			}
        			primer +=1; 
        		}
			});
        }
	});
	$(selectRol).change(function(){//cuando se elija otra opcion del select
		//parent(padre del elemento) - siblings(hermanos del el.) - find(busca hijo del el.)
        if($(selectRol).parent("div").siblings("form").find("input[id*=Rol]").length){
        	$(selectRol).parent("div").siblings("form").find("input[id*=Rol]").val($(selectRol+" option:selected").text());
        	$(selectRol).parent("div").siblings("form").find("input[id=rol_ID]").val($(selectRol).val());
        	if($(selectRol).parent("div").siblings("form").find("select[id=rol1]").length){
				$("select#rol1").val($(selectRol).val());
				$("select#rol1").change();
				//AGREGAR LOS CAMBIOS AQUI
        	}
        }
        if($(selectRol).parents("form").find("input[id*=Rol]").length){
        	//parents(padres del elemento) - *(que contenga) - [](un atributo del el.)
        	$(selectRol).parents("form").find("input[id*=Rol]").val($(selectRol+" option:selected").text());
        	$(selectRol).parents("form").find("input[id=rol_ID]").val($(selectRol).val());
        }
    });
}
function cargarSelectOpcion(selectOpcion) {//parametro id select
	var datos;
	$.ajax({
        type: "GET",
        url: "./SL_Opcion",
        dataType: "json",
        success: function(response)
        {
        	datos = response.aaData;
        	$(selectOpcion).empty();
        	var primer = 0;
        	$(response.aaData).each(function(i, v) {
        		console.log(v.opcion_ID+": "+v.opcion);//agregar datos al select
        		$(selectOpcion).append('<option value="' + v.opcion_ID + '">' + v.opcion + '</option>');
        		if(primer ==0){
        			if($(selectOpcion).parent("div").siblings("form").find("input[id=opcion]").length){
        				$("input#opcion").val(v.opcion);
            			$("textarea#descripcion").val(v.descripcion);
            			$(selectOpcion).parent("div").siblings("form").find("input[id=opcion_ID]").val(v.opcion_ID);
        			}
        			if($(selectOpcion).parents("form").find("input[id*=opcion]").length){
        				$("input#nom_opcion").val(v.opcion);
        				$(selectOpcion).parents("form").find("input[id=opcion_ID]").val(v.opcion_ID);
        			}
        			primer +=1;
        		}
			});
        }
	});
	$(selectOpcion).change(function(){//cuando se elija otra opcion del select
		//parent(padre del elemento) - siblings(hermanos del el.) - find(busca hijo del el.)
        if($(selectOpcion).parent("div").siblings("form").find("input[id=opcion]").length){
        	$(selectOpcion).parent("div").siblings("form").find("input[id=opcion]").val($(selectOpcion+" option:selected").text());
        	$(selectOpcion).parent("div").siblings("form").find("input[id=opcion_ID]").val($(selectOpcion).val());
        	$(datos).each(function(i, v) {
				if($(selectOpcion).val() == v.opcion_ID){
					$(selectOpcion).parent("div").siblings("form").find("input[id=descripcion]").val(v.descripcion);
				}
			});
        	$(selectOpcion).parent("div").siblings("form").find("input[id=opcion_ID]").val($(selectOpcion).val());
        }
        if($(selectRol).parents("form").find("input[id=opcion]").length){
        	//parents(padres del elemento) - *(que contenga) - [](un atributo del el.)
        	$(selectRol).parents("form").find("input[id=opcion]").val($(selectRol+" option:selected").text());
        	$(selectRol).parents("form").find("input[id=opcion_ID]").val($(selectRol).val());
        }
    });
}

//metodo para activar click en los tag y cargar los roles
var cargarDatosRol = function(tag, rol) {//recibe el tag para click y el select-rol
	tag.on("click", function() {
		cargarSelectRol(rol);
		console.log("cargar roles");
	});
}

//metodo para activar click sobre los tag y cargar opciones
var cargarDatosOpcion = function(tag, opcion) {
	tag.on("click", function() {
		cargarSelectOpcion(opcion);
		console.log("cargar opciones");
	});
}
function limpiar(form) {
	$(form).find("input").each(function(i, v) {
		if($(v).is("#metodo")){
			$(v).val("guardar");
		}else{
			$(v).val("");
		}
	});
}
var verResultado = function(r) {
	if(r == "BIEN"){
		cargarSelectRol("#roles");
		cargarSelectRol("#rol1");
		cargarSelectRol("#rol2");
	}
	if(r == "Error"){
		alert("ERROR: No se pudo realizar la accion");
	}
	if(r =="VACIO"){
		alert("VACIO: No se realizo ninguna accion");
	}
}
var activarFormRol = function() {
	$("form.formRol").on("click", "button.nuevoRol", function() {
		limpiar("form.formRol");
	}).on("click", "button.guardarRol", function() {
		console.log("guardar rol");
		var frm = $("form.formRol").serialize();
		console.log(frm);
		$.ajax({
	        type: "POST",
	        url: "./SL_Rol",
	        data: frm,
	        dataType: "text",
	        success: function(response){
	        	console.log(response);
	        	verResultado(response);
	        }
		});
	}).on("click", "button.actRol", function() {
		console.log("actualizar rol");
		$("form.formRol input#metodo").val("actualizar");
		var frm = $("form.formRol").serialize();
		console.log(frm);
		$.ajax({
	        type: "POST",
	        url: "./SL_Rol",
	        data: frm,
	        success: function(response){
	        	console.log(response);
	        	verResultado(response);
	        }
		});
	}).on("click", "button.elimRol", function() {
		console.log("eliminar rol");
		$("form.formRol input#metodo").val("eliminar");
		var frm = $("form.formRol").serialize();
		console.log(frm);
		$.ajax({
	        type: "POST",
	        url: "./SL_Rol",
	        data: frm,
	        success: function(response){
	        	console.log(response);
	        	verResultado(response);
	        }
		});
	});
}

$(document).ready(function() {
	// Make all JS-activity for dashboard
	DashboardTabChecker();
	
	LoadBootstrapValidatorScript(DemoFormValidator);//validaciones
	
	LoadSelect2Script(DemoSelect2);
	
	 $('[data-toggle="tooltip"]').tooltip();
	
	cargarSelectRol("#roles");
	cargarDatosRol($("li a#Rol"), "#roles");
	cargarDatosRol($("li a#Rol_Opcion"), "#rol1");
	cargarDatosRol($("li a#Rol_Opcion"), "#rol2");
	cargarDatosOpcion($("li a#Opcion"), "#opciones");
	cargarDatosOpcion($("li a#Rol_Opcion"), "#opcion1");
	
// 	$.ajax({
//         type: "GET",
//         url: "./SL_Rol_Opcion",
//         dataType: "json",
//         success: function(response){
//         	console.log(response.aaData);
//         }
// 	});
	activarFormRol();
	
});

</script>