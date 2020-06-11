var tableHeaders = {
	"dou_name" : "Name",
	"dou_status" : "Status",
	"created_by" : "Owner",
	"last_modified_time" : "Last Modified On",
	"dou_file_version" : "DoU Revision"
}

var globalDoUGroups = {};
var allDataTable = "";
var ownDataTable = "";
var sharedDataTable = "";
var previousColor = "";
var currentColor = "";

$(document).ready(function() {
	activeNavItem();
	populateTables();
	
});

function onPageLoad() {
	populateTables();
	addDoUTableUtilities();
}

function filterStatusOnReady() {
	var statuses = window.location.href.trim().split("?");
	if (statuses.length > 1) {
		var statusQuery = statuses[1].split("=");
		if (statusQuery[0].toLowerCase() == "status") {
			if (statusQuery[1].length != 0) {
				filterStatusColumn(statusQuery[1]);
			}
		}
	}
}

function removeStatusFilter() {
	filterStatusColumn("");
}

function filterStatusColumn(status) {
	if ( allDataTable.column(2).search() !== status ) {
		allDataTable
            .column(2)
            .search( status )
            .draw();
    }
	
	if ( ownDataTable.column(2).search() !== status ) {
		ownDataTable
            .column(2)
            .search( status )
            .draw();
    }
	
	if ( sharedDataTable.column(2).search() !== status ) {
		sharedDataTable
            .column(2)
            .search( status )
            .draw();
    }
	
	if(status == "" || status == null ) {
		$(".remove-status-filter").removeClass("d-block");
		$(".remove-status-filter").addClass("d-none");
		//$(".remove-status-filter").attr("disabled", true);
	} else {
		$(".remove-status-filter").removeClass("d-none");
		$(".remove-status-filter").addClass("d-block");
		//$(".remove-status-filter").attr("disabled", false);
	}
	
}


function activeNavItem(obj) {
	$("#all-dous-nav-item").addClass("active");
}

function setTableHeaders() {
	// to set the header automatically
	var headerKeys = Object.keys(tableHeaders);
	var allDoUTable = document.getElementById("allDoUTable");
	var ownDoUTable = document.getElementById("ownDoUTable");
	var sharedDoUTable = document.getElementById("sharedDoUTable");

	var allDoURowHead = allDoUTable.createTHead().insertRow(0);
	var ownDoURowHead = ownDoUTable.createTHead().insertRow(0);
	var sharedDoURowHead = sharedDoUTable.createTHead().insertRow(0);

	var allDoURowFoot = allDoUTable.createTFoot().insertRow(0);
	var ownDoURowFoot = ownDoUTable.createTFoot().insertRow(0);
	var sharedDoURowFoot = sharedDoUTable.createTFoot().insertRow(0);

	for (var i = 0; i < headerKeys.length; i++) {
		var cell = document.createElement("TH");
		var t = document.createTextNode(tableHeaders[headerKeys[i]]);
		cell.appendChild(t);
		allDoURowHead.appendChild(cell);

		var cell = document.createElement("TH");
		var t = document.createTextNode(tableHeaders[headerKeys[i]]);
		cell.appendChild(t);
		ownDoURowHead.appendChild(cell);

		var cell = document.createElement("TH");
		var t = document.createTextNode(tableHeaders[headerKeys[i]]);
		cell.appendChild(t);
		sharedDoURowHead.appendChild(cell);

		var cell = document.createElement("TH");
		var t = document.createTextNode(tableHeaders[headerKeys[i]]);
		cell.appendChild(t);
		allDoURowFoot.appendChild(cell);

		var cell = document.createElement("TH");
		var t = document.createTextNode(tableHeaders[headerKeys[i]]);
		cell.appendChild(t);
		ownDoURowFoot.appendChild(cell);

		var cell = document.createElement("TH");
		var t = document.createTextNode(tableHeaders[headerKeys[i]]);
		cell.appendChild(t);
		sharedDoURowFoot.appendChild(cell);
	}
}

