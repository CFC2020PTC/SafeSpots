$(document).ready(function() {
	// enableToolTip();
});

var colorClass = {
	"" : "",
	"NEW" : "primary",
	"PENDING" : "info",
	"APPROVED" : "success",
	"CANCELED" : "danger"
}

function toggleClassColours(previousColor, currentColor) {
	// set or remove color classes from the elements on DoU load
		replaceClass(".dynamic-border-color", "border-" + previousColor, "border-" + currentColor);
		replaceClass(".dynamic-text-color", "text-" + previousColor, "text-" + currentColor);
		replaceClass(".dynamic-btn-outline-color", "btn-outline-" + previousColor, "btn-outline-" + currentColor);
}

function replaceClass(selector, removeClass, addClass) {
// console.log("Removing "+removeClass);
	$(selector).removeClass(removeClass);
	if(!$(selector).hasClass(addClass)) {
// console.log("Adding "+addClass);
		$(selector).addClass(addClass);
	}
}

$(".dou-file-input").attr("accept", ".doc,.docx,.pdf");

$(document).on("click", ".dou-tooltips", function () {
	var obj = $(this);
	obj.tooltip("dispose");
});

$(document).on('mouseover','.dou-tooltips', function(){
    $(this).tooltip('show');
});

$(document).on('mouseout','.dou-tooltips', function(){
    $(this).tooltip('hide');
});

function getCurrentTimeZoneTime(time) {
	var givenDate = Date.parse(time.substr(0,19));
	var currentDate = new Date();
	var timeZoneTimeInMs = givenDate.getTime()
			+ -(currentDate.getTimezoneOffset() * 60000);
	var TimeZoneTime = new Date(timeZoneTimeInMs);
	return Date.parse(TimeZoneTime).toString("ddS MMM, yyyy");
}

function getCurrentTimeZoneTimeWithTime(time) {
	var givenDate = Date.parse(time.substr(0,19));
	var currentDate = new Date();
	var timeZoneTimeInMs = givenDate.getTime()
			+ -(currentDate.getTimezoneOffset() * 60000);
	var TimeZoneTime = new Date(timeZoneTimeInMs);
	return Date.parse(TimeZoneTime).toString("ddS MMM, yyyy h:mm tt");
}

function getDatesInBetween(startDateStr, endDateStr) {
	var dateFormat = "YYYY-MM-DD";
	var startDate = moment(startDateStr, dateFormat);// .format(dateFormat);
	var endDate = moment(endDateStr, dateFormat);// .format(dateFormat);
	var rangeDates = moment.range(startDate, endDate);
	var days = Array.from(rangeDates.by("day", { excludeEnd: true}));
	if(days.length>1) {
		delete days[0]; 
	}
	console.log(days.map(d => d.format('DD MMM, YYYY')))
	return days.map(d => d.format('DD MMM, YYYY'));
}

var elements = document.getElementsByClassName("column");
// List View
function listView() {
	for (i = 0; i < elements.length; i++) {
		elements[i].style.width = "100%";
	}
}

// Grid View
function gridView() {
	for (i = 0; i < elements.length; i++) {
		elements[i].style.width = "50%";
	}
}

function getSize(size) {
	var sizes = [ ' Bytes', ' KB', ' MB', ' GB', ' TB', ' PB', ' EB', ' ZB',
			' YB' ];

	for (var i = 1; i < sizes.length; i++) {
		if (size < Math.pow(1024, i))
			return (Math.round((size / Math.pow(1024, i - 1)) * 100) / 100)
					+ sizes[i - 1];
	}
	return size;
}

function wait(ms) {
	var d = new Date();
	var d2 = null;
	do {
		d2 = new Date();
	} while (d2 - d < ms);
}

function setCookie(cname, cvalue, exdays) {
	  var d = new Date();
	  d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
	  var expires = "expires="+d.toUTCString();
	  document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
	}

function getCookie( name ) {
	  var parts = document.cookie.split(name + "=");
	  if (parts.length == 2) return parts.pop().split(";").shift();
	}

function expireCookie( cName ) {
    document.cookie = 
        encodeURIComponent(cName) + "=deleted; expires=" + new Date( 0 ).toUTCString();
}

function getDownloadToken() {
    var downloadToken = new Date().getTime();
    return downloadToken;
}