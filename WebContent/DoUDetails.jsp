<%@page import="ibm.ptc.dou.data.ValuesNotificationFrequency"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" />
<!-- <link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css" /> -->


<!-- Custom styles for this template -->
<link href="vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<link href="css/sb-admin-2.min.css" rel="stylesheet">

<!-- Custom styles for this page -->
<link href="css/DoUDetails.css" rel="stylesheet">
<link href="css/Form.css" rel="stylesheet">
<link href="css/ChatBox.css" rel="stylesheet">
<link href="css/TimeLine.css" rel="stylesheet">

<link href="css/CommonStyles.css" rel="stylesheet">
</head>

<body id="page-top" style="z-index: 1;">

	<%@ include file="Header.jsp"%>

	<!-- DatePicker Popover content start -->
	<div style="display: none">
		<div id="datepicker-popover-content-template">
			<div id="set-approval-due-date-form" class="set-approval-due-date-form" aria-person="">
				<div id="approval-due-date-config">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<label class="text-dark font-weight-bold mx-2" id="duedate-label">Due
								date to take action is</label>
						</div>
						<input id="approval-due-date" name="approval_due_date" type='text'
							class="form-control" placeholder="Due date" aria-label="Due date"
							aria-describedby="duedate-label" />
					</div>
				</div>
				<hr>
				<div id="approval-due-date-notification-config" class="">
					<div id="approval-due-date-notification-switch-wrapper-template"
						class="mb-2">
						<input id="approval-due-date-notification-switch-template"
							type="checkbox" class="" onchange="onSwitchToggle(this)"> <label
							id="approval-due-date-notification-switch-label-template"
							class="font-weight-bold text-dark"
							for="approval-due-date-notification-switch-template">Notification</label>
					</div>
					<fieldset id="notification-config-fieldset">
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<label class="text-dark font-weight-bold mx-2"
									id="approval-due-date-notification-start-date-label">Notification
									starts from</label>
							</div>
							<input id="approval-due-date-notification-start-date"
								name="notification_start_date" type='text' class="form-control"
								placeholder="Notification Start Date" aria-label="Start Date"
								aria-describedby="approval-due-date-notification-start-date-label" />
						</div>
						<div class="input-group mb-3">
							<label id="approval-due-date-notification-frequency-label-template" class="text-dark font-weight-bold mx-2"
								for="approval-due-date-notification-frequency-template">Notification
								frequency</label> <select class="form-control"
								id="approval-due-date-notification-frequency-template">
								<%
									for (ValuesNotificationFrequency val : ValuesNotificationFrequency.values()) {
								%><option value=<%=val.name()%>>
									<%=val.toString()%></option>
								<%
									}
								%>
							</select>
						</div>
					</fieldset>
				</div>
				<div id="status-change-btns-template">
					<button class="btn btn-sm btn-danger dou-tooltips"
						onclick="closePopoverFromInside(this)" data-placement="bottom"
						title="Close this form">Close</button>
					<button id="set-approval-due-date-form-submit-button" type="submit"
						onclick="setApprovalDueDate(this)"
						class="btn btn-sm btn-primary dou-tooltips"
						data-placement="bottom" title="Set this due date">Save</button>
					<button id="set-approval-due-date-form-submit-button-disabled"
						class="btn btn-sm btn-primary d-none" type="button" disabled>
						<span class="spinner-grow spinner-grow-sm" role="status"
							aria-hidden="true"></span> Saving...
					</button>
				</div>
			</div>
		</div>
	</div>
	<!-- DatePicker Popover content end -->


	<!-- UserBadge Template -->
	<div style="display: none">
		<span id="userbadge-template"
			class="m-1 badge badge-pill badge-dark userbadge-wrapper"><h6
				class="text-danger mr-2" style="float: left">
				<i class="fa fa-times-circle" aria-hidden="true"
					onclick="removeUserBadge(this)"></i>
			</h6>
			<div style="float: left">
				<div id="email"></div>
				<div id="role" class="mt-1 text-success" selectedRole=""></div>
			</div> </span>
	</div>
	<%
		Map<String, String> colourMap = new HashMap<String, String>() {
			{
				put("", "");
				put("NEW", "primary");
				put("PENDING", "info");
				put("APPROVED", "success");
				put("CANCELED", "danger");
			}
		};
	%>
	<!-- Begin Page Content -->
	<div class="container-fluid">
		<div class="row mb-4">
			<div class="dropdown">
				<button class="btn btn-secondary dropdown-toggle" type="button"
					id="dou-list-btn" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false">Select DoU</button>
				<div class="dropdown-menu scrollable-menu"
					aria-labelledby="dou-list-btn">
					<input class="form-control" id="search-dou" type="text"
						placeholder="Search DoUs.."></input>
					<div class="dropdown-divider"></div>
					
				</div>
			</div>
		</div>
		<div class="mb-4 row">
			<div class="card col-lg-12">
				<div class="card-header">
					<ul class="float-left nav nav-tabs card-header-tabs">
						<li class="nav-item"><a class="nav-link active"
							id="details-tab" data-toggle="tab" href="#details" role="tab"
							aria-controls="Details" aria-selected="true">Details</a></li>
						<li class="nav-item"><a class="nav-link" id="comments-tab"
							data-toggle="tab" href="#comments" role="tab"
							aria-controls="Comments" aria-selected="false">Comments</a></li>
						<li class="nav-item"><a class="nav-link" id="attachments-tab"
							data-toggle="tab" href="#attachments" role="tab"
							aria-controls="Attachments" aria-selected="false">Attachments</a></li>
						<li class="nav-item"><a class="nav-link"
							id="revision-history-tab" data-toggle="tab"
							href="#revision-history" role="tab"
							aria-controls="Revision History" aria-selected="false">Revision
								History</a></li>
					</ul>
					<div class="dynamic-block">
						<button id="dou-download"
							class="float-right btn dynamic-btn-outline-color"
							onclick="downloadDoU()" data-toggle="tooltip"
							data-placement="top" title="" style="display: none">
							Download DoU <i class="fas fa-cloud-download-alt"></i>
						</button>
						<button id="dou-upload"
							class="mr-3 float-right btn dynamic-btn-outline-color"
							data-toggle="modal" data-target="#update-doufile-modal"
							onclick="populateDoUFileForm()" style="display: none">
							Update DoU <i class="fas fa-cloud-upload-alt"></i>
						</button>
					</div>
				</div>
				<div id="dou" groupId="" class="card-body pl-0 pr-0">
					<div id="dou-header"
						class="dynamic-block card-header border dynamic-border-color border-bottom-0 rounded-bottom"
						style="display: none">
						<h5>
							<b id="dou_name" class="card-title dynamic-text-color"></b> <b
								id="dou_file_version" class="card-title badge badge-dark ml-3"></b>
						</h5>

						<footer class="card-subtitle">Initiated by <cite
							id="created_by" class="text-dark font-weight-bold"
							title="Initiator"></cite>, on <cite id="created_time"
							class="text-dark font-weight-bold" title="Initiated Time"></cite></footer>
					</div>
					<p id="instruction" class="card-text" style="text-align: center;">Select
						a DoU to view Details</p>
					<div class="dynamic-block tab-content" id="myTabContent"
						style="display: none">
						<!-- Details Tab -->
						<div id="details"
							class="card tab-pane fade shadow dynamic-border-color active show border-top-0"
							role="tabpanel" aria-labelledby="details-tab">

							<div class="card-body">
								<p class="text-dark card-text">
								<p id="dou_status_prefix_connector"
									class="card-text text-dark d-inline"></p>
								<b id="dou_status" class="card-text dynamic-text-color d-inline"></b>
								<p id="dou_status_suffix_connector"
									class="card-text text-dark d-inline"></p>
								<b id="dou_status_suffix"
									class="card-text dynamic-text-color d-inline"></b>
								</p>

								<!-- New Access List -->
								<div class="dynamic-border-color rounded border w-50">
									<ul class="list-group list-group-flush">
										<li class="list-group-item text-dark font-weight-bold">
											<div id="" class="float-right">
												<button id="edit-access-btn"
													class="btn btn-outline-dark dou-tooltips"
													data-toggle="modal" data-target="#edit-access-modal"
													data-placement="top" title="Edit the access to this DoU"
													onclick="populateEditAccessForm()">Edit Access</button>
												<button id="delegate-access-btn"
													class="btn btn-outline-dark dou-tooltips"
													data-toggle="modal" data-placement="top"
													title="Delegate your access to this DoU"
													data-target="#delegate-access-modal"
													onclick="populateDelegateAccessForm()">Delegate
													Access</button>
												<button id="add-reviewer-access-btn"
													class="btn btn-outline-dark dou-tooltips"
													data-toggle="modal" data-placement="top"
													title="Add a Product Reviewer to this DoU"
													data-target="#add-reviewer-modal"
													onclick="populateAddReviewerAccessForm()">Add
													Reviewers</button>
											</div>
										</li>
									</ul>
									<ul id="people-list" class="list-group list-group-flush">

									</ul>
								</div>

								<footer class="mt-5 blockquote-footer">DoU was last
								modified on <cite id="last_modified_time"
									class="text-dark font-weight-bold" title="DoU Last Modified On"></cite></footer>
							</div>

						</div>

						<!-- Comments Tab -->
						<div id="comments"
							class="card tab-pane fade shadow dynamic-border-color border-top-0"
							role="tabpanel" aria-labelledby="comments-tab">
							<div id="post-comment" class="card-body border-bottom"
								style="display: none">
								<div id="post-comment-div" class="row">
									<div class="float-left" style="width: 100%;">
										<textarea id="comment" class="form-control shadow"
											placeholder="write a comment..." cols=3></textarea>
										<p class="ml-2 mt-2" id="add-comment-instruction"
											style="float: left"></p>
										<div class="mr-2 float-right mt-2">
											<button id="comment-save-button" type="button"
												class="btn btn-outline-dark" onclick="addComment()">
												Save</i>
											</button>
										</div>
									</div>
								</div>
							</div>
							<div></div>
							<div class="card-body">
								<div class="row bootstrap snippets">
									<div class="col-md-offset-2 col-sm-12">
										<div class="comment-wrapper">
											<div class="panel panel-info">
												<p id="no-comments-instruction" class="card-text"
													style="text-align: center;">No Comments yet</p>

												<!-- Comment card template -->
												<div style="display: none;">
													<div id="comment-div-template"
														class="card shadow w-75 mb-3">
														<div id="comment-author-div" class="p-0">
															<strong class="author"></strong>
														</div>
														<div id="comment-body-div"
															class="card-body text-dark p-0 pl-2"></div>
														<footer id="comment-time-div"
															class="ml-3 blockquote-footer time"></footer>
													</div>
												</div>

												<div id="comments-list" class="panel-body"
													style="display: none">

													<div id="comment-div-template"
														class="card shadow w-75 mb-3 float-right bg-light">
														<div id="comment-author-div" class="p-0 pr-2 text-right">
															<strong class="author"></strong>
														</div>
														<div id="comment-body-div"
															class="card-body text-dark p-0 pl-2"></div>
														<footer id="comment-time-div"
															class="ml-3 blockquote-footer time"></footer>
													</div>


													<div class="card shadow w-75 mb-3">
														<div class="p-0 pl-2">
															<strong class="author"></strong>
														</div>
														<div class="card-body text-dark p-0 pl-2"></div>
														<footer class="ml-3 blockquote-footer time"></footer>
													</div>

												</div>
												<div id="log-div-template" class="card border border-0">
													<div class="card-body"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>


						<!-- Attachments Tab -->
						<div id="attachments"
							class="card tab-pane fade dynamic-border-color border-top-0"
							role="tabpanel" aria-labelledby="attachments-tab">
							<div class="card-body border-bottom">
								<div id="attachment-upload-progress-wrapper"
									class="progress mb-1" style="display: none">
									<div id="attachment-upload-progress"
										class="progress-bar progress-bar-striped progress-bar-animated bg-success"
										role="progressbar" style="width: 10%" aria-valuenow="10"
										aria-valuemin="0" aria-valuemax="100"></div>
								</div>
								<button id="upload-attachment-button" type="button"
									class="btn float-right btn-outline-dark"
									onclick="document.getElementById('attach-files').click()">
									Upload Files</button>
								<div id="btnContainer">
									<button class="btn" onclick="listView()">
										<i class="fa fa-bars"></i> List
									</button>
									<button class="btn active" onclick="gridView()">
										<i class="fa fa-th-large"></i> Grid
									</button>
								</div>
								<form id="attachments-form" method="post" action="#"
									style="display: none">
									<input id="attach-files" class="form-control form-control-sm"
										name="attachments" type="file">
									<button id="attachment-submit-button" type="submit" id="btn">Upload
										Files!</button>
								</form>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table card-list-table table-hover dou-table"
										id="attachments-table" width="100%" cellspacing="0">
										<thead class="thead">
											<tr>
												<th class="class-file-name">Name</th>
												<th class="class-updated-by">Updated By</th>
												<th class="class-updated-on">Updated On</th>
												<th class="class-size">Size</th>
												<th class="class-actions">Actions</th>
											</tr>
										</thead>
										<tbody id="attachments-list">

										</tbody>
									</table>
								</div>
							</div>
						</div>


						<!-- Revision History Tab -->
						<div id="revision-history"
							class="card tab-pane fade dynamic-border-color border-top-0"
							role="tabpanel" aria-labelledby="revision-history-tab">
							<div class="card-body border-bottom">
								<div class="row">
									<div class="col-md-12 col-lg-12">
										<p id="no-revision-history-instruction" class="card-text"
											style="text-align: center;">Nothing has been logged for
											this DoU yet</p>
										<div id="revision-history-list" class="revision-history-list">
											<!-- <div class="revision-history tracking-item w-75">
												<div id="event-icon"
													class="tracking-icon bg-success d-flex align-items-center justify-content-center border border-dark">
													<i class="far fa-file"></i>
												</div>
												<div class="tracking-date">
													<p id="date" class="text-dark">
														Jul 20, 2018<span id="time">08:58 AM</span>
													</p>
												</div>
												<div
													class="tracking-content border-left-success card border border-0 text-dark">
													<div id="revision-history-body"
														class="card-body text-dark pt-1">Shipment is out for
														despatch by KLHB023.</div>
												</div>
											</div>
											<div class="comment tracking-item w-75">
												<div id="event-icon"
													class="tracking-icon bg-primary d-flex align-items-center justify-content-center border border-dark">
													<i class="far fa-comment-alt"></i>
												</div>
												<div class="tracking-date">
													<p id="date" class="text-dark">
														Jul 20, 2018<span id="time">08:58 AM</span>
													</p>
												</div>
												<div class="card border border-primary tracking-content">
													<div
														class="card-header rounded-top font-weight-bold text-dark py-1">
														Comment by
														<p id="comment-author" class="d-inline text-primary">@sumanthk0708</p>
													</div>
													<div id="comment-body" class="card-body text-dark pt-2">
														Shipment is out for despatch by KLHB023.</div>
												</div>
											</div> -->
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- Approval/Reject button -->
						<div id="status-change-div"
							class="mt-2 btn-toolbar justify-content-between" role="toolbar"
							aria-label="Status Change Buttons">

							<div id="" class="float-left btn-group" role="group"
								aria-label="First group">
								<!-- Re-Initiate -->
								<div id="re-initiate-btn" class="ml-2 mr-2 float-left">
									<button class="btn btn-success" data-toggle="modal"
										onclick="populateDoUFormReinitiate()"
										data-target="#reinitiate-dou-modal" value="re-initiate">Re-Initiate
										DoU</button>
								</div>

								<!-- Cancel -->
								<div id="cancel-btn" class="ml-2 mr-2 float-left">
									<button class="btn btn-danger" data-toggle="modal"
										data-target="#cancel-dou-modal" value="cancel"
										onclick="populateDoUFormCancel()">Cancel DoU</button>
								</div>
							</div>

						</div>



					</div>

				</div>

				<!-- Edit access modal -->
				<div class="modal fade" id="edit-access-modal" tabindex="-1"
					role="dialog" aria-labelledby="edit-access-form-modal"
					aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="dou-upload-form">Edit Access</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<form method="POST" id="edit-access-form" action="#">
									<!-- DoU Name -->
									<div class="ml-2 form-group row">
										<h5 id="edit-access-dou-name"
											class="card-title dynamic-text-color"></h5>
									</div>

									<!-- DoU Access -->
									<div class="form-group row">
										<label for="edit-access-to-search"
											class="ml-3 col-form-label col-form-label-sm"><b>Access
												to</b></label>
										<div class="col-sm-6">
											<input data-toggle="dropdown" aria-haspopup="true"
												aria-expanded="false" type="text"
												class="form-control form-control-sm"
												id="edit-access-to-search" name="dou_access_to_search"
												placeholder="Enter EmailId" onkeyup="liveSearchTimer(this)">
											<input type="hidden" class="form-control form-control-sm"
												id="dou-access-to" name="access_to"
												placeholder="Enter EmailId" value=""> <a
												style="display: none" id="dropdown-item"
												class='dropdown-item' onclick="addAccessToVal(this)"></a>
											<div id="dou-access-to-search-result" class="dropdown-menu"
												aria-labelledby="dou-access-to-search" tabindex="0">
												<a class='dropdown-item'>Enter email Id to search</a>
											</div>
										</div>
									</div>

									<!-- DoU Access list -->
									<div id="access-to-email-badges" class="ml-3 form-group row">
									</div>
									<p class="ml-3" id="access-submit-instruction"></p>

									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal">Close</button>
										<button id="edit-access-button" type="submit"
											class="btn btn-primary">Save</button>
										<button id="edit-access-button-disabled"
											class="btn btn-primary d-none" type="button" disabled>
											<span class="spinner-grow spinner-grow-sm" role="status"
												aria-hidden="true"></span> Saving...
										</button>
									</div>
									<p class="card-text">
										<small class="modal-tip font-weight-bold font-italic">You
											can add or remove users access to this DoU. You can also
											change the roles of already present users. </small>
									</p>
								</form>
							</div>

						</div>
					</div>
				</div>

				<!-- Delegate Access modal -->
				<div class="modal fade" id="delegate-access-modal" tabindex="-1"
					role="dialog" aria-labelledby="delegate-access-form-modal"
					aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="dou-upload-form">Delegate
									Access</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<form method="POST" id="delegate-access-form" action="#">
									<!-- DoU Name -->
									<div class="ml-2 form-group row">
										<h5 id="delegate-access-dou-name"
											class="card-title dynamic-text-color"></h5>
									</div>

									<!-- DoU Access -->
									<div class="form-group row">
										<label for="delegate-user-access-to-search"
											class="ml-3 col-form-label col-form-label-sm"><b>Access
												to</b></label>
										<div class="col-sm-6">
											<input data-toggle="dropdown" aria-haspopup="true"
												aria-expanded="false" type="text"
												class="form-control form-control-sm"
												id="delegate-user-access-to-search"
												name="dou_access_to_search" placeholder="Enter EmailId"
												onkeyup="liveSearchTimer(this)"> <input
												type="hidden" class="form-control form-control-sm"
												id="dou-access-to" name="access_to"
												placeholder="Enter EmailId" value=""> <a
												style="display: none" id="dropdown-item"
												class='dropdown-item' onclick="addDelegateAccessToVal(this)"></a>
											<div id="dou-access-to-search-result" class="dropdown-menu"
												aria-labelledby="dou-access-to-search" tabindex="0">
												<a class='dropdown-item'>Enter email Id to search</a>
											</div>
										</div>
									</div>

									<!-- DoU Access list -->
									<div id="delegate-access-to-email-badges"
										class="ml-3 form-group row"></div>
									<p class="ml-3" id="delegate-access-submit-instruction"></p>

									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal">Close</button>
										<button id="delegate-button" type="submit"
											class="btn btn-primary">Save</button>
										<button id="delegate-button-disabled"
											class="btn btn-primary d-none" type="button" disabled>
											<span class="spinner-grow spinner-grow-sm" role="status"
												aria-hidden="true"></span> Delegating...
										</button>
									</div>
									<p class="card-text">
										<small class="modal-tip font-weight-bold font-italic">Delegate
											your DoU access to another user. You cannot delegate to a
											user who already have access to this DoU. </small>
									</p>
								</form>
							</div>

						</div>
					</div>
				</div>


				<!-- Add Reviewer modal -->
				<div class="modal fade" id="add-reviewer-modal" tabindex="-1"
					role="dialog" aria-labelledby="add-reviewer-form-modal"
					aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="dou-upload-form">Add Product
									DoU Reviewer</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<form method="POST" id="add-reviewer-form" action="#">
									<!-- DoU Name -->
									<div class="ml-2 form-group row">
										<h5 id="add-reviewer-dou-name"
											class="card-title dynamic-text-color"></h5>
									</div>

									<!-- DoU Access -->
									<div class="form-group row">
										<label for="add-reviewer-access-to-search"
											class="ml-3 col-form-label col-form-label-sm"><b>Access
												to</b></label>
										<div class="col-sm-6">
											<input data-toggle="dropdown" aria-haspopup="true"
												aria-expanded="false" type="text"
												class="form-control form-control-sm"
												id="add-reviewer-access-to-search"
												name="dou_access_to_search" placeholder="Enter EmailId"
												onkeyup="liveSearchTimer(this)"> <input
												type="hidden" class="form-control form-control-sm"
												id="dou-access-to" name="access_to"
												placeholder="Enter EmailId" value=""> <a
												style="display: none" id="dropdown-item"
												class='dropdown-item' onclick="addAddReviewerToVal(this)"></a>
											<div id="dou-access-to-search-result" class="dropdown-menu"
												aria-labelledby="dou-access-to-search" tabindex="0">
												<a class='dropdown-item'>Enter email Id to search</a>
											</div>
										</div>
									</div>

									<!-- DoU Access list -->
									<div id="add-reviewer-to-email-badges"
										class="ml-3 form-group row"></div>
									<p class="ml-3" id="add-reviewer-submit-instruction"></p>

									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal">Close</button>
										<button id="add-reviewer-button" type="submit"
											class="btn btn-primary">Save</button>
										<button id="add-reviewer-button-disabled"
											class="btn btn-primary d-none" type="button" disabled>
											<span class="spinner-grow spinner-grow-sm" role="status"
												aria-hidden="true"></span> Adding Reviewer...
										</button>
									</div>
									<p class="card-text">
										<small class="modal-tip font-weight-bold font-italic">Product
											team DoU owners can give access to a user as product team DoU
											reviewer here. </small>
									</p>
								</form>
							</div>
						</div>
					</div>
				</div>



				<!-- Edit DoU file modal -->
				<div class="modal fade" id="update-doufile-modal" tabindex="-1"
					role="dialog" aria-labelledby="update-doufile-form-modal"
					aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 id="update-doufile-modal-title" class="modal-title">Update
									DoU</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<form method="POST" id="update-doufile-dou-form" action="#">
									<!-- DoU Name -->
									<div class="ml-2 form-group row">
										<h5 id="update-doufile-dou-name"
											class="card-title dynamic-text-color"></h5>
									</div>


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
									<textarea id="update-doufile-comment"
										class="form-control shadow" name="comment"
										placeholder="Write a comment(Optional)..." cols=3></textarea>

									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal">Close</button>
										<button id="update-doufile-submit-button" type="submit"
											class="btn btn-primary">Update</button>
										<button id="update-doufile-submit-button-disabled"
											class="btn btn-primary d-none" type="button" disabled>
											<span class="spinner-grow spinner-grow-sm" role="status"
												aria-hidden="true"></span> Updating...
										</button>
									</div>
									<p class="card-text">
										<small class="modal-tip font-weight-bold font-italic">You
											can upload latest DoU here. </small>
									</p>
								</form>
							</div>

						</div>
					</div>
				</div>


				<!-- Review & Resend DoU file modal -->
				<div class="modal fade" id="review-resend-doufile-modal"
					tabindex="-1" role="dialog"
					aria-labelledby="review-resend-doufile-form-modal"
					aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 id="review-resend-doufile-modal-title" class="modal-title">Review
									& Resend DoU File</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<form method="POST" id="review-resend-doufile-dou-form"
									action="#">
									<!-- DoU Name -->
									<div class="ml-2 form-group row">
										<h5 id="review-resend-doufile-dou-name"
											class="card-title dynamic-text-color"></h5>
									</div>


									<!-- DoU File -->
									<div class="custom-file input-group input-group-sm mb-3">
										<input type="file"
											class="custom-file-input form-control form-control-sm dou-file-input"
											id="review-resend-dou-file" name="DoU" required> <label
											style="overflow: hidden;" class="custom-file-label"
											for="review-resend-dou-file" data-toggle="tooltip"
											data-placement="bottom"
											data-original-title="No File Selected">Choose DoU</label>
									</div>
									<!-- Comments -->
									<textarea id="review-resend-comment"
										class="form-control shadow" name="comment"
										placeholder="Write a comment(Optional)..." cols=3></textarea>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal">Close</button>
										<button id="review-resend-doufile-submit-button" type="submit"
											class="btn btn-primary">Resend DoU</button>
										<button id="review-resend-doufile-submit-button-disabled"
											class="btn btn-primary d-none" type="button" disabled>
											<span class="spinner-grow spinner-grow-sm" role="status"
												aria-hidden="true"></span> Resending...
										</button>
									</div>
									<p class="card-text">
										<small class="modal-tip font-weight-bold font-italic">After
											reviewing and updating the DoU, you can send the updated DoU
											back to approvers with pending approval.</small>
									</p>
								</form>
							</div>

						</div>
					</div>
				</div>


				<!-- Re-Initiate DoU modal -->
				<div class="modal fade" id="reinitiate-dou-modal" tabindex="-1"
					role="dialog" aria-labelledby="reinitiate-dou-form-modal"
					aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 id="reinitiate-dou-modal-title" class="modal-title">Re-Initiate
									DoU</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<form method="POST" enctype='multipart/form-data'
									id="reinitiate-dou-form" action="#">
									<!-- DoU Name -->
									<div class="ml-2 form-group row">
										<h5 id="reinitiate-dou-name"
											class="card-title dynamic-text-color"></h5>
									</div>

									<!-- DoU File -->
									<div class="custom-file input-group input-group-sm mb-3">
										<input type="file"
											class="custom-file-input form-control form-control-sm dou-file-input"
											id="reinitiate-dou-file" name="DoU" required> <label
											style="overflow: hidden;" class="custom-file-label"
											for="reinitiate-dou-file" data-toggle="tooltip"
											data-placement="bottom"
											data-original-title="No File Selected">Choose DoU</label>
									</div>

									<!-- Comments -->
									<textarea id="reinitiate-dou-comment"
										class="form-control shadow" name="comment"
										placeholder="Write a comment(Optional)..." cols=3></textarea>

									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal">Close</button>
										<button id="reinitiate-dou-button" type="submit"
											class="btn btn-primary">Re-Initiate DoU</button>
										<button id="reinitiate-dou-button-disabled"
											class="btn btn-primary d-none" type="button" disabled>
											<span class="spinner-grow spinner-grow-sm" role="status"
												aria-hidden="true"></span> Re-Initiating...
										</button>
									</div>
									<p class="card-text">
										<small class="modal-tip font-weight-bold font-italic">Re-Initiate
											the DoU approval cycle.</small>
									</p>
								</form>
							</div>

						</div>
					</div>
				</div>



				<!-- Cancel DoU modal -->
				<div class="modal fade" id="cancel-dou-modal" tabindex="-1"
					role="dialog" aria-labelledby="cancel-dou-form-modal"
					aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 id="cancel-dou-modal-title"
									class="modal-title text-danger font-weight-bold">Cancel
									DoU</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<div class="ml-2 form-group row">
									<h5 class="card-title">Are you sure you want to
										CANCEL&nbsp;</h5>
									<h5 id="cancel-dou-name" class="card-title dynamic-text-color"></h5>
									<h5 class="card-title">?</h5>
								</div>
								<!-- Comments -->
								<textarea id="cancel-dou-comment" class="form-control shadow"
									name="comment" placeholder="Write a comment(Optional)..."
									cols=3></textarea>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-dismiss="modal">Close</button>
									<button id="cancel-dou-button" type="button"
										class="btn btn-danger" onclick="cancelDoU()">CANCEL
										DoU</button>
									<button id="cancel-dou-button-disabled"
										class="btn btn-danger d-none" type="button" disabled>
										<span class="spinner-grow spinner-grow-sm" role="status"
											aria-hidden="true"></span> Canceling...
									</button>
								</div>
							</div>

						</div>
					</div>
				</div>


				<!-- UserStatusApproval DoU modal -->
				<div class="modal fade" id="user-status-approval-dou-modal"
					tabindex="-1" role="dialog"
					aria-labelledby="user-status-approval-dou-form-modal"
					aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 id="user-status-approval-dou-modal-title"
									class="modal-title font-bold text-capitalize"></h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<div class="ml-2 form-group row">
									<h5 class="card-title">Are you sure you want to</h5>
									<h5 id="user-status-approval-status"
										class="card-title text-uppercase font-weight-bold"></h5>
									<h5 id="user-status-approval-dou-name"
										class="card-title dynamic-text-color"></h5>
									<h5 class="card-title">?</h5>
								</div>
								<!-- Comments -->
								<textarea id="user-status-approval-comment"
									class="form-control shadow" name="comment"
									placeholder="Write a comment(Optional)..." cols=3></textarea>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-dismiss="modal">Close</button>
									<button id="user-status-approval-status-change-button"
										type="button" class="btn" onclick="setApprovalBtn(this)"
										value=""></button>
									<button id="user-status-approval-status-change-button-disabled"
										class="btn btn-secondary d-none text-capitalize" type="button"
										disabled>
										<span class="spinner-grow spinner-grow-sm" role="status"
											aria-hidden="true"></span> <b
											id="user-status-approval-status-change-button-disabled-value">Saving...</b>
									</button>
								</div>
								<p class="card-text">
									<small class="modal-tip font-weight-bold font-italic"></small>
								</p>
							</div>

						</div>
					</div>
				</div>


				<!-- Delete attachment modal -->
				<div class="modal fade" id="delete-attachment-modal" tabindex="-1"
					role="dialog" aria-labelledby="delete-attachment-form-modal"
					aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 id="delete-attachment-modal-title"
									class="modal-title text-danger font-weight-bold">Delete
									Attachment</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<h4 id="delete-attachment-dou-name"
									class="card-title dynamic-text-color"></h4>
								<div class="ml-2 form-group row">
									<h5 class="card-title text-dark">Are you sure you want to
										delete&nbsp;</h5>
									<h5 id="delete-attachment-name" class="card-title text-dark"></h5>
									<h5 class="card-title text-dark">?</h5>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-dismiss="modal">Close</button>
									<button id="delete-attachment-button" type="button"
										class="btn btn-danger" onclick="deleteAttachment(this)"
										attachment-name="">DELETE</button>
									<button id="delete-attachment-button-disabled"
										class="btn btn-danger d-none" type="button" disabled>
										<span class="spinner-grow spinner-grow-sm" role="status"
											aria-hidden="true"></span> Deleting...
									</button>
								</div>
								<p class="card-text">
									<small class="modal-tip font-weight-bold font-italic">Delete
										this attachment and it's no longer available.</small>
								</p>
							</div>

						</div>
					</div>
				</div>



			</div>
		</div>
	</div>
	<!-- /.container-fluid -->

	<%@ include file="Footer.jsp"%>

	<!-- Page level plugins -- ViewDoUs.jsp-->
	<script src="vendor/blockUI/blockUI.js"></script>
	<script src="vendor/datatables/jquery.dataTables.min.js"></script>
	<script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.15.1/moment.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-range/4.0.2/moment-range.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
	<!-- 	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script> -->

	<!-- Page level custom scripts -- ViewDoUs.jsp-->
	<script src="js/CommonUtils.js"></script>
	<script src="js/DoUDetails.js"></script>
	<script src="js/Form.js"></script>
	<script src="js/RevisionHistoryUtils.js"></script>

</body>

</html>
