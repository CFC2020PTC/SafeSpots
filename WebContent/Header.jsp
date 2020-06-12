<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

<%
	boolean isPTCMember = false;
%>

<style>
	.selectBoxClass {
		padding-top: 0.5rem;
		padding-bottom: .5rem;
		padding-left: 1rem;
		font-size: 1.25rem;
		margin: -1px 0px -1px 0;
	}
</style>

<script src="js/Header.js"></script>
<script type="text/javascript" src="js/Date.js"></script>

<script type="text/javascript">
function cityChanged(e) {
	
	console.log("hi",e.target.value);

	switch(e.target.value) {
	
	case "Bangalore":
		$(".smcount")[0].innerHTML=27;
		$(".hcount")[0].innerHTML=20;
		$(".pcount")[0].innerHTML=32;
		$(".rcount")[0].innerHTML=16;
		$(".gcount")[0].innerHTML=32;
		break;
	case "Pune":
		$(".smcount")[0].innerHTML=32;
		$(".hcount")[0].innerHTML=43;
		$(".pcount")[0].innerHTML=53;
		$(".rcount")[0].innerHTML=23;
		$(".gcount")[0].innerHTML=25;
		break;
	case "Hyderabad":
		$(".smcount")[0].innerHTML=24;
		$(".hcount")[0].innerHTML=26;
		$(".pcount")[0].innerHTML=37;
		$(".rcount")[0].innerHTML=28;
		$(".gcount")[0].innerHTML=19;
		break;
	case "Delhi":
		$(".smcount")[0].innerHTML=27;
		$(".hcount")[0].innerHTML=25;
		$(".pcount")[0].innerHTML=31;
		$(".rcount")[0].innerHTML=37;
		$(".gcount")[0].innerHTML=34;
		break;
	case "Kolkata":
		$(".smcount")[0].innerHTML=26;
		$(".hcount")[0].innerHTML=35;
		$(".pcount")[0].innerHTML=41;
		$(".rcount")[0].innerHTML=26;
		$(".gcount")[0].innerHTML=41;
		break;
	}
}


</script>

<!-- DoM templates start -->

<!-- user wrapper template start-->
<div style="display: none;">
	<span id="template-user-wrapper"
		class="user-wrapper card border-dark shadow mb-1 p-1">
		<div class="font-weight-bold border-dark input-group p-0">
			<div id="remove">
				<h6 class="text-danger">
					<i class="fa fa-times-circle" aria-hidden="true"
						onclick="removeAccessToEmail(this)"></i>
				</h6>
			</div>
			<div style="max-width: 100%; word-break: break-all" id="email"
				class="rounded-left border text-dark border-0 font-weight-bold ml-2"></div>
			<div class="input-group-append">
				<div style="max-width: 100%; word-break: break-all" id="role"
					class="border border-0 text-success text-uppercase font-weight-bold ml-2 mr-1"
					selectedRole="">Role</div>
				<button type="button"
					class="btn btn-outline-dark dropdown-toggle dropdown-toggle-split"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				</button>
				<div class="dropdown-menu all-roles">
					<a id="template-user-role"
						class="dropdown-item text-uppercase font-weight-bold text-success"
						onclick="setUserRole(this)" dropdownVal="">Role</a>
				</div>
			</div>
		</div>
	</span>
</div>
<!-- user wrapper template end-->

<!-- approval date template initiator view start -->
<div style="display: none;">
	<div id="user-approval-date-wrapper-template-initiator-view"
		class='input-group mt-4 justify-content-end font-italic small font-weight-bolder'>
		<div id="due-date-msg" class='px-2'>
			Due Date to take action : <b id='user-approval-due-date'></b>
		</div>
		<button tabindex="0" id="datepicker-popover-button" type="button"
			class="dou-tooltips btn btn-outline-dark" data-toggle="popover"
			title="Set due date for Approval"
			data-content="">
			<i class='far fa-calendar-alt'></i>
		</button>
	</div>
</div>
<!-- approval date template initiator view end -->