function generateDoURows(dous) {
	var dousArray = [];

	var keys = Object.keys(dous);
	for (var i = 0; i < keys.length; i++) {
		var dou = []

		var status = "";
		if (dous[i]["dou_status"] == "PENDING") {
			status = dous[i]["dou_status"] + " with "
					+ phases[dous[i]["dou_phase"]];
		} else {
			status = dous[i]["dou_status"];
		}

		dou.push(i + 1);
		dou.push(dous[i]["dou_name"]);
		dou.push(status);
		dou.push(dous[i]["created_by"]);
		dou.push(getCurrentTimeZoneTime(dous[i]["last_modified_time"]));
		dousArray.push(dou);
	}

	return dousArray;
}

function populateTables() {
	$
			.get(
					"/rest/dou/groups",
					function(data) {
						// console.log(data[0]);
						var j = 0;
						var k = 0;
						var allDoURow = document.createElement('tbody');
						var ownDoURow = document.createElement('tbody');
						var sharedDoURow = document.createElement('tbody');

						for (var i = 0; i < data.length; i++) {
							globalDoUGroups[data[i]["_id"]] = data[i];
							var row = allDoURow.insertRow(i);
							row.className = "text-"
									+ colorClass[data[i]["dou_status"]];
							row.className += " " + "clickable-row";
							row.setAttribute("data-href", "/DoUDetails.jsp?id="
									+ data[i]["_id"]);
							row.setAttribute("dou-id", data[i]["_id"]);
							var x_SlNo = row.insertCell(0);
							var x_douName = row.insertCell(1);
							var x_douStatus = row.insertCell(2);
							var x_initiator = row.insertCell(3);
							var x_lastModifiedTime = row.insertCell(4);
							// var x4 = row.insertCell(4);

							x_douName.innerHTML = data[i]["dou_name"];
							x_douStatus.innerHTML = data[i]["dou_status"];
//							if (data[i]["dou_status"] == "PENDING") {
//								x_douStatus.innerHTML = data[i]["dou_status"]
//										+ " with "
//										+ phases[data[i]["dou_phase"]];
//							} else {
//								x_douStatus.innerHTML = data[i]["dou_status"];
//							}

							x_initiator.innerHTML = data[i]["created_by"];
							x_lastModifiedTime.innerHTML = getCurrentTimeZoneTime(data[i]["last_modified_time"]);
							x_lastModifiedTime.setAttribute("data-sort",
									data[i]["last_modified_time"]);
							// x4.innerHTML = data[i]["dou_file_version"];
							
//							Set popover attr for statuscell
							x_douStatus.classList.add("status-popover");
							x_douStatus.setAttribute("title",data[i]["dou_name"]);
							x_douStatus.setAttribute("data-content",generateStatusPopoversContent(data[i]));
							x_douStatus.setAttribute("dou-id", data[i]["_id"]);

							if (data[i]["created_by"] == userName) {
								// Table for own
								var row_own = ownDoURow.insertRow(j);
								row_own.replaceWith(row.cloneNode(true));

								j++;
							} else {
								// Table for shared
								var row_shared = sharedDoURow.insertRow(k);
								row_shared.replaceWith(row.cloneNode(true));
								
								k++;
							}
						}
						document.getElementById("allDoUTable").appendChild(
								allDoURow);
						document.getElementById("ownDoUTable").appendChild(
								ownDoURow);
						document.getElementById("sharedDoUTable").appendChild(
								sharedDoURow);
						
						
						// console.log(100/Object.keys(tableHeaders).length);
//						$(".table td").css("max-width",
//								100 / Object.keys(tableHeaders).length);
//						$(".table th").css("max-width",
//								100 / Object.keys(tableHeaders).length);
						activateClickableRow();
						addDoUTableUtilities();
					});
}

function activateClickableRow() {
	$(".clickable-row").click(function() {
		window.location = $(this).data("href");
	});
}

