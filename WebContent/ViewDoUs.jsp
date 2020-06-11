<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>DoU Sharing</title>
<link rel="icon" href="img/logo.png" type="image/icon type">

<!-- Custom fonts for this template -->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/sb-admin-2.min.css" rel="stylesheet">

<!-- Custom styles for this page -->
<link href="vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<link href="css/ViewDoUs.css" rel="stylesheet">

</head>

<body id="page-top">

	<%@ include file="Header.jsp"%>

	<!-- New Access List -->
	<div id="status-popover-title" class="font-weight-bold"
		style="display: none"></div>
	<div id="status-popover-content" style="display: none">
		<div class="">
			<p class="text-dark card-text">
			<p id="dou_status_prefix_connector"
				class="card-text text-dark d-inline"></p>
			<b id="dou_status" class="card-text d-inline"></b>
			<p id="dou_status_suffix_connector"
				class="card-text text-dark d-inline"></p>
			<b id="dou_status_suffix" class="card-text d-inline"></b>
			</p>
			<ul id="people-list" class="list-group list-group-flush">

			</ul>
		</div>
	</div>

	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Page nav tabs -->
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item"><a class="nav-link active" id="all-tab"
				data-toggle="tab" href="#all" role="tab" aria-controls="All"
				aria-selected="true">All</a></li>
			<li class="nav-item"><a class="nav-link" id="own-tab"
				data-toggle="tab" href="#own" role="tab" aria-controls="Own"
				aria-selected="false">Own</a></li>
			<li class="nav-item"><a class="nav-link" id="shared-tab"
				data-toggle="tab" href="#shared" role="tab"
				aria-controls="Shared_with_me" aria-selected="false">Shared</a></li>
		</ul>
		<div class="tab-content" id="myTabContent">
			<div class="tab-pane fade active show" id="all" role="tabpanel"
				aria-labelledby="all-tab">
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary float-left">All DoUs</h6>
						<button id="remove-status-filter"
							class="remove-status-filter d-none btn btn-outline-dark btn-sm dou-tooltips float-right px-1"
							data-placement="top"
							title="Click on this to remove filter on STATUS"
							onclick="removeStatusFilter()">Remove Filter</button>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table
								class="table row-border table-striped  card-list-table table-hover dou-table"
								id="allDoUTable" width="100%" cellspacing="0">
								<thead class="thead-dark">
									<tr>
										<th>#</th>
										<th>Name</th>
										<th>Status</th>
										<th>Initiator</th>
										<th>Modified on</th>
										<!-- <th>DoU Revision</th> -->
									</tr>
								</thead>
								<tfoot class="thead-dark">
									<tr>
										<th>#</th>
										<th>Name</th>
										<th>Status</th>
										<th>Initiator</th>
										<th>Modified on</th>
										<!-- <th>DoU Revision</th> -->
									</tr>
								</tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="tab-pane fade" id="own" role="tabpanel"
				aria-labelledby="own-tab">
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary float-left">DoUs initiated
							by me</h6>
							<button id="remove-status-filter"
							class="remove-status-filter d-none btn btn-outline-dark btn-sm dou-tooltips float-right px-1"
							data-placement="top"
							title="Click on this to remove filter on STATUS"
							onclick="removeStatusFilter()">Remove Filter</button>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table
								class="table row-border table-striped table-hover dou-table"
								id="ownDoUTable" width="100%" cellspacing="0">
								<thead class="thead-dark">
									<tr>
										<th>#</th>
										<th>Name</th>
										<th>Status</th>
										<th>Initiator</th>
										<th>Modified on</th>
										<!-- <th>DoU Revision</th> -->
									</tr>
								</thead>
								<tfoot class="thead-dark">
									<tr>
										<th>#</th>
										<th>Name</th>
										<th>Status</th>
										<th>Initiator</th>
										<th>Modified on</th>
										<!-- <th>DoU Revision</th> -->
									</tr>
								</tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="tab-pane fade" id="shared" role="tabpanel"
				aria-labelledby="shared-tab">
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary float-left">DoUs shared
							with me</h6>
							<button id="remove-status-filter"
							class="remove-status-filter d-none btn btn-outline-dark btn-sm dou-tooltips float-right px-1"
							data-placement="top"
							title="Click on this to remove filter on STATUS"
							onclick="removeStatusFilter()">Remove Filter</button>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table
								class="table row-border table-striped table-hover dou-table"
								id="sharedDoUTable" width="100%" cellspacing="0">
								<thead class="thead-dark">
									<tr>
										<th>#</th>
										<th>Name</th>
										<th>Status</th>
										<th>Initiator</th>
										<th>Modified on</th>
										<!-- <th>DoU Revision</th> -->
									</tr>
								</thead>
								<tfoot class="thead-dark">
									<tr>
										<th>#</th>
										<th>Name</th>
										<th>Status</th>
										<th>Initiator</th>
										<th>Modified on</th>
										<!-- <th>DoU Revision</th> -->
									</tr>
								</tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>


	</div>
	<!-- /.container-fluid -->

	<%@ include file="Footer.jsp"%>

	<!-- Page level plugins -- ViewDoUs.jsp-->
	<script src="vendor/datatables/jquery.dataTables.min.js"></script>
	<script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

	<!-- Page level custom scripts -- ViewDoUs.jsp-->
	<script src="js/CommonUtils.js"></script>
	<script src="js/ViewDoUs.js"></script>
</body>

</html>