<!-- overdue date template initiator view start -->
<div style="display: none;">
	<div id="user-approval-overdue-date-wrapper-template-initiator-view"
		class='input-group mt-4 justify-content-end text-danger font-italic small font-weight-bolder'>
		<div id="due-date-msg" class='px-2 text-danger'>Overdue to take
			action: <b id='user-approval-due-date'></b></div>
		<button tabindex="0" id="datepicker-popover-button" type="button"
			class="dou-tooltips btn btn-outline-dark" data-toggle="popover"
			title="Set due date for Approval"
			data-content="">
			<i class='far fa-calendar-alt'></i>
		</button>
	</div>
</div>
<!-- overdue date template initiator view end -->

<!-- approval date template approver view start -->
<div style="display: none;">
	<div id="user-approval-date-wrapper-template-approver-view"
		class='input-group date mt-4 justify-content-end font-italic small font-weight-bolder'>
		<div id="due-date-msg" class='px-2'>
			Take action by <b id='user-approval-due-date'></b>
		</div>
	</div>
</div>
<!-- approval date template approver view end -->


<!-- overdue date template approver view start -->
<div style="display: none;">
	<div id="user-approval-overdue-date-wrapper-template-approver-view"
		class='input-group date mt-4 justify-content-end text-danger font-italic small font-weight-bolder'>
		<div id="due-date-msg" class='px-2'>Overdue to take action : <b id='user-approval-due-date'></b></div>
	</div>
</div>
<!-- overdue date template approver view end -->

<!-- approval date template third person view start -->
<div style="display: none;">
	<div id="user-approval-date-wrapper-template-third-person-view"
		class='input-group date mt-4 justify-content-end font-italic small font-weight-bolder'>
		<div id="due-date-msg" class='px-2'>
			Due Date to take action : <b id='user-approval-due-date'></b>
		</div>
	</div>
</div>
<!-- approval date template third person view end -->


<!-- overdue date template third person view start -->
<div style="display: none;">
	<div id="user-approval-overdue-date-wrapper-template-third-person-view"
		class='input-group date mt-4 justify-content-end text-danger font-italic small font-weight-bolder'>
		<div id="due-date-msg" class='px-2'>Overdue to take action : <b id='user-approval-due-date'></b></div>
	</div>
</div>
<!-- overdue date template third person view end -->


<!-- DoUUserApprovalStatus indicator start -->
<div style="display: none;">
	<p id="user-approval-status-approved-template"
		class="user-approval-status-approved float-right text-success font-weight-bold mb-0">
		Approved <i id="user-approval-status-approved-icon"
			class="far fa-check-circle text-success"></i>
	</p>
	<p id="user-approval-status-pending-template"
		class="user-approval-status-pending float-right text-warning font-weight-bold">
		Pending with <i id="user-approval-status-pending-icon"
			class="fas fa-hourglass-half text-warning"></i>
	</p>
	<p id="user-approval-status-rejected-template"
		class="user-approval-status-rejected float-right text-danger font-weight-bold mb-0">
		Rejected <i id="user-approval-status-rejected-icon"
			class="far fa-times-circle text-danger"></i>
	</p>
	<p id="user-approval-status-initiated-template"
		class="user-approval-status-initiated float-right text-primary font-weight-bold">
		Initiated <i id="user-approval-status-initiated-icon"
			class="fas fa-file-contract text-primary d-none"></i>
	</p>
	<p id="user-approval-status-nan-template"
		class="user-approval-status-nan float-right text-info font-weight-bold">
		No actions needed <i id="user-approval-status-nan-icon"
			class="far text-info d-none">NA</i>
	</p>
</div>

<!-- DoUUserApprovalStatus indicator end -->

<!-- DoUUserApprovalTime element start -->
<small id="approval-time" class="text-dark font-italic font-weight-bold"
	title="Approval Time"></small>
<!-- DoUUserApprovalTime element end -->


