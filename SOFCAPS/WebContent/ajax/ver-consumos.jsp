<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="#">Dashboard</a></li>
			<li><a href="#">Consumos</a></li>
			<li><a href="#">Ver consumos</a></li>
		</ol>
	</div>
</div>

<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-linux"></i> <span>Lista de consumos</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding">
				<table
					class="table table-bordered table-striped table-hover table-heading table-datatable"
					id="datatable-3">
					<thead>
						<tr>
							<th>Numeracion</th>
							<th>Distro</th>
							<th>Votos</th>
							<th>Pagina</th>
							<th>Version</th>
							<th>Icono</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>1</td>
							<td>Ubuntu</td>
							<td>16%</td>
							<td><i class="fa fa-home"></i><a href="http://ubuntu.com"
								target="_blank">http://ubuntu.com</a></td>
							<td>13.10</td>
							<td><i class="fa fa-linux"></i></td>
						</tr>
						<tr>
							<td>2</td>
							<td>Debian</td>
							<td>14.1%</td>
							<td><i class="fa fa-home"></i><a href="http://debian.org"
								target="_blank">http://debian.org</a></td>
							<td>7.4</td>
							<td><i class="fa fa-linux"></i></td>
						</tr>
						<tr>
							<td>3</td>
							<td>Arch Linux</td>
							<td>10.8%</td>
							<td><i class="fa fa-home"></i><a href="http://archlinux.org"
								target="_blank">http://archlinux.org</a></td>
							<td>2014.02.01</td>
							<td><i class="fa fa-linux"></i></td>
						</tr>
						<tr>
							<td>4</td>
							<td>Linux Mint</td>
							<td>10.5%</td>
							<td><i class="fa fa-home"></i><a href="http://linuxmint.com"
								target="_blank">http://linuxmint.com</a></td>
							<td>16</td>
							<td><i class="fa fa-linux"></i></td>
						</tr>
						<tr>
							<td>5</td>
							<td>Fedora</td>
							<td>6.9%</td>
							<td><i class="fa fa-home"></i><a
								href="http://fedoraproject.org" target="_blank">http://fedoraproject.org</a></td>
							<td>20</td>
							<td><i class="fa fa-linux"></i></td>
						</tr>
						<tr>
							<td>6</td>
							<td>openSUSE</td>
							<td>5.2%</td>
							<td><i class="fa fa-home"></i><a href="http://opensuse.org"
								target="_blank">http://opensuse.org</a></td>
							<td>13.1</td>
							<td><i class="fa fa-linux"></i></td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<th>Numeracion</th>
							<th>Distro</th>
							<th>Votos</th>
							<th>Pagina</th>
							<th>Version</th>
							<th>Icono</th>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
// Run Datables plugin and create 3 variants of settings
function AllTables(){
	TestTable3();
	LoadSelect2Script(MakeSelect2);
}
function MakeSelect2(){
	$('select').select2();
	$('.dataTables_filter').each(function(){
		$(this).find('label input[type=text]').attr('placeholder', 'Search');
	});
}
$(document).ready(function() {
	// Load Datatables and run plugin on tables 
	LoadDataTablesScripts(AllTables);
	// Add Drag-n-Drop feature
	WinMove();
});
</script>
