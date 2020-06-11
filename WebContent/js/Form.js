//Add the following code if you want the name of the file appear on select
$(".custom-file-input").on(
		"change",
		function() {
			var fileName = $(this).val().split("\\").pop();
			$(this).siblings(".custom-file-label").addClass("selected")
					.html(fileName);
			$(this).siblings(".custom-file-label").attr("data-original-title",fileName);
//			var totalWidth = $(this).siblings(".custom-file-label").width();
//			var fileNameLen = fileName.length;
//			console.log(totalWidth+" -- "+fileNameLen+" -- "+80+"%")
//			$(this).siblings(".custom-file-label").css("font-size",(fileNameLen*(totalWidth/100)).toString()+"%");
		});