$(document).ready(function() {
	activeNavItem();
	// getRelevantGroups();
});
var global_DataArr;
function onPageLoad() {
	getRelevantGroups();
}

function activeNavItem() {
// $("#dashboard-nav-item a")[0].prepend("");
	$("#dashboard-nav-item").addClass("active");
}


function categoryBasedCards(obj) {
	var type = $(obj).attr("aria-cat-name")
	
	
	$.get("/SafeSpots/rest/safespots/getCategoriesByCategory1?city=Bangalore", function(data) {
		data = JSON.parse(data);
		global_DataArr = data["safeLocData"];
		
		var data = [];
		for(var i=0; i<global_DataArr.length; i++) {
			if(global_DataArr[i]["type"].replace(" ","-").toLowerCase() == type.toLowerCase()) {
				data.push(global_DataArr[i]);
			}
		}
		populateRelevantCardsdeck(data);
		
	});
	
//	populateGlobalData();
//	
//	
//	setTimeout(function(){ 
//		var data = [];
//	for(var i=0; i<global_DataArr.length; i++) {
//		if(global_DataArr[i]["type"].replace(" ","-").toLowerCase() == type.toLowerCase()) {
//			data.push(global_DataArr[i]);
//		}
//	}
//	populateRelevantCardsdeck(data);
//},"1000");
}

function populateModal(obj) {
	
	var id = $(obj).attr("aria-id")
	var data;
	for(var i=0; i<global_DataArr.length; i++) {
		if(global_DataArr[i]["id"] == id) {
			data = global_DataArr[i];
			// console.log(global_DataArr[i]);
			break;
		}
	}
	
	var color;
	if(data["overAllRating"] < 2.5) {
		color = "#dc3545";
	} else if( data["overAllRating"] < 4.0 ) {
		color = "#ffc107";
	} else {
		color = "#28a745";
	}
	
	var modal = $("#details-modal");
	
	modal.find("#location-name").text(data["name"]);
	modal.find("#location-rating").text(data["overAllRating"]);
	modal.find("#location-address").text(data["address"]);
	
	modal.find("#sanitization-rating").text(data["overAllsanitization"]);
	modal.find("#temp-sensor-rating").text(data["overAlltemperature_sensor"]);
	modal.find("#social-distance-rating").text(data["overAllsocial_distancing"]);
	modal.find("#mask-rating").text(data["overAllmask"]);
	
	modal.find("#sanitization-rating-progress").css("width", Math.ceil((data["overAllsanitization"]/5)*100)+"%");
	modal.find("#temp-sensor-rating-progress").css("width", Math.ceil((data["overAlltemperature_sensor"]/5)*100)+"%");
	modal.find("#social-distance-rating-progress").css("width", Math.ceil((data["overAllsocial_distancing"]/5)*100)+"%");
	modal.find("#mask-rating-progress").css("width", Math.ceil((data["overAllmask"]/5)*100)+"%");

	modal.find("#location-rating-wrapper").css("color", color);
	
	
	if(data["safty_review"].length > 0) {
		modal.find("#no-review-instruction").css("display", "none");
	} else {
		modal.find("#no-review-instruction").css("display", "block");
	}
	
	var reviewList = modal.find("#reviews-list");
	reviewList.empty();
	
	for(var i=0; i< data["safty_review"].length; i++) {
		reviewList.append(generateReviewCard(data["safty_review"][i]))
	}
	
//	#28a745 - su
//	#ffc107 - wa
//	#dc3545 - da
}


function generateReviewCard(review) {
	var reviewCard = $("#review-div-template").clone();
	reviewCard.find("#review-author-div").text(review["name"]);
	reviewCard.find("#reivew-body-div").text(review["review_comment"]);
	reviewCard.find("#author-overall-rating").text(review["rating"]);
	
	reviewCard.removeAttr("id")
	return reviewCard;
	
}

function populateGlobalData() {
	$.get("/rest/dou/groups", function(data) {
		global_DataArr = data["safeLocData"];
	});
}

function getRelevantGroups() {
	$.get("/SafeSpots/rest/safespots/getCategoriesByCategory?city=Bangalore&category=Pharmacies", function(data) {
		data = JSON.parse(data);
		global_DataArr = data["safeLocData"];
		var dataArr = data["safeLocData"];
		console.log(dataArr);
		populateRelevantCardsdeck(dataArr);
	});
}

function populateRelevantCardsdeck(dataArr) {
	console.log(dataArr.length)
	$("#relevant-cards").empty();
	for (i = 0; i < dataArr.length; i++) {
		$("#relevant-cards").append(generateDoUCard(dataArr[i]));
	}
}

function generateDoUCard(data) {
	//console.log(data)
	var card = $("#template-card").clone();
	
	var color;
	var colorClass;
	if(data["overAllRating"] < 2.5) {
		color = "#dc3545";
		colorClass = "danger"
	} else if( data["overAllRating"] < 4.0 ) {
		color = "#ffc107";
		colorClass = "warning"
	} else {
		color = "#28a745";
		colorClass = "success"
	}


	// card.attr("aria-id",data["id"]);
	card.find("#location-name").text(data["name"]);
	card.find("#location-rating").text(data["overAllRating"]);
	card.find("#location-address").text(data["address"]);
	card.find("#sanitization-value").text(data["overAllsanitization"]);
	card.find("#temp-sensor-value").text(data["overAlltemperature_sensor"]);
	card.find("#social-distance-value").text(data["overAllsocial_distancing"]);
	card.find("#mask-value").text(data["overAllmask"]);
	card.find("#details-page-link").attr("aria-id", data["id"]);
	card.find("#location-category").text(data["type"]);
	//card.find("#details-page-link").click(populateModal(data["id"]));
	card.find("#location-rating").parent().addClass("badge-"+colorClass);
	
	card.find("#sanitization-value").addClass();
	card.find("#temp-sensor-value").addClass();
	card.find("#social-distance-value").addClass();
	card.find("#mask-value").addClass();
	
	card.removeAttr('id');
	card.removeAttr("style");
	return card;
}

