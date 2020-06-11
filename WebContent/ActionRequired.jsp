<%@page import="ibm.ptc.dou.business.DoUBusinessLogic"%>
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

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">
<link href="css/ActionRequired.css" rel="stylesheet">

<link href="css/CommonStyles.css" rel="stylesheet">
</head>

<body id="page-top">

	<%@ include file="Header.jsp"%>

	<div style="display: none">
		<div id="action-required-dou-template"
			class="item col-xs-4 col-lg-4 p-2 clearfix visible-md-block border-0 rounded">
			<div class="thumbnail card border border-dark rounded">
				<div class="caption card-body">
					<h4 id="dou-name"
						class="group card-title d-inline font-weight-bold inner list-group-item-heading text-info">
					</h4>
					<sup id="dou-file-version"
						class=" card-title badge badge-dark ml-2"></sup>
					<div>
						<footer class="card-subtitle blockquote-footer">Initiated
						by <cite id="created_by" class="text-dark font-weight-bold"
							title="Initiator"></cite>, on <cite id="created_time"
							class="text-dark font-weight-bold" title="Initiated Time"></cite></footer>
					</div>
					<div class="mt-2">
						<div class="group inner list-group-item-text">
							<p class="text-dark card-text">
							<p id="dou_status_prefix_connector"
								class="card-text text-dark d-inline">is</p>
							<b id="dou_status"
								class="card-text text-info dynamic-text-color d-inline"></b>
							<p id="dou_status_suffix_connector"
								class="card-text text-dark d-inline">with</p>
							<b id="dou_status_suffix"
								class="card-text text-info dynamic-text-color d-inline"></b>
							</p>
							<ul class="list-group">
								<li class="list-group-item border border-dark"><div
										id="user-id" class="float-left"></div>
									<div class="">
										<b id="user-approval-status-pending-template"
											class="user-approval-status-pending float-right text-warning font-weight-bold">
											Pending with <i id="user-approval-status-pending-icon"
											class="fas fa-hourglass-half text-warning"></i>
										</b>
									</div></li>
							</ul>
						</div>

						<footer class="mt-2"> Please view the DoU and take
						necessary actions </footer>
						<div class="col align-self-end mt-2">
							<a id="view_dou" href="#"
								class="btn btn-primary dou-tooltips float-right"
								data-placement="top" title="View DoU Details">View DoU</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<h1 class="h3 mb-0 text-gray-800">Actions Required by me</h1>
		<nav id="action-required-dous-utilities"
			class="navbar navbar-light justify-content-center float-right"
			style="display: none;">
		<form class="form-inline">
			<button type="button" id="sort-action-required-dous"
				class="sort-action-required-dous btn btn-dark btn-sm dou-tooltips float-right px-2 mr-3">Sort DoUs</button>
			<input class="form-control" type="search" placeholder="Search DoU"
				aria-label="Search" id="search-action-required-dous">
		</form>
		</nav>
		<br>
		<p id="action-required-dous-instruction" class="card-text mt-2"
			style="text-align: center; display: none;">No DoUs are pending
			with you</p>


		<div id="action-required-dous" class="row view-group my-2"></div>
		<!-- bg-dark border-0 rounded -->
	</div>

	<!-- /.container-fluid -->
	<%@ include file="Footer.jsp"%>

	<!-- Page level plugins -- index.jsp-->
	<!-- <script src="vendor/chart.js/Chart.min.js"></script> -->

	<!-- Page level custom scripts -- index.jsp-->
	<!-- <script src="js/demo/chart-area-demo.js"></script>
	<script src="js/demo/chart-pie-demo.js"></script> -->
	<script src="vendor/blockUI/blockUI.js"></script>
	<script src="js/CommonUtils.js"></script>
	<script src="js/ActionRequired.js"></script>

</body>
</html>