<!-- DoUUserApprovalStatus buttons start -->
<div style="display: none;">
	<div id="status-change-btns-template">
		<button class="btn btn-danger dou-tooltips"
			onclick="setUserApprovalStatusModal(this)" data-toggle="modal"
			data-placement="top" title="Reject the DoU"
			data-target="#user-status-approval-dou-modal" value="rejected"
			dou-status="reject">Reject</button>
		<button class="btn btn-success dou-tooltips"
			onclick="setUserApprovalStatusModal(this)" data-toggle="modal"
			data-placement="top" title="Approve the DoU"
			data-target="#user-status-approval-dou-modal" value="approved"
			dou-status="approve">Approve</button>
	</div>
</div>
<!-- DoUUserApprovalStatus buttons end -->

<!-- Review&Resend button start -->
<div style="display: none;">
	<div id="review-resend-btn-template">
		<button id="review-resend-btn" type="button"
			class="btn btn-dark dou-tooltips" data-toggle="modal"
			data-target="#review-resend-doufile-modal" data-placement="top"
			title="Resend the DoU after reviewing it offline"
			onclick="populateDoUFileFormReviewResend()">Review & Resend</button>
	</div>
</div>

<!-- Review&Resend button end -->

<!-- Revision History Card start -->

<div style="display: none">
	<div id="revision-history-event-template"
		class="revision-history tracking-item w-75">
		<div id="event-icon"
			class="tracking-icon d-flex align-items-center justify-content-center border border-dark"
			style="background-color: green"></div>
		<div class="tracking-date">
			<p id="date" class="text-dark mb-0"></p>
			<span id="time"></span>
		</div>
		<div id="revision-history-body-wrapper"
			class="tracking-content card text-dark"
			style="border-width: 0 0 0 4px; border-color: green; border-bottom-right-radius: 0px; border-top-right-radius: 0px;">
			<div id="revision-history-body"
				class="card-body border border-0 text-dark pt-1"></div>
		</div>
	</div>
	<div id="revision-history-comment-template"
		class="comment tracking-item w-75">
		<div id="event-icon"
			class="tracking-icon bg-primary d-flex align-items-center justify-content-center border border-dark">
			<i class="far fa-comment-alt"></i>
		</div>
		<div class="tracking-date">
			<p id="date" class="text-dark mb-0">Jul 20, 2018</p>
			<span id="time">08:58 AM</span>
		</div>
		<div class="card border border-primary tracking-content">
			<div class="card-header rounded-top font-weight-bold text-dark py-1">
				Comment by
				<p id="comment-author" class="d-inline text-primary">@sumanthk0708</p>
			</div>
			<div id="comment-body" class="card-body text-dark pt-2">
				Shipment is out for despatch by KLHB023.</div>
		</div>
	</div>
</div>

<!-- Revision History Card end -->

<!-- DoM templates end -->

