$(document).ready(function() {
	$.blockUI({  message: "<h4>Loading...<h4>", css: { 
        border: 'none', 
        padding: '15px', 
        backgroundColor: 'none', 
        '-webkit-border-radius': '10px', 
        '-moz-border-radius': '10px', 
        opacity: 1, 
        color: 'black'
    } }); 
	activeNavItem();
	loadListGrid();
	getActionRequiredGroups();
	loadActionRequiredDoUUtilities();
});

function onPageLoad() {
	getActionRequiredGroups();
}

function loadListGrid() {
	$('#list').click(function(event){event.preventDefault();$('#products .item').addClass('list-group-item');});
    $('#grid').click(function(event){event.preventDefault();$('#products .item').removeClass('list-group-item');$('#products .item').addClass('grid-group-item');});
}


function loadActionRequiredDoUUtilities() {
	$('#sort-action-required-dous').click(function (){
	    $('#action-required-dous .item').sort(function(a,b) {
	        return $(a).find(".card-title").text() > $(b).find(".card-title").text() ? 1 : -1;
	    }).appendTo("#action-required-dous");
	})
	
	$('#search-action-required-dous').keyup(function (){
    
    var value = $(this).val().toLowerCase();
    $("#action-required-dous .item").filter(function() {
      $(this).toggle($(this).find(".card-title").text().toLowerCase().indexOf(value) > -1)
    });
    
	})
}



function activeNavItem() {
	$("#action-required-nav-item").addClass("active");
}


function createCardDeck() {
	var deck = document.createElement("div");
	deck.className = "card-deck";
	return deck;
}

function getActionRequiredGroups() {
	$.get("/rest/dou/groups/actionRequired", function(data) {
		// Object.keys(data[0]);
		console.log(data);
		$("#action-required-dous").empty();
		if(data.length > 0) {
			$("#action-required-dous-instruction").css("display", "none");
			$("#action-required-dous-utilities").css("display", "block");
		} 
		else {
			$("#action-required-dous-instruction").css("display", "block");
			$("#action-required-dous-utilities").css("display", "none");
		}
		var k = 0;
		for (i = 0; i < data.length; i++) {
			$("#action-required-dous").append(generateDoUCard(data[i]));
		}
		$.unblockUI();
	});
}

function generateDoUCard(data) {
	var card = $("#action-required-dou-template").clone();
	var color = colorClass[data["dou_status"]]
	// card.addClass("border-"+color);
	card.find("#dou-name").text(data["dou_name"]);
	card.find("#dou-name").addClass("text-"+color);
	
	card.find("#dou-file-version").text("v"+data["dou_file_version"]);
	
	card.find("#created_by").text(data["created_by"]);
	card.find("#created_time").text(getCurrentTimeZoneTime(data["created_time"]));
	
	card.find("#dou_status").text(data["dou_status"]);
	
	card.find("#dou_status_suffix").text(phases[data["dou_phase"]]);
	
	card.find("#user-id").text(userName);
	
	// card.find("#view_dou").addClass("btn-"+color);
	card.find("#view_dou").attr("href", "/DoUDetails.jsp?id="+data["_id"]);
	var keys = Object.keys(data);
	var len = keys.length;
	data["last_modified_time"] = getCurrentTimeZoneTime(data["last_modified_time"]);
	
	card.removeAttr('id');
	return card;
}


// sleep time expects milliseconds
function sleep(ms) {
return new Promise(resolve => setTimeout(resolve, ms));
}


function replaceClass(selector, removeClass, addClass) {
	$(selector).removeClass(removeClass);
	if(!$(selector).hasClass(addClass)) {
		$(selector).addClass(addClass);
	}
}