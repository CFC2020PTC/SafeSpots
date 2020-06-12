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
<link href="css/ChatBox.css" rel="stylesheet">
<link href="css/CommonStyles.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<body id="page-top">

	<%@ include file="Header.jsp"%>

	<!-- DoM templates start -->

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
			<!-- <h1 class="h3 mb-0 text-dark">
				Showing <b id="category-name">Hospitals</b>
			</h1> -->


			<!-- Extra large modal
			<button type="button" class="btn btn-primary" data-toggle="modal"
				data-target=".bd-example-modal-xl">Extra large modal</button> -->

			<div id="details-modal" class="modal fade bd-example-modal-xl"
				tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-xl">
					<div class="modal-content">
						<div id="dou" locationId="" class="card-body pl-0 pr-0">
							<div id="dou-header"
								class="dynamic-block card-header border dynamic-border-color border-bottom-0 rounded-bottom"
								style="display: block">
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close" style="padding-left: 10px;">
									<span aria-hidden="true">&times;</span>
								</button>
								<div id="" class="float-right">
									<button id="contact-button" class="btn btn-outline-dark">Contact
									</button>
								</div>
								<div>
									<b id="location-name" class="card-title font-weight-bold h2">Apollo</b>
									<b id="location-rating-wrapper"
										class="card-title badge badge-dark ml-3 h1"
										style="padding: 5px; font-size: 20px;">Overall <i
										id="location-rating">3.8</i> <i class="far fa-star"></i>
									</b>
								</div>


								<footer id="location-address"
									class="card-subtitle blockquote-footer" id="address"
									class="text-dark font-weight-bold" title="Initiated Time">Bheema
								Building, Kentucky road, Opp IIM Blr, Bangalore</footer>
							</div>
							<div class="dynamic-block tab-content" id="myTabContent"
								style="display: block">
								<!-- Details Tab -->
								<div id="details"
									class="card tab-pane fade shadow dynamic-border-color active show border-top-0"
									role="tabpanel" aria-labelledby="details-tab">

									<div class="card-body">
										<!-- <div id="desc" class="">
									<p class="card-text">Apollo Clinics are multi-specialty
										clinics run by Apollo Health & Lifestyle Limited (AHLL), a
										subsidiary of Apollo Hospitals Enterprise Limited (AHEL). AHLL
										is one of the largest players in the retail healthcare segment
										in India.</p>
									<p class="card-text">Apollo Clinics was founded in 2002
										with the aim “to bring healthcare of international standards
										within the reach of every individual.” To achieve this, Apollo
										Clinics run a large network of Apollo Clinics with over 75
										clinics, both owned and franchised in India and overseas.</p>
									<p class="card-text">Each Apollo Clinic is committed to not
										only providing consistently superior quality health care
										services but also addressing the day-to-day health care needs
										of the family. To maximize convenience and comfort, Apollo
										Clinic is an integrated model and offers facilities for
										Specialist Consultation, Diagnostics, Preventive Health Checks
										and Pharmacy, all under one roof.</p>
								</div> -->
									</div>

									<div id="reviews&ratings"
										class="card dynamic-border-color border-0">

										<!-- <div class="d-flex justify-content-between">
										<h4 class="mx-4">Review & Ratings</h4>
										<div class="mr-4 h3 border border-dark rounded p-1">
											Overall <b>3.8/5</b>
										</div>
									</div> -->
										<div class="card-group p-2 border-0" id="ratings">
											<div class="col-3 mb-4">
												<div class="card border-left-info shadow h-100 py-2">
													<div class="card-body">
														<div class="row no-gutters align-items-center">
															<div class="col mr-2">
																<div
																	class="h6 small font-weight-bold text-info text-uppercase mb-1">Sanitization</div>
																<div class="row no-gutters align-items-center">
																	<div class="col-auto mr-4 small">
																		<i class="fas fa-pump-medical fa-2x text-dark"></i>
																	</div>

																	<div class="col">
																		<div class="progress progress-sm mr-2">
																			<div id="sanitization-rating-progress"
																				class="progress-bar bg-info" role="progressbar"
																				style="width: 68%" aria-valuenow="50"
																				aria-valuemin="0" aria-valuemax="100"></div>
																		</div>
																	</div>
																</div>
															</div>
															<div class="col-auto">
																<div class="h5 mr-2 font-weight-bold text-gray-800">
																	<i id="sanitization-rating">3.4</i><i>/5</i>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>

											<div class="col-3 mb-4">
												<div class="card border-left-info shadow h-100 py-2">
													<div class="card-body">
														<div class="row no-gutters align-items-center">
															<div class="col mr-2">
																<div
																	class="h6 small font-weight-bold text-info text-uppercase mb-1">Temperature
																	Sensor</div>
																<div class="row no-gutters align-items-center">
																	<div class="col-auto mr-4 small">
																		<i class="fas fa-temperature-high fa-2x text-dark"></i>
																	</div>

																	<div class="col">
																		<div class="progress progress-sm mr-2">
																			<div id="temp-sensor-rating-progress"
																				class="progress-bar bg-info" role="progressbar"
																				style="width: 68%" aria-valuenow="50"
																				aria-valuemin="0" aria-valuemax="100"></div>
																		</div>
																	</div>
																</div>
															</div>
															<div class="col-auto">
																<div class="h5 mr-2 font-weight-bold text-gray-800">
																	<i id="temp-sensor-rating">3.4</i><i>/5</i>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>

											<div class="col-3 mb-4">
												<div class="card border-left-info shadow h-100 py-2">
													<div class="card-body">
														<div class="row no-gutters align-items-center">
															<div class="col mr-2">
																<div
																	class="h6 small font-weight-bold text-info text-uppercase mb-1">Social
																	Distancing</div>
																<div class="row no-gutters align-items-center">
																	<div class="col-auto mr-4 small">
																		<i class="fas fa-people-arrows fa-2x text-dark"></i>
																	</div>

																	<div class="col">
																		<div class="progress progress-sm mr-2">
																			<div id="social-distance-rating-progress"
																				class="progress-bar bg-info" role="progressbar"
																				style="width: 68%" aria-valuenow="50"
																				aria-valuemin="0" aria-valuemax="100"></div>
																		</div>
																	</div>
																</div>
															</div>
															<div class="col-auto">
																<div class="h5 mr-2 font-weight-bold text-gray-800">
																	<i id="social-distance-rating">3.4</i><i>/5</i>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>

											<div class="col-3 mb-4">
												<div class="card border-left-info shadow h-100 py-2">
													<div class="card-body">
														<div class="row no-gutters align-items-center">
															<div class="col mr-2">
																<div
																	class="h6 small font-weight-bold text-info text-uppercase mb-1">Mask</div>
																<div class="row no-gutters align-items-center">
																	<div class="col-auto mr-4 small">
																		<i class="fas fa-head-side-mask fa-2x text-dark"></i>
																	</div>

																	<div class="col">
																		<div class="progress progress-sm mr-2">
																			<div id="mask-rating-progress"
																				class="progress-bar bg-info" role="progressbar"
																				style="width: 68%" aria-valuenow="50"
																				aria-valuemin="0" aria-valuemax="100"></div>
																		</div>
																	</div>
																</div>
															</div>
															<div class="col-auto">
																<div class="h5 mr-2 font-weight-bold text-gray-800">
																	<i id="mask-rating">3.4</i><i>/5</i>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>

										</div>
										<div class="accordion" id="accordionExample">
											<div class="card">
												<div class="card-header" id="headingOne">
													<h2 class="mb-0">
														<button class="btn btn-link" type="button"
															data-toggle="collapse" data-target="#collapseOne"
															aria-expanded="true" aria-controls="collapseOne">
															Provide feedback</button>
													</h2>
												</div>

												<div id="collapseOne" class="collapse show"
													aria-labelledby="headingOne"
													data-parent="#accordionExample">
													<div class="card-body">
														<div class="card-body p-4">
															<iframe src="/SafeSpots/feedback.jsp" width="1000vh" height="650vh"></iframe>
														</div>
													</div>
												</div>
											</div>
											<div class="card">
												<div class="card-header" id="headingTwo">
													<h2 class="mb-0">
														<button class="btn btn-link collapsed" type="button"
															data-toggle="collapse" data-target="#collapseTwo"
															aria-expanded="false" aria-controls="collapseTwo">
															Reviews</button>
													</h2>
												</div>
												<div id="collapseTwo" class="collapse"
													aria-labelledby="headingTwo"
													data-parent="#accordionExample">
													<div class="card-body">
														<div class="row bootstrap snippets">
															<div class="col-md-offset-2 col-sm-12">
																<div class="review-wrapper">
																	<div class="panel panel-info">
																		<p id="no-review-instruction" class="card-text"
																			style="text-align: center;">No Reviews yet</p>

																		<!-- Comment card template -->
																		<div style="display: none;">

																			<div id="review-div-template"
																				class="card shadow w-75 mb-3">
																				<div  class="p-0 pl-2">
																					<strong id="review-author-div" class="author"></strong>
																				</div>
																				<div id="reivew-body-div"
																					class="card-body text-dark p-0 pl-2"></div>
																				<footer
																					class="ml-3 text-uppercase blockquote-footer time">Overall
																				Rating : <b id="author-overall-rating">3.8</b></footer>
																			</div>

																		</div>

																		<div id="reviews-list" class="panel-body"
																			style="display: block"></div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>

									</div>

								</div>
							</div>

						</div>
					</div>
				</div>
			</div>



		</div>

		<div id="template-card" style="display: none;">
			<div class="card m-2" style="width: 23rem;">
				<div id="location-category"
					class="footer badge badge-pill badge-dark font-weight-bold float-left text-wrap w-25 mt-1 ml-1">Hospital</div>
				<div class="card-body">
					<div class="d-flex justify-content-between">
						<h3 id="location-name" class="card-title font-weight-bold">Apollo</h3>
						<div class="h5">
							<span class="badge"><i id="location-rating">3.8</i> <i
								class="far fa-star"></i></span>
						</div>

					</div>

					<h6 id="location-address"
						class="card-subtitle mb-3 small text-muted">Bheema Building,
						Kentucky road, Opp IIM Blr, Bangalore</h6>
					<div class="card-text">
						<dl class="row">
							<dt class="col-sm-6">Sanitization</dt>
							<dd id="sanitization-value" class="col-sm-6 font-weight-bold ">Good</dd>

							<dt class="col-sm-6">Temperature Sensor</dt>
							<dd id="temp-sensor-value" class="col-sm-6 font-weight-bold ">Not
								available</dd>

							<dt class="col-sm-6">Social Distancing</dt>
							<dd id="social-distance-value" class="col-sm-6 font-weight-bold ">Not
								well maintained</dd>

							<dt class="col-sm-6">Mask</dt>
							<dd id="mask-value" class="col-sm-6 font-weight-bold ">Mandatory</dd>

						</dl>
					</div>
					<h5>
						<a id="details-page-link" href="#" data-toggle="modal"
							data-target=".bd-example-modal-xl"
							class="stretched-link float-right" onclick="populateModal(this)">
						</a>
					</h5>
				</div>

			</div>
		</div>

		<!-- Content Row  for cards in masonry arrangement-->
		<div id="relevant-cards"
			class="row view-group d-flex justify-content-start"></div>
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