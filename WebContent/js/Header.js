function alertSuccess(msg) {
	var banner = $("#success-alert-template").clone();
	banner.text(msg);
	banner.css("display","block");
	$("#alert-container").append(banner);
	sleep(3000).then(() => {
		banner.remove();
	});
}

function alertDanger(msg) {
	var banner = $("#failure-alert-template").clone();
	banner.text(msg);
	banner.css("display","block");
	$("#alert-container").append(banner);
	sleep(3000).then(() => {
		banner.remove();
	});
}

function alertWarning(msg) {
	var banner = $("#warning-alert-template").clone();
	banner.text(msg);
	banner.css("display","block");
	$("#alert-container").append(banner);
	sleep(3000).then(() => {
		banner.remove();
	});
}