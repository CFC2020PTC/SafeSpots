$(document).ready(function() {
	activeNavItem();
	getDoUStatusCount();
	getRelevantGroups();
});

function onPageLoad() {
	getDoUStatusCount();
	getRelevantGroups();
}

function activeNavItem() {
//	$("#dashboard-nav-item a")[0].prepend("");
	$("#dashboard-nav-item").addClass("active");
}

function getDoUStatusCount() {
	$.get("/rest/dou/groups/douStatusCount", function(data) {
		$("#status-new-count").text(data.NEW);
		$("#status-pending-count").text(data.PENDING);
		$("#status-approved-count").text(data.APPROVED);
		$("#status-canceled-count").text(data.CANCELED);
	});
}

function createCardDeck() {
	var deck = document.createElement("div");
	deck.className = "card-deck";
	return deck;
}

function getRelevantGroups() {
	$.get("/rest/dou/groups/relevant", function(data) {
		// Object.keys(data[0]);
		$("#relevant-cards").empty();
		var k = 0;
		for (i = 0; i < data.length; i++) {
			var deck = createCardDeck();
			deck.id = "card-deck-" + k;
			$("#relevant-cards").append(deck);

			for (j = 0; j < 3 && i < data.length; j++, i++) {
				$("#card-deck-" + k).append(generateDoUCard(data[i]));
			}
			k++;
			i--;
		}
	});
}

function generateDoUCard(data) {
	var card = $("#template-card").clone();
	var color = colorClass[data["dou_status"]]
	card.addClass("border-"+color);
	card.find("#dou_name").addClass("text-"+color);
	card.find("#dou_status").addClass("badge-"+color);
	card.find("#view_dou").addClass("btn-"+color);
	card.find("#view_dou").attr("href", "/DoUDetails.jsp?id="+data["_id"]);
	var keys = Object.keys(data);
	var len = keys.length;
	data["last_modified_time"] = getCurrentTimeZoneTime(data["last_modified_time"]);
//	console.log(data["last_modified_time"]);
	for (var i = 0; i < len; i++) {
		card.find("#" + keys[i]).text(data[keys[i]]);
	}
	card.removeAttr('id');
	return card;
}

//Program a custom submit function for the form
$("#create_dou_form").submit(function(event) {

	//disable the default form submission
	event.preventDefault();
	
	
	var proceed = setAccessTo(); // Sets the accessto values which is in form of badges.
	
	if (proceed != false) {
		$("#initiate-button-disabled").removeClass("d-none");
		$("#initiate-button").addClass("d-none");
		//grab all form data  
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
					getDoUStatusCount();
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