<!-- Page Wrapper -->
<div id="wrapper">

	<!-- Sidebar -->
	<ul
		class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
		id="accordionSidebar">

		<!-- Sidebar - Brand -->
		<a
			class="sidebar-brand d-flex align-items-center justify-content-center"
			href="/">
			<div class="sidebar-brand-icon">
				<!-- rotate-n-15 class to rotate glyphicons -->
				<i class="fas fa-street-view"></i>
			</div>
			<div class="sidebar-brand-text small my-3" style="font-weight: bold;font-size: 18px;">
				SAFER SPOT LOCATOR
			</div>
		</a>

		<!-- Divider -->
		<hr class="sidebar-divider my-0">

		<!-- Nav Item - Dashboard -->
		<li id="dashboard-nav-item" class="nav-item"><a class="nav-link"
			href="/"> <i class="fas fa-fw fa-tachometer-alt"></i> <span>Search</span></a></li>
		<!-- Nav Item - To view MyActivities -->
		<!-- <li id="action-required-nav-item" class="nav-item"><a
			class="nav-link" href="ActionRequired.jsp"> <i
				class="fas fa-tasks"></i> <span>Navigate</span>
		</a></li> -->
		<!-- Nav Item - To view DoUs 
		<li id="all-dous-nav-item" class="nav-item"><a class="nav-link"
			href="ViewDoUs.jsp"> <i class="fas fa-fw fa-file"></i> <span>All
					DoUs</span>
		</a></li> -->


		<!-- Sidebar Toggler (Sidebar) -->
		<div class="text-center d-none d-md-inline">
			<button class="rounded-circle border-0" id="sidebarToggle"></button>
		</div>

	</ul>
	<!-- End of Sidebar -->

	<!-- Content Wrapper -->
	<div id="content-wrapper" class="d-flex flex-column">

		<!-- Main Content -->
		<div id="content">

			<!-- Topbar -->
			<nav
				class="navbar navbar-expand navbar-light topbar mb-4 static-top shadow" style="background-color: #36486b  !important;padding-left: 100px;">

			<!-- Sidebar Toggle (Topbar) -->
			<button id="sidebarToggleTop"
				class="btn btn-link d-md-none rounded-circle mr-3">
				<i class="fa fa-bars"></i>
			</button>

			<!-- Topbar Search --> 
			 <form
				class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
				<div class="input-group">

				<select class="selectBoxClass" onChange="cityChanged(event);">
				<option>Bangalore</option>
				<option>Pune</option>
				<option>Delhi</option>
				<option>Hyderabad</option>
				<option>Kolkata</option>
				</select>
				
				
					<input type="text" class="form-control bg-light border-0 small"
						placeholder="Search for safer locations" aria-label="Search"
						aria-describedby="basic-addon2" style="height: 50px;font-size: 20px;">
					<div class="input-group-append">
						<button class="btn btn-primary" type="button" onclick="getRelevantGroups()"> 
							<i class="fas fa-search fa-sm"></i>
						</button>
					</div>
				</div>
			</form>  <!-- Topbar Navbar -->
			<ul class="navbar-nav ml-auto">


				<div class="topbar-divider d-none d-sm-block"></div>

				<!-- Nav Item - User Information -->
				<li class="nav-item dropdown no-arrow"><a
					class="nav-link dropdown-toggle" href="#" id="userDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <span id="username"
						class="mr-2 d-lg-inline text-light font-weight-bold font-italic text-capitalize small">
							Sumanth
					</span> <img id="userimg"
						class="border border-dark img-profile rounded-circle"
						src="img/default-user-profile-pic.png">
				</a> <!-- Dropdown - User Information -->
					<div
						class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
						aria-labelledby="userDropdown">
						<!-- <a class="dropdown-item" href="#"> <i
							class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> Profile
						</a> <a class="dropdown-item" href="#"> <i
							class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i> Settings
						</a> <a class="dropdown-item" href="#"> <i
							class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i> Activity
							Log
						</a>
						<div class="dropdown-divider"></div> -->
						<a class="dropdown-item" href="/logout"> <i
							class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
							Logout
						</a>
					</div></li>

			</ul>

			</nav>
			<!-- End of Topbar -->

			<!-- Alert Templates Start -->
			<div id="alert-container"
				style="margin: -4% 2%; width: 77%; position: fixed; opacity: 95%; z-index: 999;">
				<!-- Success alert -->
				<div id="success-alert-template"
					class="alert alert-success font-weight-bold" role="alert"
					style="display: none; margin-bottom: 1%;"></div>

				<!-- Failure alert -->
				<div id="failure-alert-template"
					class="alert alert-danger font-weight-bold" role="alert"
					style="display: none; margin-bottom: 1%;"></div>

				<!-- Warning alert -->
				<div id="warning-alert-template"
					class="alert alert-warning font-weight-bold" role="alert"
					style="display: none; margin-bottom: 1%;"></div>
			</div>
			<!-- Alert Templates End -->
			<script type="text/javascript">
				// Hidden Codes
				/* 		
				Side Bars
				<!-- Divider -->
				<hr class="sidebar-divider">

				<!-- Heading -->
				<div class="sidebar-heading">Interface</div>

				<!-- Nav Item - Pages Collapse Menu -->
				<li class="nav-item"><a class="nav-link collapsed" href="#"
			data-toggle="collapse" data-target="#collapseTwo1"
			aria-expanded="true" aria-controls="collapseTwo"> <i
				class="fas fa-fw fa-spin fa-cog"></i> <span>Components</span>
				</a>
				<div id="collapseTwo1" class="collapse" aria-labelledby="headingTwo"
				data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">Custom Components:</h6>
						<a class="collapse-item" href="buttons.html">Buttons</a> <a
						class="collapse-item" href="cards.html">Cards</a>
					</div>
				</div></li>

				<!-- Nav Item - Utilities Collapse Menu -->
				<li class="nav-item"><a class="nav-link collapsed" href="#"
			data-toggle="collapse" data-target="#collapseUtilities"
			aria-expanded="true" aria-controls="collapseUtilities"> <i
				class="fas fa-fw fa-wrench"></i> <span>Utilities</span>
				</a>
				<div id="collapseUtilities" class="collapse"
				aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">Custom Utilities:</h6>
						<a class="collapse-item" href="utilities-color.html">Colors</a> <a
						class="collapse-item" href="utilities-border.html">Borders</a> <a
						class="collapse-item" href="utilities-animation.html">Animations</a>
						<a class="collapse-item" href="utilities-other.html">Other</a>
					</div>
				</div></li>

				<!-- Divider -->
				<hr class="sidebar-divider">

				<!-- Heading -->
				<div class="sidebar-heading">Addons</div>

				<!-- Nav Item - Pages Collapse Menu -->
				<li class="nav-item"><a class="nav-link collapsed" href="#"
			data-toggle="collapse" data-target="#collapsePages"
			aria-expanded="true" aria-controls="collapsePages"> <i
				class="fas fa-fw fa-folder"></i> <span>Pages</span>
				</a>
				<div id="collapsePages" class="collapse"
				aria-labelledby="headingPages" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">Login Screens:</h6>
						<a class="collapse-item" href="login.html">Login</a> <a
						class="collapse-item" href="register.html">Register</a> <a
						class="collapse-item" href="forgot-password.html">Forgot
							Password</a>
						<div class="collapse-divider"></div>
						<h6 class="collapse-header">Other Pages:</h6>
						<a class="collapse-item" href="404.html">404 Page</a> <a
						class="collapse-item" href="blank.html">Blank Page</a>
					</div>
				</div></li>

				<!-- Nav Item - Charts -->
				<li class="nav-item"><a class="nav-link" href="charts.html">
					<i class="fas fa-fw fa-chart-area"></i> <span>Charts</span>
				</a></li>

				<!-- Nav Item - Tables -->
				<li class="nav-item"><a class="nav-link" href="tables.html">
					<i class="fas fa-fw fa-table"></i> <span>Tables</span>
				</a></li>

				<!-- Divider -->
				<hr class="sidebar-divider d-none d-md-block"> 
				
				
				
				
				Alerts
				<!-- Nav Item - Alerts -->
				<li class="nav-item dropdown no-arrow mx-1"><a
			class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
			role="button" data-toggle="dropdown" aria-haspopup="true"
			aria-expanded="false"> <i class="fas fa-bell fa-fw"></i> <!-- Counter - Alerts -->
					<span class="badge badge-danger badge-counter">3+</span>
				</a> <!-- Dropdown - Alerts -->
				<div
				class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
				aria-labelledby="alertsDropdown">
					<h6 class="dropdown-header">Alerts Center</h6>
					<a class="dropdown-item d-flex align-items-center" href="#">
						<div class="mr-3">
							<div class="icon-circle bg-primary">
								<i class="fas fa-file-alt text-white"></i>
							</div>
						</div>
						<div>
							<div class="small text-gray-500">December 12, 2019</div>
							<span class="font-weight-bold">A new monthly report is
								ready to download!</span>
						</div>
					</a> <a class="dropdown-item d-flex align-items-center" href="#">
						<div class="mr-3">
							<div class="icon-circle bg-success">
								<i class="fas fa-donate text-white"></i>
							</div>
						</div>
						<div>
							<div class="small text-gray-500">December 7, 2019</div>
							$290.29 has been deposited into your account!
						</div>
					</a> <a class="dropdown-item d-flex align-items-center" href="#">
						<div class="mr-3">
							<div class="icon-circle bg-warning">
								<i class="fas fa-exclamation-triangle text-white"></i>
							</div>
						</div>
						<div>
							<div class="small text-gray-500">December 2, 2019</div>
							Spending Alert: We've noticed unusually high spending for your
							account.
						</div>
					</a> <a class="dropdown-item text-center small text-gray-500" href="#">Show
						All Alerts</a>
				</div></li>

				
				Messages
				<!-- Nav Item - Messages -->
				<li class="nav-item dropdown no-arrow mx-1"><a
			class="nav-link dropdown-toggle" href="#" id="messagesDropdown"
			role="button" data-toggle="dropdown" aria-haspopup="true"
			aria-expanded="false"> <i class="fas fa-envelope fa-fw"></i> <!-- Counter - Messages -->
					<span class="badge badge-danger badge-counter">7</span>
				</a> <!-- Dropdown - Messages -->
				<div
				class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
				aria-labelledby="messagesDropdown">
					<h6 class="dropdown-header">Message Center</h6>
					<a class="dropdown-item d-flex align-items-center" href="#">
						<div class="dropdown-list-image mr-3">
							<img class="rounded-circle"
							src="https://source.unsplash.com/fn_BT9fwg_E/60x60" alt="">
							<div class="status-indicator bg-success"></div>
						</div>
						<div class="font-weight-bold">
							<div class="text-truncate">Hi there! I am wondering if you
								can help me with a problem I've been having.</div>
							<div class="small text-gray-500">Emily Fowler · 58m</div>
						</div>
					</a> <a class="dropdown-item d-flex align-items-center" href="#">
						<div class="dropdown-list-image mr-3">
							<img class="rounded-circle"
							src="https://source.unsplash.com/AU4VPcFN4LE/60x60" alt="">
							<div class="status-indicator"></div>
						</div>
						<div>
							<div class="text-truncate">I have the photos that you
								ordered last month, how would you like them sent to you?</div>
							<div class="small text-gray-500">Jae Chun · 1d</div>
						</div>
					</a> <a class="dropdown-item d-flex align-items-center" href="#">
						<div class="dropdown-list-image mr-3">
							<img class="rounded-circle"
							src="https://source.unsplash.com/CS2uCrpNzJY/60x60" alt="">
							<div class="status-indicator bg-warning"></div>
						</div>
						<div>
							<div class="text-truncate">Last month's report looks
								great, I am very happy with the progress so far, keep up the
								good work!</div>
							<div class="small text-gray-500">Morgan Alvarez · 2d</div>
						</div>
					</a> <a class="dropdown-item d-flex align-items-center" href="#">
						<div class="dropdown-list-image mr-3">
							<img class="rounded-circle"
							src="https://source.unsplash.com/Mv9hjnEUHR4/60x60" alt="">
							<div class="status-indicator bg-success"></div>
						</div>
						<div>
							<div class="text-truncate">Am I a good boy? The reason I
								ask is because someone told me that people say this to all
								dogs, even if they aren't good...</div>
							<div class="small text-gray-500">Chicken the Dog · 2w</div>
						</div>
					</a> <a class="dropdown-item text-center small text-gray-500" href="#">Read
						More Messages</a>
				</div></li>
				
				
				
				<!-- Nav Item - Search Dropdown (Visible Only XS) -->
				<li class="nav-item dropdown no-arrow d-sm-none"><a
				class="nav-link dropdown-toggle" href="#" id="searchDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
				</a> <!-- Dropdown - Messages -->
					<div
					class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
					aria-labelledby="searchDropdown">
						<form class="form-inline mr-auto w-100 navbar-search">
							<div class="input-group">
								<input type="text" class="form-control bg-light border-0 small"
								placeholder="Search for..." aria-label="Search"
								aria-describedby="basic-addon2">
								<div class="input-group-append">
									<button class="btn btn-primary" type="button">
										<i class="fas fa-search fa-sm"></i>
									</button>
								</div>
							</div>
						</form>
					</div></li>
					
				 */
			</script>