// Program a custom submit function for the form
$("#create_dou_form").submit(function(event) {

	// disable the default form submission
	event.preventDefault();
	
	
	var proceed = setAccessTo(); // Sets the accessto values which is in form
									// of badges.
	
	if (proceed != false) {
		$("#initiate-button-disabled").removeClass("d-none");
		$("#initiate-button").addClass("d-none");
		// grab all form data
		var formData = new FormData($(this)[0]);

		$.ajax({
			url : '/rest/dou/group/add',
			type : 'POST',
			enctype :'multipart/form-data',
			data : formData,
			async : true,
			cache : false,
			contentType : false,
			processData : false,
			success : function(returnData) {
				$("#initiate-button-disabled").addClass("d-none");
				$("#initiate-button").removeClass("d-none");
				if(returnData["code"] == "SUCCESS") {
					$("#dou-upload-form").modal('hide');
					getRelevantGroups();
					alertSuccess(returnData["message"]);
				} else {
					alertDanger(returnData["message"]);
				}
			},
			error : function(returnData) {
				$("#initiate-button-disabled").addClass("d-none");
				$("#initiate-button").removeClass("d-none");
				alertDanger("Error Sharing the DoU, Please try again later!!");
			}
		});

		return false;
	}

});

// sleep time expects milliseconds
function sleep(ms) {
return new Promise(resolve => setTimeout(resolve, ms));
}

function setAccessTo() {
	$("#dou-submit-instruction").text("");
	var peopleList = $("#access-to-email-badges span");
	var person = {
			"email":"",
			"role":""
	};
	var personList = "[]";
	for(var i=0; i<peopleList.length; i++) {
		var user = jQuery(peopleList[i]);
		replaceClass("#"+user.attr("id"), "border-danger", "border-dark");
		if(user.find("#role").attr("selectedRole").trim() == "") {
			replaceClass("#"+user.attr("id"), "border-dark", "border-danger");
			$("#dou-submit-instruction").css("color","red");
			$("#dou-submit-instruction").text("**Select a role for all users!");
			return false;
		}
		person["email"] = user.find("#email").text().trim();
		person["role"] = user.find("#role").attr("selectedRole");
		var obj = JSON.parse(personList);
		obj.push(person);
		personList = JSON.stringify(obj);
	}
	$("#dou-access-to").val(personList);
	return true;
}

function removeAccessToEmail(obj) {
	var spanElem = jQuery(obj);
	spanElem.parents('.user-wrapper').remove();
	}


var liveSearchtimer;
function liveSearchTimer(obj) {
    clearTimeout(liveSearchtimer);
    var ms = 1000; // milliseconds
    liveSearchtimer = setTimeout(function() {
    	liveSearch(obj);
    }, ms);
}

function liveSearch(obj) {
	var email = obj.value.trim();
	if(email == "") {
		$("#dou-access-to-search-result").empty();
		$("#dou-access-to-search-result").append("<a class='dropdown-item'>Enter emailId to search</a>");
		
	}
	else {
	$.ajax({
		url : 'https://bluepages.ibm.com/BpHttpApisv3/wsapi?byInternetAddr='+email,
		type : 'GET',
		async : true,
		cache : false,
		contentType : false,
		processData : false,
		success : function(returnData) {
			if(returnData.charAt(0) != '#') {
				$("#dou-access-to-search-result").empty();
				$("#dou-access-to-search-result").append("<a class='dropdown-item' onclick='addAccessToVal(this)'>"+email+"</a>");
			}
			else {
				$("#dou-access-to-search-result").empty();
				$("#dou-access-to-search-result").append("<a class='dropdown-item'>No Match Found</a>");
			}
		}
	});
	}
}

function addAccessToVal(obj) {
	var peopleList = $("#access-to-email-badges span");
	var email = obj.innerHTML.trim();
	var emailPresent = false; 
	for(var i=0; i<peopleList.length; i++) {
		if(jQuery(peopleList[i]).find("#email").text().trim() == email) {
			emailPresent = true;
			break;
		}
	}
	
	if(!emailPresent) {
		$("#access-to-email-badges").append(generateUserElement(email));
		$("#dou-access-to-search").val("");
		$('#dou-access-to-search').keyup();
	}
}

function generateUserElement(email) {
	var card = $("#template-user-wrapper").clone();
	card.find("#email").text(email);
	card.attr('id',"userbadge-"+email.replace(/\./g,"-").replace(/@/g,"-"));
	var parentRoleElementTemplate = card.find("#template-user-role").parent();
	var roleElementTemplate = jQuery(card.find("#template-user-role"));
	var keys = Object.keys(roles);
	for(var i=0;i<keys.length;i++) {
		var roleElement = roleElementTemplate.clone();
		roleElement.text(roles[keys[i]]);
		roleElement.attr("dropdownVal", keys[i]);
		roleElement.attr("id", "");
		parentRoleElementTemplate.append(roleElement);
	}
	roleElementTemplate.remove();
	
	return card;
}

function setUserRole(obj) {
	var roleElem = jQuery(obj);
	roleElem.parents('.user-wrapper').find('#role').text(roleElem.text());
	roleElem.parents('.user-wrapper').find('#role').attr("selectedRole", roleElem.attr("dropdownVal"));
}

function replaceClass(selector, removeClass, addClass) {
	$(selector).removeClass(removeClass);
	if(!$(selector).hasClass(addClass)) {
		$(selector).addClass(addClass);
	}
}