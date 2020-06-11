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

<title>Safer Spot Locator</title>
<link rel="icon" href="img/logo.png" type="image/icon type">

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">
<link href="css/Form.css" rel="stylesheet">

<link href="css/CommonStyles.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<body id="page-top">

	<%@ include file="Header.jsp"%>

	<!-- DoM templates start -->

	<!-- recent DoU template start -->
	<div style="display: none;">
		<div style="width: 30rem; word-break: break-all" id="template-card"
			class="card border-primary shadow mb-4">
			<!-- Card Header - Dropdown -->
			<div
				class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
				<h6 id="dou_name" class="m-0 font-weight-bold text-primary"></h6>
				<!-- <div class="dropdown no-arrow">
					<a class="dropdown-toggle" href="#" role="button"
						id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"> <i
						class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
					</a>
					<div
						class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
						aria-labelledby="dropdownMenuLink">
						<div class="dropdown-header">Dropdown Header:</div>
						<a class="dropdown-item" href="#">Action</a> <a
							class="dropdown-item" href="#">Another action</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Something else here</a>
					</div>
				</div> -->
			</div>
			<!-- Card Body -->
			<div class="card-body">
				<div style="float: right">
					<span id="dou_status" class="badge badge-pill badge-primary"></span>
				</div>
				<br>
				<div>
					<b><i>Initiated By:
							<p id="created_by"></p>
					</i></b>
				</div>
				<div>
					<b><i>DoU Version:
							<p id="dou_file_version"></p>
					</i></b>
				</div>
			</div>
			<div style="border: 0px;" class="card-footer bg-white">
				<a id="view_dou" href="#" class="btn btn-primary dou-tooltips"
					data-placement="top" title="View DoU Details">View DoU</a>
			</div>
			<div class="card-footer">
				<small class="text-muted">Last updated on
					<p id="last_modified_time"></p>
				</small>
			</div>
		</div>
	</div>
	<!-- recent DoU template end -->

	<!-- DoM templates end -->



	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Page Heading -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h3 mb-0 text-gray-800">Top safer ranked general
				purpose locations you may want to visit:</h1>
			<%
				if (isPTCMember) {
			%>
			<!-- Button trigger modal 
			<a href="#"
				class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm dou-tooltips"
				data-toggle="modal" data-target="#dou-upload-form"
				data-placement="bottom" title="Initiate DoU For Approval Process"><i
				class="fas fa-upload fa-sm text-white-50"></i> Initiate DoU</a>-->
			<%
				}
			%>
		</div>


		<%
			if (isPTCMember) {
		%>
		<!-- Share DoU Modal -->
		<div class="modal fade" id="dou-upload-form" tabindex="-1"
			role="dialog" aria-labelledby="dou-upload-form" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="dou-upload-form">Initiate DoU</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form method="POST" id="create_dou_form"
							enctype="multipart/form-data" action="/rest/dou/add">
							<!-- DoU Name -->
							<div class="form-group row">
								<label for="dou-name"
									class="ml-3 col-form-label col-form-label-sm"><b>DoU
										Name</b></label>
								<div class="col-sm-6">
									<input type="text" class="form-control form-control-sm"
										id="dou-name" name="dou_name" placeholder="Enter DoU Name">
								</div>
							</div>

							<!-- DoU Access -->
							<div class="form-group row">
								<label for="dou-access-to-search"
									class="ml-3 col-form-label col-form-label-sm"><b>Access
										to</b></label>
								<div class="col-sm-6">
									<input data-toggle="dropdown" aria-haspopup="true"
										aria-expanded="false" type="text"
										class="form-control form-control-sm" id="dou-access-to-search"
										name="dou_access_to_search" placeholder="Enter EmailId"
										onkeyup="liveSearchTimer(this)"> <input type="hidden"
										class="form-control form-control-sm" id="dou-access-to"
										name="access_to" value="">
									<div id="dou-access-to-search-result" class="dropdown-menu"
										aria-labelledby="dou-access-to-search" tabindex="0">
										<a class='dropdown-item'>Enter email Id to search</a>
									</div>
								</div>
							</div>

							<!-- DoU Access list -->
							<div id="access-to-email-badges" class="form-group row ml-1"></div>

							<!-- DoU File -->
							<div class="custom-file input-group input-group-sm mb-3">
								<input type="file"
									class="custom-file-input form-control form-control-sm dou-file-input"
									id="dou-file" name="DoU" required> <label
									style="overflow: hidden;" class="custom-file-label"
									for="dou-file" data-toggle="tooltip" data-placement="bottom"
									data-original-title="No File Selected">Choose DoU</label>
							</div>

							<!-- Comments -->
							<textarea class="form-control shadow" name="comments"
								placeholder="Write a comment(Optional)..." cols=3></textarea>

							<p class="ml-3" id="dou-submit-instruction"></p>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">Close</button>
								<button id="initiate-button" type="submit"
									class="btn btn-primary">Initiate</button>
								<button id="initiate-button-disabled"
									class="btn btn-primary d-none" type="button" disabled>
									<span class="spinner-grow spinner-grow-sm" role="status"
										aria-hidden="true"></span> Initiating...
								</button>
							</div>
							<p class="card-text">
								<small class="modal-tip font-weight-bold font-italic">Share
									your DoU for approval here. Add all the required people to
									approve the DoU. </small>
							</p>
						</form>
					</div>

				</div>
			</div>
		</div>
		<%
			}
		%>


		<!-- Content Row -->
		<div class="row">



        
			






			<!-- DoU pending status card -->
			<div class="col-2 mb-4">
				<div class="card border-left-success shadow h-100 py-2">
					<div class="card-body pb-0">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div
									class="text-xs font-weight-bold text-success text-uppercase mb-1">Shopping
									Malls</div>
								<div id="status-pending-count"
									class="h5 mb-0 font-weight-bold text-gray-800 smcount">9</div>
							</div>
							<div class="col-auto small">
								<i class="fas fa-store fa-circle fa-2x text-dark"></i>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- DoU approved status card -->
			<div class="col-2 mb-4">
				<div class="card border-left-success shadow h-100 py-2">
					<div class="card-body pb-0">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div
									class="text-xs font-weight-bold text-success text-uppercase mb-1">Hospitals</div>
								<div class="row no-gutters align-items-center">
									<div class="col-auto">
										<div id="status-approved-count"
											class="h5 mb-0 mr-3 font-weight-bold text-gray-800 hcount">23</div>
									</div>

								</div>
							</div>
							<div class="col-auto small">
								<i class="far fa-hospital fa-circle fa-2x text-dark"></i>
							</div>
						</div>

					</div>
				</div>
			</div>

			<!-- DoU rejected status card -->
			<div class="col-2 mb-4">
				<div class="card border-left-success shadow h-100 py-2">
					<div class="card-body pb-0">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div
									class="text-xs font-weight-bold text-success text-uppercase mb-1">Pharmacies</div>
								<div class="row no-gutters align-items-center">
									<div class="col-auto">
										<div id="status-canceled-count"
											class="h5 mb-0 mr-3 font-weight-bold text-gray-800 pcount">42</div>
									</div>
								</div>
							</div>
							<div class="col-auto small">
								<i class="fas fa-first-aid fa-circle fa-2x text-dark"></i>
							</div>
						</div>

					</div>
				</div>
			</div>





			<!-- DoU approved status card -->
			<div class="col-2 mb-4">
				<div class="card border-left-success shadow h-100 py-2">
					<div class="card-body pb-0">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div
									class="text-xs font-weight-bold text-success text-uppercase mb-1">Restaurants</div>
								<div class="row no-gutters align-items-center">
									<div class="col-auto">
										<div id="status-approved-count"
											class="h5 mb-0 mr-3 font-weight-bold text-gray-800 rcount">15</div>
									</div>
								</div>
							</div>
							<div class="col-auto small">
								<i class="fas fa-utensils fa-circle fa-2x text-dark"></i>
							</div>
						</div>

					</div>
				</div>
			</div>





			




			<!-- DoU approved status card -->
			<div class="col-2 mb-4">
				<div class="card border-left-success shadow h-100 py-2">
					<div class="card-body pb-0">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div
									class="text-xs font-weight-bold text-success text-uppercase mb-1">Groceries
									</div>
								<div class="row no-gutters align-items-center">
									<div class="col-auto">
										<div id="status-approved-count"
											class="h5 mb-0 mr-3 font-weight-bold text-gray-800 gcount">32</div>
									</div>
								</div>
							</div>
							<div class="col-auto small">
								<i class="fas fa-shopping-cart fa-circle fa-2x text-dark"></i>
							</div>
						</div>

					</div>
				</div>
			</div>


			<!-- ranking cards -->


		</div>
		<!-- Recent DoUs heading -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h3 mb-0 text-dark">
				Showing <b id="category-name">Hospitals</b>
			</h1>
		</div>

		<!-- Content Row  for cards in masonry arrangement-->
		<div id="relevant-cards" class="row view-group d-flex justify-content-start">

			<div class="card m-2" style="width: 23rem;">
				<div class="card-body">
					<div class="d-flex justify-content-between">
						<h4 class="card-title font-weight-bold">Apollo</h4>
						<div class="h5">
							<span class="badge badge-success">3.8 <i class="far fa-star"></i></span>
						</div>

					</div>

					<h6 class="card-subtitle mb-3 small text-muted">Bheema
						Building, Kentucky road, Opp IIM Blr, Bangalore</h6>
					<div class="card-text">
						<dl class="row">
							<dt class="col-sm-6">Sanitization </dt>
							<dd class="col-sm-6 font-weight-bold text-success">Good</dd>

							<dt class="col-sm-6">Temperature Sensor</dt>
							<dd class="col-sm-6 font-weight-bold text-danger">Not available</dd>

							<dt class="col-sm-6">Social Distancing</dt>
							<dd class="col-sm-6 font-weight-bold text-warning">Not well maintained</dd>

							<dt class="col-sm-6">Mask</dt>
							<dd class="col-sm-6 font-weight-bold text-success">Mandatory</dd>

						</dl>
					</div>
					<h5>
						<a href="#"
							class="stretched-link float-right"> </a>
					</h5>
				</div>
			</div>
			
			<div class="card m-2" style="width: 23rem;">
				<div class="card-body">
					<div class="d-flex justify-content-between">
						<h4 class="card-title font-weight-bold">Apollo</h4>
						<div class="h5">
							<span class="badge badge-success">3.8 <i class="far fa-star"></i></span>
						</div>

					</div>

					<h6 class="card-subtitle mb-3 small text-muted">Bheema
						Building, Kentucky road, Opp IIM Blr, Bangalore</h6>
					<div class="card-text">
						<dl class="row">
							<dt class="col-sm-6">Sanitization </dt>
							<dd class="col-sm-6 font-weight-bold text-success">Good</dd>

							<dt class="col-sm-6">Temperature Sensor</dt>
							<dd class="col-sm-6 font-weight-bold text-danger">Not available</dd>

							<dt class="col-sm-6">Social Distancing</dt>
							<dd class="col-sm-6 font-weight-bold text-warning">Not well maintained</dd>

							<dt class="col-sm-6">Mask</dt>
							<dd class="col-sm-6 font-weight-bold text-success">Mandatory</dd>

						</dl>
					</div>
					<h5>
						<a href="#"
							class="stretched-link float-right"> </a>
					</h5>
				</div>
			</div>
			
			<div class="card m-2" style="width: 23rem;">
				<div class="card-body">
					<div class="d-flex justify-content-between">
						<h4 class="card-title font-weight-bold">Apollo</h4>
						<div class="h5">
							<span class="badge badge-success">3.8 <i class="far fa-star"></i></span>
						</div>

					</div>

					<h6 class="card-subtitle mb-3 small text-muted">Bheema
						Building, Kentucky road, Opp IIM Blr, Bangalore</h6>
					<div class="card-text">
						<dl class="row">
							<dt class="col-sm-6">Sanitization </dt>
							<dd class="col-sm-6 font-weight-bold text-success">Good</dd>

							<dt class="col-sm-6">Temperature Sensor</dt>
							<dd class="col-sm-6 font-weight-bold text-danger">Not available</dd>

							<dt class="col-sm-6">Social Distancing</dt>
							<dd class="col-sm-6 font-weight-bold text-warning">Not well maintained</dd>

							<dt class="col-sm-6">Mask</dt>
							<dd class="col-sm-6 font-weight-bold text-success">Mandatory</dd>

						</dl>
					</div>
					<h5>
						<a href="#"
							class="stretched-link float-right"> </a>
					</h5>
				</div>
			</div>
			
			<div class="card m-2" style="width: 23rem;">
				<div class="card-body">
					<div class="d-flex justify-content-between">
						<h4 class="card-title font-weight-bold">Apollo</h4>
						<div class="h5">
							<span class="badge badge-success">3.8 <i class="far fa-star"></i></span>
						</div>

					</div>

					<h6 class="card-subtitle mb-3 small text-muted">Bheema
						Building, Kentucky road, Opp IIM Blr, Bangalore</h6>
					<div class="card-text">
						<dl class="row">
							<dt class="col-sm-6">Sanitization </dt>
							<dd class="col-sm-6 font-weight-bold text-success">Good</dd>

							<dt class="col-sm-6">Temperature Sensor</dt>
							<dd class="col-sm-6 font-weight-bold text-danger">Not available</dd>

							<dt class="col-sm-6">Social Distancing</dt>
							<dd class="col-sm-6 font-weight-bold text-warning">Not well maintained</dd>

							<dt class="col-sm-6">Mask</dt>
							<dd class="col-sm-6 font-weight-bold text-success">Mandatory</dd>

						</dl>
					</div>
					<h5>
						<a href="#"
							class="stretched-link float-right"> </a>
					</h5>
				</div>
			</div>
			
			<div class="card m-2" style="width: 23rem;">
				<div class="card-body">
					<div class="d-flex justify-content-between">
						<h4 class="card-title font-weight-bold">Apollo</h4>
						<div class="h5">
							<span class="badge badge-success">3.8 <i class="far fa-star"></i></span>
						</div>

					</div>

					<h6 class="card-subtitle mb-3 small text-muted">Bheema
						Building, Kentucky road, Opp IIM Blr, Bangalore</h6>
					<div class="card-text">
						<dl class="row">
							<dt class="col-sm-6">Sanitization </dt>
							<dd class="col-sm-6 font-weight-bold text-success">Good</dd>

							<dt class="col-sm-6">Temperature Sensor</dt>
							<dd class="col-sm-6 font-weight-bold text-danger">Not available</dd>

							<dt class="col-sm-6">Social Distancing</dt>
							<dd class="col-sm-6 font-weight-bold text-warning">Not well maintained</dd>

							<dt class="col-sm-6">Mask</dt>
							<dd class="col-sm-6 font-weight-bold text-success">Mandatory</dd>

						</dl>
					</div>
					<h5>
						<a href="#"
							class="stretched-link float-right"> </a>
					</h5>
				</div>
			</div>
			
			<div class="card m-2" style="width: 23rem;">
				<div class="card-body">
					<div class="d-flex justify-content-between">
						<h4 class="card-title font-weight-bold">Apollo</h4>
						<div class="h5">
							<span class="badge badge-success">3.8 <i class="far fa-star"></i></span>
						</div>

					</div>

					<h6 class="card-subtitle mb-3 small text-muted">Bheema
						Building, Kentucky road, Opp IIM Blr, Bangalore</h6>
					<div class="card-text">
						<dl class="row">
							<dt class="col-sm-6">Sanitization </dt>
							<dd class="col-sm-6 font-weight-bold text-success">Good</dd>

							<dt class="col-sm-6">Temperature Sensor</dt>
							<dd class="col-sm-6 font-weight-bold text-danger">Not available</dd>

							<dt class="col-sm-6">Social Distancing</dt>
							<dd class="col-sm-6 font-weight-bold text-warning">Not well maintained</dd>

							<dt class="col-sm-6">Mask</dt>
							<dd class="col-sm-6 font-weight-bold text-success">Mandatory</dd>

						</dl>
					</div>
					<h5>
						<a href="#"
							class="stretched-link float-right"> </a>
					</h5>
				</div>
			</div>
			
			<div class="card m-2" style="width: 23rem;">
				<div class="card-body">
					<div class="d-flex justify-content-between">
						<h4 class="card-title font-weight-bold">Apollo</h4>
						<div class="h5">
							<span class="badge badge-success">3.8 <i class="far fa-star"></i></span>
						</div>

					</div>

					<h6 class="card-subtitle mb-3 small text-muted">Bheema
						Building, Kentucky road, Opp IIM Blr, Bangalore</h6>
					<div class="card-text">
						<dl class="row">
							<dt class="col-sm-6">Sanitization </dt>
							<dd class="col-sm-6 font-weight-bold text-success">Good</dd>

							<dt class="col-sm-6">Temperature Sensor</dt>
							<dd class="col-sm-6 font-weight-bold text-danger">Not available</dd>

							<dt class="col-sm-6">Social Distancing</dt>
							<dd class="col-sm-6 font-weight-bold text-warning">Not well maintained</dd>

							<dt class="col-sm-6">Mask</dt>
							<dd class="col-sm-6 font-weight-bold text-success">Mandatory</dd>

						</dl>
					</div>
					<h5>
						<a href="#"
							class="stretched-link float-right"> </a>
					</h5>
				</div>
			</div>
			
			<div class="card m-2" style="width: 23rem;">
				<div class="card-body">
					<div class="d-flex justify-content-between">
						<h4 class="card-title font-weight-bold">Apollo</h4>
						<div class="h5">
							<span class="badge badge-success">3.8 <i class="far fa-star"></i></span>
						</div>

					</div>

					<h6 class="card-subtitle mb-3 small text-muted">Bheema
						Building, Kentucky road, Opp IIM Blr, Bangalore</h6>
					<div class="card-text">
						<dl class="row">
							<dt class="col-sm-6">Sanitization </dt>
							<dd class="col-sm-6 font-weight-bold text-success">Good</dd>

							<dt class="col-sm-6">Temperature Sensor</dt>
							<dd class="col-sm-6 font-weight-bold text-danger">Not available</dd>

							<dt class="col-sm-6">Social Distancing</dt>
							<dd class="col-sm-6 font-weight-bold text-warning">Not well maintained</dd>

							<dt class="col-sm-6">Mask</dt>
							<dd class="col-sm-6 font-weight-bold text-success">Mandatory</dd>

						</dl>
					</div>
					<h5>
						<a href="#"
							class="stretched-link float-right"> </a>
					</h5>
				</div>
			</div>
			
			<div class="card m-2" style="width: 23rem;">
				<div class="card-body">
					<div class="d-flex justify-content-between">
						<h4 class="card-title font-weight-bold">Apollo</h4>
						<div class="h5">
							<span class="badge badge-success">3.8 <i class="far fa-star"></i></span>
						</div>

					</div>

					<h6 class="card-subtitle mb-3 small text-muted">Bheema
						Building, Kentucky road, Opp IIM Blr, Bangalore</h6>
					<div class="card-text">
						<dl class="row">
							<dt class="col-sm-6">Sanitization </dt>
							<dd class="col-sm-6 font-weight-bold text-success">Good</dd>

							<dt class="col-sm-6">Temperature Sensor</dt>
							<dd class="col-sm-6 font-weight-bold text-danger">Not available</dd>

							<dt class="col-sm-6">Social Distancing</dt>
							<dd class="col-sm-6 font-weight-bold text-warning">Not well maintained</dd>

							<dt class="col-sm-6">Mask</dt>
							<dd class="col-sm-6 font-weight-bold text-success">Mandatory</dd>

						</dl>
					</div>
					<h5>
						<a href="#"
							class="stretched-link float-right"> </a>
					</h5>
				</div>
			</div>
			
			<div class="card m-2" style="width: 23rem;">
				<div class="card-body">
					<div class="d-flex justify-content-between">
						<h4 class="card-title font-weight-bold">Apollo</h4>
						<div class="h5">
							<span class="badge badge-success">3.8 <i class="far fa-star"></i></span>
						</div>

					</div>

					<h6 class="card-subtitle mb-3 small text-muted">Bheema
						Building, Kentucky road, Opp IIM Blr, Bangalore</h6>
					<div class="card-text">
						<dl class="row">
							<dt class="col-sm-6">Sanitization </dt>
							<dd class="col-sm-6 font-weight-bold text-success">Good</dd>

							<dt class="col-sm-6">Temperature Sensor</dt>
							<dd class="col-sm-6 font-weight-bold text-danger">Not available</dd>

							<dt class="col-sm-6">Social Distancing</dt>
							<dd class="col-sm-6 font-weight-bold text-warning">Not well maintained</dd>

							<dt class="col-sm-6">Mask</dt>
							<dd class="col-sm-6 font-weight-bold text-success">Mandatory</dd>

						</dl>
					</div>
					<h5>
						<a href="#"
							class="stretched-link float-right"> </a>
					</h5>
				</div>
			</div>
			
			<div class="card m-2" style="width: 23rem;">
				<div class="card-body">
					<div class="d-flex justify-content-between">
						<h4 class="card-title font-weight-bold">Apollo</h4>
						<div class="h5">
							<span class="badge badge-success">3.8 <i class="far fa-star"></i></span>
						</div>

					</div>

					<h6 class="card-subtitle mb-3 small text-muted">Bheema
						Building, Kentucky road, Opp IIM Blr, Bangalore</h6>
					<div class="card-text">
						<dl class="row">
							<dt class="col-sm-6">Sanitization </dt>
							<dd class="col-sm-6 font-weight-bold text-success">Good</dd>

							<dt class="col-sm-6">Temperature Sensor</dt>
							<dd class="col-sm-6 font-weight-bold text-danger">Not available</dd>

							<dt class="col-sm-6">Social Distancing</dt>
							<dd class="col-sm-6 font-weight-bold text-warning">Not well maintained</dd>

							<dt class="col-sm-6">Mask</dt>
							<dd class="col-sm-6 font-weight-bold text-success">Mandatory</dd>

						</dl>
					</div>
					<h5>
						<a href="#"
							class="stretched-link float-right"> </a>
					</h5>
				</div>
			</div>
			
			<div class="card m-2" style="width: 23rem;">
				<div class="card-body">
					<div class="d-flex justify-content-between">
						<h4 class="card-title font-weight-bold">Apollo</h4>
						<div class="h5">
							<span class="badge badge-success">3.8 <i class="far fa-star"></i></span>
						</div>

					</div>

					<h6 class="card-subtitle mb-3 small text-muted">Bheema
						Building, Kentucky road, Opp IIM Blr, Bangalore</h6>
					<div class="card-text">
						<dl class="row">
							<dt class="col-sm-6">Sanitization </dt>
							<dd class="col-sm-6 font-weight-bold text-success">Good</dd>

							<dt class="col-sm-6">Temperature Sensor</dt>
							<dd class="col-sm-6 font-weight-bold text-danger">Not available</dd>

							<dt class="col-sm-6">Social Distancing</dt>
							<dd class="col-sm-6 font-weight-bold text-warning">Not well maintained</dd>

							<dt class="col-sm-6">Mask</dt>
							<dd class="col-sm-6 font-weight-bold text-success">Mandatory</dd>

						</dl>
					</div>
					<h5>
						<a href="#"
							class="stretched-link float-right"> </a>
					</h5>
				</div>
			</div>
			
			<div class="card m-2" style="width: 23rem;">
				<div class="card-body">
					<div class="d-flex justify-content-between">
						<h4 class="card-title font-weight-bold">Apollo</h4>
						<div class="h5">
							<span class="badge badge-success">3.8 <i class="far fa-star"></i></span>
						</div>

					</div>

					<h6 class="card-subtitle mb-3 small text-muted">Bheema
						Building, Kentucky road, Opp IIM Blr, Bangalore</h6>
					<div class="card-text">
						<dl class="row">
							<dt class="col-sm-6">Sanitization </dt>
							<dd class="col-sm-6 font-weight-bold text-success">Good</dd>

							<dt class="col-sm-6">Temperature Sensor</dt>
							<dd class="col-sm-6 font-weight-bold text-danger">Not available</dd>

							<dt class="col-sm-6">Social Distancing</dt>
							<dd class="col-sm-6 font-weight-bold text-warning">Not well maintained</dd>

							<dt class="col-sm-6">Mask</dt>
							<dd class="col-sm-6 font-weight-bold text-success">Mandatory</dd>

						</dl>
					</div>
					<h5>
						<a href="#"
							class="stretched-link float-right"> </a>
					</h5>
				</div>
			</div>
			
		</div>
	</div>



	<!-- /.container-fluid -->
	<%@ include file="Footer.jsp"%>

	<!-- Page level plugins -- index.jsp-->
	<!-- <script src="vendor/chart.js/Chart.min.js"></script> -->

	<!-- Page level custom scripts -- index.jsp-->
	<!-- <script src="js/demo/chart-area-demo.js"></script>
	<script src="js/demo/chart-pie-demo.js"></script> -->
	<script src="js/CommonUtils.js"></script>
	<script src="js/index.js"></script>
	<script src="js/Form.js"></script>

</body>
</html>






<!--  "name" : "Prabhat Kumar",
        "email" : "prabhat.kumar@in.ibm.com",
        "sanitization" : true,
        "temperature_sensor" : true,
        "social_distancing" : false,
        "mask" : "mandatory",
        "rating" : "3.5",
        "review_comment" : -->
        
        

<!-- function getCard(catName, count)
{
return
    '<div class="col-2 mb-4"><div class="card border-left-success shadow h-100 py-2"><div class="card-body pb-0">
	<div class="row no-gutters align-items-center"><div class="col mr-2">
	<div class="text-xs font-weight-bold text-success text-uppercase mb-1">catName</div>
	<div id="status-pending-count" class="h5 mb-0 font-weight-bold text-gray-800">count</div></div>
	<div class="col-auto small"><i class="fas fa-store fa-circle fa-2x text-dark"></i></div>
	</div></div></div></div>'
	} -->