function addDoUTableUtilities() {
	// Call the dataTables jQuery plugin
	allDataTable = $('#allDoUTable').DataTable({
		"columnDefs" : [ {
			"searchable" : false,
			"orderable" : false,
			"targets" : 0
		} ],
		"order" : [ [ 1, 'asc' ] ]
	});

	allDataTable.on('order.dt search.dt', function() {
		allDataTable.column(0, {
			search : 'applied',
			order : 'applied'
		}).nodes().each(function(cell, i) {
			cell.innerHTML = i + 1;
		});
	}).draw();
	ownDataTable = $('#ownDoUTable').DataTable({
		"columnDefs" : [ {
			"searchable" : false,
			"orderable" : false,
			"targets" : 0
		} ],
		"order" : [ [ 1, 'asc' ] ]
	});
	ownDataTable.on('order.dt search.dt', function() {
		ownDataTable.column(0, {
			search : 'applied',
			order : 'applied'
		}).nodes().each(function(cell, i) {
			cell.innerHTML = i + 1;
		});
	}).draw();

	sharedDataTable = $('#sharedDoUTable').DataTable({
		"columnDefs" : [ {
			"searchable" : false,
			"orderable" : false,
			"targets" : 0
		} ],
		"order" : [ [ 1, 'asc' ] ]
	});
	sharedDataTable.on('order.dt search.dt', function() {
		sharedDataTable.column(0, {
			search : 'applied',
			order : 'applied'
		}).nodes().each(function(cell, i) {
			cell.innerHTML = i + 1;
		});
	}).draw();
	
	filterStatusOnReady();
}
function activateTab() {
	var douClasses = [ "all", "own", "shared" ];
	var link = window.location.href.trim();
	var firstHash = link.indexOf('#');
	var activateClass = "all";
	if (firstHash != -1) {
		console.log(firstHash)
		var secondHash = link.substring(firstHash + 1, link.length).search('#');
		if (secondHash == -1) {
			activateClass = link.substring(firstHash + 1, link.length);
			console.log(activateClass);
		} else {
			activateClass = link.substring(firstHash + 1, firstHash
					+ secondHash + 1);
			console.log(activateClass);
		}
	}
	console.log(douClasses);
	if (douClasses.indexOf(activateClass) == -1) {
		activateClass = "all";
	}
	activateClass += "-tab"
	$("#" + activateClass).addClass("active");
	var divClass = $("#" + activateClass).attr("href");
	console.log(divClass);
	$(divClass).addClass("active");
	$(divClass).addClass("show");
}



//$(document).on('show.bs.popover', ".status-popover", function(){
//	var obj = $(this);
//	var group = globalDoUGroups[obj.attr("dou-id")];
//		
//	obj.attr("title", generateStatusPopoversTitle(group));
//	obj.attr("data-content", generateStatusPopoversContent(group));
//
//});

$(document).on('shown.bs.popover', ".status-popover", function(){
	var obj = $(this);
	var group = globalDoUGroups[obj.attr("dou-id")];

	previousColor = currentColor;
	currentColor = colorClass[group["dou_status"]];
	toggleClassColours(previousColor, currentColor);
	
});

$("body").popover({
	selector: ".status-popover",
	trigger: 'hover',
	animation : true,
    html: true,
    template : '<div class="popover dynamic-border-color" role="tooltip"><div class="arrow dynamic-border-color"></div><h3 class="popover-header dynamic-text-color"></h3><div class="popover-body"></div></div>'
}); 


function generateStatusPopoversTitle(group) {
	var statusPopoverTitle = $("#status-popover-title").clone();
	statusPopoverTitle.addClass("text-"+colorClass[group["dou_status"]]);
	statusPopoverTitle.text(group["dou_name"]);
	return statusPopoverTitle[0].outerHTML;
}

function generateStatusPopoversContent(group) {
	//console.log(group);
	var statusPopoverContent = $("#status-popover-content").clone();
	statusPopoverContent.css.display = "block"; 
	
	var status = "";
	var statusPrefixConnector = "";
	var statusSuffixConnector = "";
	var statusSuffix = "";
	if(group["dou_status"] == "PENDING") {
		statusPrefixConnector = " is ";
		status = group["dou_status"];
		statusSuffixConnector = " with ";
		statusSuffix = phases[group["dou_phase"]];
	}
	else {
		statusPrefixConnector = " was ";
		status = group["dou_status"];
		statusSuffixConnector = " on ";
		statusSuffix = getCurrentTimeZoneTime(group["final_state_changed_on"]);
	}
	
	statusPopoverContent.find("#dou_status_prefix_connector").text(statusPrefixConnector);
	statusPopoverContent.find("#dou_status").text(status);
	statusPopoverContent.find("#dou_status").addClass("text-"+colorClass[group["dou_status"]]);
	statusPopoverContent.find("#dou_status_suffix_connector").text(statusSuffixConnector);
	statusPopoverContent.find("#dou_status_suffix").text(statusSuffix);
	statusPopoverContent.find("#dou_status_suffix").addClass("text-"+colorClass[group["dou_status"]]);
	
	loadAccessTo(group, statusPopoverContent)
	
	return statusPopoverContent.html();
}

function generateUserRow(user) {
	var userRow = document.createElement("li");
	userRow.setAttribute("class", "list-group-item"); //pl-0 ml-n1
	
	var userElement = document.createElement("div");
	userElement.setAttribute("class", "user-element");
	
	var email = document.createElement("div");
	email.setAttribute("id", "email");
	email.setAttribute("class", "d-inline");
	email.innerText = user["email"];
	userElement.append(email);
	
	var role = document.createElement("div");
	role.setAttribute("id", "role");
	role.setAttribute("class", "d-none");
	role.setAttribute("selectedRole", user["role"]);
	role.innerText = roles[user["role"]];
	userElement.append(role);
	
	var status = generateStatusObj(user);
	status.classList.add("font-weight-bold", "mr-2");
	
	
	if(user["dou_approval"] == "APPROVED" || user["dou_approval"] == "REJECTED") {
	var time = document.getElementById("approval-time").cloneNode(true);
	time.innerText = "On "+getCurrentTimeZoneTime(user["approval_time"]);
//	time.classList.add("float-right");
	userElement.append(document.createElement("br"));
	userElement.append(time);
	}
	
	
	//statusColumn.append(status);
	userElement.prepend(status);
	userRow.append(userElement);
	
	return userRow;
}

function generateStatusObj(user) {
	var status = document.getElementById("user-approval-status-"+user["dou_approval"].toLowerCase()+"-icon").cloneNode(true);
	status.setAttribute("id", user["email"].replace(/\./g,"-")+"-"+user["dou_approval"]);
//	if(user["dou_approval"] == "APPROVED" || user["dou_approval"] == "REJECTED") {
//		var time = document.getElementById("approval-time").cloneNode(true);
//		time.innerText = "On "+getCurrentTimeZoneTime(user["approval_time"]);
//		status.append(document.createElement("br"));
//		status.append(time);
//	}
	status.classList.remove("d-none");
	return status;
}

function loadAccessTo(group, statusPopoverContent) {
	var accessList = group["access_to"];
	var peopleList = statusPopoverContent.find("#people-list");
	peopleList.empty();
	
	// Setting Initiator display start
	var roleHeader = document.createElement("li");
	roleHeader.setAttribute("class", "list-group-item list-group-item-dark font-weight-bold");
	roleHeader.innerText = "Initiator";
	peopleList.append(roleHeader);
	
	var user = {};
	user["email"] = group["created_by"]; //document.getElementById("created_by").innerText;
	user["role"] = "INITIATOR";
	if(group["dou_phase"] == "REVIEW_RESEND") {
		user["dou_approval"] = "PENDING";
	} else {
		user["dou_approval"] = "INITIATED";
	}
	
	peopleList.append(generateUserRow(user));
	// Setting Initiator display end
	var keys = Object.keys(roles);
	
	var roleBaseSorted = {};
	for (var i = 0; i < keys.length; i++) {
		roleBaseSorted[keys[i]] = [];
	}
	
	for (var i = 0; i < accessList.length; i++) {
		roleBaseSorted[accessList[i]["role"]].push(accessList[i]);
	}
	
	for(var i = 0; i < keys.length; i++) {
		var roleHeader = document.createElement("li");
		roleHeader.setAttribute("class", "list-group-item list-group-item-dark font-weight-bold");
		roleHeader.innerText = roles[keys[i]];
		peopleList.append(roleHeader);
		if(roleBaseSorted[keys[i]].length > 0) {
			for(var j = 0; j < roleBaseSorted[keys[i]].length; j++) {
				peopleList.append(generateUserRow(roleBaseSorted[keys[i]][j]));
			}
		} else {
			// if there are no users in this role
			roleHeader.remove();
//			var emptyRow = document.createElement("li");
//			emptyRow.setAttribute("class", "list-group-item disabled text-center");
//			emptyRow.innerText = "No "+roles[keys[i]];
//			peopleList.append(emptyRow);
		}
	}
}
