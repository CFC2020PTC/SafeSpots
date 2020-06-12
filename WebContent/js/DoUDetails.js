		var previousColor = "";
		var currentColor = "";
		var userRole = "";
		var group = "";
		var attachmentsTable = $('#attachments-table').DataTable();
		var globalFeatureAccess = "";
		
		
		$(document).ready(function() {
			loadDoUOnReady();
			searchDoUs();
		});
		
		window['moment-range'].extendMoment(moment);
		
		function setAccessTo() {
			$("#access-submit-instruction").text("");
			var peopleList = $("#access-to-email-badges span");
			
			var person = {"email":"", "role":""};
			var personList = "[]";
			for(var i=0; i<peopleList.length; i++) {
				var user = jQuery(peopleList[i]);
				replaceClass("#"+user.attr("id"), "border-danger", "border-dark");
				if(user.find("#role").attr("selectedRole").trim() == "") {
					replaceClass("#"+user.attr("id"), "border-dark", "border-danger");
					$("#access-submit-instruction").css("color","red");
					$("#access-submit-instruction").text("**Select a role for all users!");
					return false;
				}
				person["email"] = user.find("#email").text().trim();
				person["role"] = user.find("#role").attr("selectedRole").trim();
				var obj = JSON.parse(personList);
				obj.push(person);
				personList = JSON.stringify(obj);
			}
// console.log(personList);
			return personList;
		}
		
		function setDelegateAccessTo() {
			$("#delegate-access-submit-instruction").text("");
			var peopleList = $("#delegate-access-to-email-badges span");
			
			var person = {"email":"", "role":""};
			var personList = "[]";
			for(var i=0; i<peopleList.length; i++) {
				var user = jQuery(peopleList[i]);
				person["email"] = user.find("#email").text().trim();
				person["role"] = user.find("#role").attr("selectedRole").trim();
				var obj = JSON.parse(personList);
				obj.push(person);
				personList = JSON.stringify(obj);
			}
			return personList;
		}
		
		function setAddReviewerAccessTo() {
			$("#add-reviewer-submit-instruction").text("");
			var peopleList = $("#add-reviewer-to-email-badges span");
			
			var person = {"email":"", "role":""};
			var personList = "[]";
			for(var i=0; i<peopleList.length; i++) {
				var user = jQuery(peopleList[i]);
				person["email"] = user.find("#email").text().trim();
				person["role"] = user.find("#role").attr("selectedRole").trim();
				var obj = JSON.parse(personList);
				obj.push(person);
				personList = JSON.stringify(obj);
			}
			return personList;
		}
		
		
		// Program a custom submit function for the Edit access form
		$("#edit-access-form").submit(function(event) {
			

			// disable the default form submission
			event.preventDefault();
			
			var persons = setAccessTo(); // Sets the accessto values which is
											// in form of badges.
			if(persons != false){
				$("#edit-access-button-disabled").removeClass("d-none");
				$("#edit-access-button").addClass("d-none");
				$.ajax({
		            url: '/rest/dou/group/'+$("#dou").attr("groupId")+'/access',
		            type: 'post',
		            dataType: 'json',
		            contentType: 'application/json',
		            data: persons,
		            success: function (returnData) {
		            	$("#edit-access-button-disabled").addClass("d-none");
		    			$("#edit-access-button").removeClass("d-none");
		            	console.log(returnData);
		            	if(returnData["code"] == "SUCCESS") {
		            		$("#edit-access-modal").modal("hide");
		            		fetchDoUGroup($("#dou").attr("groupId"));
			            	alertSuccess(returnData["message"]);
		            	} else {
		            		alertDanger(returnData["message"]);
		            	}
		            	
		            },
		            error: function (returnData) {
		            	$("#edit-access-button-disabled").addClass("d-none");
		    			$("#edit-access-button").removeClass("d-none");
		            	alertDanger("Access Modification Error");
		            }
		        });

				return false;
			}
		});
		
		
		// Program a custom submit function for the delegate access form
		$("#delegate-access-form").submit(function(event) {
			$("#delegate-button-disabled").removeClass("d-none");
			$("#delegate-button").addClass("d-none");
			// disable the default form submission
			event.preventDefault();
			
			var persons = setDelegateAccessTo(); // Sets the accessto values
													// which is
											// in form of badges.
			if(persons != false){
				$.ajax({
		            url: '/rest/dou/group/'+$("#dou").attr("groupId")+'/delegateAccess',
		            type: 'post',
		            dataType: 'json',
		            contentType: 'application/json',
		            data: persons,
		            success: function (returnData) {
		            	$("#delegate-button-disabled").addClass("d-none");
						$("#delegate-button").removeClass("d-none");
		            	if(returnData["code"] == "SUCCESS") {
		            		$("#delegate-access-modal").modal("hide");
		            		alertSuccess(returnData["message"]);
		            		$("#delegate-access-modal input").val("");
		            		fetchDoUGroup($("#dou").attr("groupId"));
		            		// loadAccessTo(returnData);
		            	} else {
		            		alertDanger(returnData["message"]);
		            	}
						
		            },
		            error: function (returnData) {
		            	$("#delegate-button-disabled").addClass("d-none");
						$("#delegate-button").removeClass("d-none");
		            	alertDanger("Error delegating access, Please try after some time!!");
		            }
		        });

				return false;
			}
		});
		
		
		// Program a custom submit function for the AddReviewer form
		$("#add-reviewer-form").submit(function(event) {
			$("#add-reviewer-button-disabled").removeClass("d-none");
			$("#add-reviewer-button").addClass("d-none");
			// disable the default form submission
			event.preventDefault();
			
			var persons = setAddReviewerAccessTo(); // Sets the accessto values
													// which is
											// in form of badges.
			if(persons != false){
				$.ajax({
		            url: '/rest/dou/group/'+$("#dou").attr("groupId")+'/addReviewer',
		            type: 'post',
		            dataType: 'json',
		            contentType: 'application/json',
		            data: persons,
		            success: function (returnData) {
		            	$("#add-reviewer-button-disabled").addClass("d-none");
						$("#add-reviewer-button").removeClass("d-none");
		            		if(returnData["code"] == "SUCCESS") {
		            			$("#add-reviewer-modal").modal("hide");
		            			alertSuccess(returnData["message"]);
		            			$("#add-reviewer-modal input").val("");
		            			fetchDoUGroup($("#dou").attr("groupId"));
		            		} else {
		            			$("#add-reviewer-modal").modal("hide");
		            			alertDanger(returnData["message"]);
		            			$("#add-reviewer-modal input").val("");
		            		}
		            },
		            error: function (returnData) {
		            	$("#add-reviewer-button-disabled").addClass("d-none");
						$("#add-reviewer-button").removeClass("d-none");
		            	alertDanger(returnData["message"]);
		            }
		        });

				return false;
			}
		});
		
		
		// Program a custom submit function for the Update file form
		$("#update-doufile-dou-form").submit(function(event) {
			$("#update-doufile-submit-button-disabled").removeClass("d-none");
			$("#update-doufile-submit-button").addClass("d-none");

			// disable the default form submission
			event.preventDefault();

			// grab all form data
			console.log($(this)[0]);
			var formData = new FormData($(this)[0]);
			// console.log(formData);

			$.ajax({
				url : '/rest/dou/group/'+$("#dou").attr("groupId")+'/updateDoU',
				type : 'POST',
				data : formData,
				async : true,
				cache : false,
				contentType : false,
				processData : false,
				success : function(returnData) {
					$("#update-doufile-submit-button-disabled").addClass("d-none");
					$("#update-doufile-submit-button").removeClass("d-none");
					if(returnData["code"] == "SUCCESS") {
						$("#update-doufile-modal").modal("hide");
						alertSuccess(returnData["message"]);
						fetchDoUGroup($("#dou").attr("groupId"));
						$("#update-doufile-modal input").val("");
						$(".custom-file-label").html("Choose DoU");
					} else {
						alertDanger(returnData["message"]);
					}
				},
				error : function(returnData) {
					$("#update-doufile-submit-button-disabled").addClass("d-none");
					$("#update-doufile-submit-button").removeClass("d-none");
					alertDanger("Error uploading DoU, Please try again later!!");
				}
			});

			return false;
		});
		
		
		
		// Program a custom submit function for the attachment file form
		$("#attachments-form").submit(function(event) {
			// console.log("Ajax trigger");
			// disable the default form submission
			event.preventDefault();

			// grab all form data
			var formData = new FormData($(this)[0]);
			startAnimateProgress();
			$.ajax({
				url : '/rest/dou/'+$("#dou").attr("groupId")+'/attachment/add',
				type : 'POST',
				data : formData,
				async : true,
				cache : false,
				contentType : false,
				processData : false,
				success : function(returnData) {
					stopAnimateProgress();
					if(returnData["code"] == "SUCCESS") {
						alertSuccess(returnData["message"]);
						loadAttachments($("#dou").attr("groupId"));
						loadRevisionHistory($("#dou").attr("groupId"));
						loadComments($("#dou").attr("groupId"));
						// fetchDoUGroup($("#dou").attr("groupId"));
					} else {
						alertDanger(returnData["message"]);
					}
				},
				error : function(returnData) {
					stopAnimateProgress();
					alertDanger("Error uploading attachment, Please try again later!!");
				}
			});
			$("#attach-files")[0].value = '';

			return false;
		});
		
		function startAnimateProgress() {
			$("#attachment-upload-progress").css("width", "10%");
			$("#attachment-upload-progress").attr("aria-valuenow", "10");
			$("#attachment-upload-progress-wrapper").css("display", "");
			liveProgressTimer();
		}
		
		var liveProgresstimer;
		function liveProgressTimer() {
			
			clearTimeout(liveProgresstimer);
			var ms = 300; // milliseconds
			liveProgresstimer = setTimeout(function() {
				manageAnimateProgress();
			}, ms);
		}
		
		function manageAnimateProgress() {
			var nextval = "";
			var valueNow = $("#attachment-upload-progress").attr("aria-valuenow");
			if(parseInt(valueNow) + 10 < 100) {
				nextval = (parseInt(valueNow) + 10).toString();
				console.log(nextval);
				$("#attachment-upload-progress").css("width", nextval+"%");
				$("#attachment-upload-progress").attr("aria-valuenow", nextval);
			}
			liveProgressTimer();
		}
		
		function stopAnimateProgress() {
			clearTimeout(liveProgresstimer);
			$("#attachment-upload-progress").css("width", "100%");
			$("#attachment-upload-progress").attr("aria-valuenow", "100");
			setTimeout(function() {
				$("#attachment-upload-progress-wrapper").css("display", "none");
			}, 500);
		}
		
		function populateAttachments(attachments) {
			if(attachments != null) {
				var data = generateAttachmentRows(attachments);
				attachmentsTable.destroy();
				attachmentsTable = $("#attachments-table").DataTable(
				{	columnDefs: [
				    { className: "class-file-name", "targets": [0] }
				    ],
					data:data
				});
				// globalFeatureAccess deleteAttachment Start
				switch(globalFeatureAccess["deleteAttachment"]) {
				case "TRUE":
					$('.delete-attachment').each(function(){
						   $(this).css("display","").attr("disabled", false);
						})
					break;
				case "FALSE":
					$('.delete-attachment').each(function(){
						   $(this).css("display","none").attr("disabled", true);
						})
					break;
				default :
					$('.delete-attachment').each(function(){
						   $(this).css("display","none").attr("disabled", true);
						})
					break;
				}
				// globalFeatureAccess deleteAttachment end
			}
		}
		
		function generateAttachmentRows(attachments) {
			var attachmentsArray = [];
			
			var keys = Object.keys(attachments);
			for(var i=0;i<keys.length;i++) {
			var attachment = []
			var actions = '<button class="btn btn-success pl-1 pr-1 mr-2 download-attachment dou-tooltips" onclick="downloadAttachment(this)" attachment-name="'+keys[i]+'" data-placement="top" title="Download Attachment"><i id="attachment-download-icon" class="fa fa-download" aria-hidden="true"></i></button><button class="btn btn-danger pl-1 pr-1 delete-attachment dou-tooltips" data-toggle="modal" data-target="#delete-attachment-modal" attachment-name="'+keys[i]+'" onclick="populateDeleteModal(this)" data-placement="top" title="Delete Attachment"><i class="fa fa-trash" aria-hidden="true"></i></button>';
			var fileNameFormat = '<p id="file-name" style="float:left;width:90%">'+keys[i]+'</p><spanid="file-version" class="badge badge-dark" style="float:right">v'+attachments[keys[i]]["version"]+'</span>';
			attachment.push(fileNameFormat);
			attachment.push(attachments[keys[i]]["updated_by"]);
			attachment.push(getCurrentTimeZoneTimeWithTime(attachments[keys[i]]["updated_on"]));
			attachment.push(getSize(attachments[keys[i]]["size"]));
			attachment.push(actions);
			attachmentsArray.push(attachment);
			}
			
			return attachmentsArray;
		}
		
		$('#attach-files').change(function() { 
			$("#attachments-form").submit();
		});
		
		function loadAttachments(groupId) {
			$.ajax({
		        type: "GET",
		        url: "/rest/dou/" + groupId+"/attachments",
		        async: true,
		        success: function(attachments) {
		        	// console.log(attachments);
		        	populateAttachments(attachments);
		        }
		    });
		}
		
		
		
		
		function downloadAttachment(obj) {
			var ob = jQuery(obj);
			var downloadCookie = getDownloadToken();
			var dowbloadBtn = ob.find("#attachment-download-icon");
			ob.prop('disabled', true);
			dowbloadBtn.addClass('fa-spinner fa-pulse').removeClass('fa-download');
			var url ='/rest/dou/'+$("#dou").attr("groupId").trim()+'/attachments/'+ob.attr("attachment-name").trim()+'/download?downloadCookie='+downloadCookie;
			// $("<a download/>").attr("href", url).get(0).click();
			window.location= url; // '/rest/dou/'+$("#dou").attr("groupId").trim()+'/attachments/'+ob.attr("attachment-name").trim()+'/download?downloadCookie='+downloadCookie;
			var liveDownloadtimer;
			var attempts = 10;
			liveDownloadtimer = window.setInterval(function() {
				var token = getCookie("downloadCookie");
				if( (token == downloadCookie) || (attempts < 0) ) {
					dowbloadBtn.addClass('fa-download').removeClass('fa-spinner fa-pulse');
					ob.prop('disabled', false);
					window.clearInterval( liveDownloadtimer );
					// expireCookie( "downloadCookie" );
				}
				attempts--;
	        }, 1000);
			
		}
		
		function populateDeleteModal(obj) {
			var attachmentName = jQuery(obj).attr("attachment-name");
			$("#delete-attachment-dou-name").text($("#dou_name").text());
			$("#delete-attachment-name").text(attachmentName);
			$("#delete-attachment-button").attr("attachment-name", attachmentName);
			replaceClass("#delete-attachment-dou-name", "text-" + previousColor, "text-" + currentColor);
		}
		
		function deleteAttachment(obj) {
			$("#delete-attachment-button-disabled").removeClass("d-none");
			$("#delete-attachment-button").addClass("d-none");
			
			var attachmentNameJson = {"attachmentFileName": jQuery(obj).attr("attachment-name")};
			var attachmentName = JSON.stringify(attachmentNameJson);
			$.ajax({
				url : '/rest/dou/'+$("#dou").attr("groupId")+'/attachment/delete',
				type : 'DELETE',
				dataType: 'json',
	            contentType: 'application/json',
				data: attachmentName,
				success : function(returnData) {
					$("#delete-attachment-button-disabled").addClass("d-none");
					$("#delete-attachment-button").removeClass("d-none");
					if(returnData["code"] == "SUCCESS") {
						$("#delete-attachment-modal").modal('hide');
						alertSuccess(returnData["message"]);
						loadAttachments($("#dou").attr("groupId"));
						loadComments($("#dou").attr("groupId"));
					} else {
						alertDanger(returnData["message"]);
					}
				},
				error : function(returnData) {
					$("#delete-attachment-button-disabled").addClass("d-none");
					$("#delete-attachment-button").removeClass("d-none");
					alertDanger("Error Deleting attachment, Please try again later!!");
				}
			});
		}
		
		// sleep time expects milliseconds
		function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

		function generateUserRow(user) {
			// console.log(user)
			var userRow = document.createElement("li");
			userRow.setAttribute("class", "list-group-item");
			
			var userElement = document.createElement("div");
			userElement.setAttribute("class", "user-element");
			
			var email = document.createElement("p");
			email.setAttribute("id", "email");
			email.setAttribute("class", "d-inline");
			email.innerText = user["email"];
			userElement.append(email);
			
			var role = document.createElement("p");
			role.setAttribute("id", "role");
			role.setAttribute("class", "d-none");
			role.setAttribute("selectedRole", user["role"]);
			role.innerText = roles[user["role"]];
			userElement.append(role);
			
			var statusColumn = document.createElement("div");
			statusColumn.setAttribute("class", "float-right");
			var status;
			var datePicker = "";
			if(user["role"] == "INITIATOR") {
				userElement.classList.remove("user-element")
				if(globalFeatureAccess["approval"] == "RESEND") {
					// User is initiator and phase is in Initiator/Review&Resend
					// phase
					status = document.getElementById("review-resend-btn-template").cloneNode(true)
					status.setAttribute("id", "");
				} else {
					status = generateStatusObj(user);
					// User is initiator but phase is not
					// Initiator/Review&Resend phase
				}
			} else {
					if(user["email"] == userName) {
						// globalFeatureAccess approval start
						switch(globalFeatureAccess["approval"]) {
						case "FINAL":
							status = document.getElementById("status-change-btns-template").cloneNode(true)
							status.setAttribute("id", "");
							break;
						case "REVIEW":
							status = document.getElementById("status-change-btns-template").cloneNode(true)
							status.setAttribute("id", "");
							
							datePicker = generateActionDateObj(user);
							break;
						case "RESEND":
							status = generateStatusObj(user);
							break;
						case "FALSE":
							status = generateStatusObj(user);
							break;
						default :
							status = generateStatusObj(user);
							break;
						}
						// globalFeatureAccess approval end
					} else {
						status = generateStatusObj(user);
						}
				}
			
			datePicker = generateActionDateObj(user);
	        
	        
			
			statusColumn.append(status);
			userElement.append(statusColumn);
			userRow.append(userElement);
			userRow.append(datePicker);
			
			return userRow;
		}
		
		$("body").popover({
			container: 'body',
			selector: ".datepicker-popover",
			trigger: 'click',
			animation : true,
		    html: true,
		    sanitize: false,
		    template : '<div class="popover text-dark border-dark" style="max-width: 100%;" role="tooltip"><div class="arrow border-dark"></div><h3 class="popover-header">Popover Header</h3><div class="popover-body">Popover Body</div></div>'
		});
		
		$('body').on('click', function (e) {
		    $('.datepicker-popover').each(function () {
// console.log($(this));
// console.log(e.target);
		        // hide any open popovers when the anywhere else in the body is
				// clicked
		        if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
		            $(this).popover('hide');
		        }
		    });
		});
		
		
		$(document).on('focus',".approval-duedate-datepicker-wrapper", function(){
		    $(this).datepicker({
		    	format: "dd M, yyyy",
		    	startDate: $(this).attr("aria-startDate"),
		    	orientation: "bottom",
		    	todayHighlight: true,
		    	defaultViewDate: "today",
		    	todayBtn: true,
		    	weekStart: 1,
		    	immediateUpdates: true,
		    	datesDisabled: getDatesInBetween($(this).attr("aria-dueDate"), moment().utc().format("YYYY-MM-DD"))
		    	// title: "Hello"
		    });
		});
		
		$(document).on('focus',".notification-startdate-datepicker-wrapper", function(){
		    $(this).datepicker({
		    	format: "dd M, yyyy",
		    	//startDate: "today",
		    	orientation: "bottom",
		    	todayHighlight: true,
		    	defaultViewDate: "today",
		    	todayBtn: true,
		    	weekStart: 1,
		    	immediateUpdates: true
		    	// title: "Hello"
		    });
		});
		
		function closePopoverFromInside(obj) {
			$(obj).parents(".popover").popover('hide');
		}
		
		function getStartDate(dueDateStr) {
			var dateFormat = "YYYY-MM-DD";
			var currentDate = moment().utc().format(dateFormat);
			var dueDate = moment(dueDateStr, dateFormat).format(dateFormat);
			
			if(moment(currentDate).isAfter(dueDate)) {
				//console.log(moment(dueDate, dateFormat).format("DD MMM, YYYY"));
				return moment(dueDate, dateFormat).format("DD MMM, YYYY");
			} else {
				return "today";
			}
		}
		
		function generateDatePickerPopoverContent(user) {
			var popoverContent = document.getElementById("datepicker-popover-content-template").cloneNode(true);
			popoverContent.setAttribute("id", "datepicker-popover-content");
			popoverContent.querySelector("#set-approval-due-date-form").setAttribute("aria-person", user["email"]);
			popoverContent.querySelector("#approval-due-date").classList.add("approval-duedate-datepicker-wrapper");
			popoverContent.querySelector("#approval-due-date").setAttribute("value", getCurrentTimeZoneTime(user["approval_due_date"]));
			popoverContent.querySelector("#approval-due-date").setAttribute("aria-dueDate", user["approval_due_date"]);
			popoverContent.querySelector("#approval-due-date").setAttribute("aria-startDate", getStartDate(user["approval_due_date"]));
			
			// Change Ids
			popoverContent.querySelector("#approval-due-date-notification-switch-wrapper-template").setAttribute("id", "approval-due-date-notification-switch-wrapper");
			popoverContent.querySelector("#approval-due-date-notification-switch-template").setAttribute("id", "approval-due-date-notification-switch");
			popoverContent.querySelector("#approval-due-date-notification-switch-label-template").setAttribute("id", "approval-due-date-notification-switch-label");
			
			
			popoverContent.querySelector("#approval-due-date-notification-switch-wrapper").classList.add("custom-control","custom-switch");
			popoverContent.querySelector("#approval-due-date-notification-switch").classList.add("custom-control-input");
			popoverContent.querySelector("#approval-due-date-notification-switch-label").classList.add("custom-control-label");
			popoverContent.querySelector("#approval-due-date-notification-switch-label").setAttribute("for", "approval-due-date-notification-switch");
			
			if(user["approval_notification_config"]["notification_enable"] == true) {
				popoverContent.querySelector("#approval-due-date-notification-switch").setAttribute("checked", true);
			}
			
			
			popoverContent.querySelector("#approval-due-date-notification-start-date").classList.add("notification-startdate-datepicker-wrapper");
			popoverContent.querySelector("#approval-due-date-notification-start-date").setAttribute("value", getCurrentTimeZoneTime(user["approval_notification_config"]["notification_start_date"]));
			popoverContent.querySelector("#approval-due-date-notification-start-date").setAttribute("aria-value", user["approval_notification_config"]["notification_start_date"]);
			
			
			popoverContent.querySelector("#approval-due-date-notification-frequency-label-template").setAttribute("id", "approval-due-date-notification-frequency-label");
			popoverContent.querySelector("#approval-due-date-notification-frequency-label").setAttribute("for", "approval-due-date-notification-frequency");
			popoverContent.querySelector("#approval-due-date-notification-frequency-template").setAttribute("id", "approval-due-date-notification-frequency");
			popoverContent.querySelector("#approval-due-date-notification-frequency").classList.add("custom-select","custom-select-sm");
			popoverContent.querySelector('option[value="'+user["approval_notification_config"]["notification_frequency"]+'"]').setAttribute("selected", true);
			
			
			
			if(user["approval_notification_config"]["notification_enable"] == false) {
				popoverContent.querySelector("#notification-config-fieldset").setAttribute("disabled", true);
				popoverContent.querySelector("#notification-config-fieldset").classList.add("d-none");
			}
			
			return popoverContent.outerHTML;
		}
		
		function onSwitchToggle(obj) {
			var fieldSet = $(obj).parents(".set-approval-due-date-form").find("#notification-config-fieldset");
			if($(obj).prop("checked")) {
				fieldSet.attr("disabled", false);
				fieldSet.removeClass("d-none");
			} else {
				fieldSet.attr("disabled", true);
				fieldSet.addClass("d-none");
			}
		}
		
		function generateActionDateObj(user) {
			// console.log(user);
			var dateFormat = "YYYY-MM-DD HH:mm:ss";
			var currentDate = moment().utc().format(dateFormat);
			var dueDate = moment(user["approval_due_date"], dateFormat).format(dateFormat);
			var warningDate = moment(dueDate, dateFormat).subtract(2, 'days');
			
			// console.log(currentDate+" ---- "+dueDate)
			var datePicker = "";
			if(user["dou_approval"] == "PENDING") {
				if(userName == group["created_by"]) {
					// Initiator View
					// console.log("Initiator");
					if(moment(currentDate).isSameOrAfter(dueDate)) {
						// OverDue
						datePicker = document.getElementById("user-approval-overdue-date-wrapper-template-initiator-view").cloneNode(true);
					} else {
						// Not Due yet
						datePicker = document.getElementById("user-approval-date-wrapper-template-initiator-view").cloneNode(true);
						
						// Set Font Color
						if(moment(currentDate).isBetween(warningDate, dueDate, null, '[]')) {
							datePicker.classList.add("text-warning");
						} else {
							datePicker.classList.add("text-dark");
						}
					}
					datePicker.querySelector("#datepicker-popover-button").classList.add("datepicker-popover");
					datePicker.querySelector("#datepicker-popover-button").setAttribute("data-content",generateDatePickerPopoverContent(user));
				} else {
					if(user["email"] == userName) {
						// Approver View
						// console.log("Approver");
						if(moment(currentDate).isSameOrAfter(dueDate)) {
							// OverDue
							datePicker = document.getElementById("user-approval-overdue-date-wrapper-template-approver-view").cloneNode(true);
						} else {
							// Not Due yet
							datePicker = document.getElementById("user-approval-date-wrapper-template-approver-view").cloneNode(true);
							
							// Set Font Color
							if(moment(currentDate).isBetween(warningDate, dueDate, null, '[]')) {
								datePicker.classList.add("text-warning");
							} else {
								datePicker.classList.add("text-dark");
							}
						}
					} else {
						// Third Person View
						// console.log("TP");
						if(moment(currentDate).isSameOrAfter(dueDate)) {
							// OverDue
							datePicker = document.getElementById("user-approval-overdue-date-wrapper-template-third-person-view").cloneNode(true);
						} else {
							// Not Due yet
							datePicker = document.getElementById("user-approval-date-wrapper-template-third-person-view").cloneNode(true);
							
							// Set Font Color
							if(moment(currentDate).isBetween(warningDate, dueDate, null, '[]')) {
								datePicker.classList.add("text-warning");
							} else {
								datePicker.classList.add("text-dark");
							}
						}
					}
					
				}
		
				
				datePicker.querySelector("#user-approval-due-date").innerHTML = getCurrentTimeZoneTimeWithTime(user["approval_due_date"]);
				datePicker.setAttribute("id","");
			}
			
			return datePicker;
		}
		
		function generateStatusObj(user) {
			var status = document.getElementById("user-approval-status-"+user["dou_approval"].toLowerCase()+"-template").cloneNode(true);
			status.setAttribute("id", user["email"].replace(/\./g,"-")+"-"+user["dou_approval"]);
			if(user["dou_approval"] == "APPROVED" || user["dou_approval"] == "REJECTED") {
				var time = document.getElementById("approval-time").cloneNode(true);
				time.innerText = "On "+getCurrentTimeZoneTime(user["approval_time"]);
				status.append(document.createElement("br"));
				status.append(time);
			}
			return status;
		}
		
		function setApprovalDueDate(obj) {
			var formDiv = $(obj).parents(".set-approval-due-date-form");
			formDiv.find("#set-approval-due-date-form-submit-button-disabled").removeClass("d-none");
			formDiv.find("#set-approval-due-date-form-submit-button").addClass("d-none");
			
			/*
			 * email utc_offset approval_due_date approval_notification_config{
			 * notification_start_date notification_frequency
			 * notification_enable }
			 */
			
			// Convert to JSON
			var dueDateConfigJSON = {	"email":"", 
										"approval_due_date":"", 
										"utc_offset":"",
										"approval_notification_config":{
											"notification_start_date":"",
											"notification_frequency":"",
											"notification_enable":""
										}};
			dueDateConfigJSON["email"] = formDiv.attr("aria-person");
			dueDateConfigJSON["approval_due_date"] = formDiv.find("#approval-due-date").val();
			dueDateConfigJSON["utc_offset"] = moment().utcOffset();
			dueDateConfigJSON["approval_notification_config"]["notification_start_date"] = formDiv.find("#approval-due-date-notification-start-date").val();
			dueDateConfigJSON["approval_notification_config"]["notification_frequency"] = formDiv.find("#approval-due-date-notification-frequency").children("option:selected").val();
			dueDateConfigJSON["approval_notification_config"]["notification_enable"] = formDiv.find("#approval-due-date-notification-switch").prop("checked");
			console.log(dueDateConfigJSON)
			

			$.ajax({
				url : '/rest/dou/group/'+$("#dou").attr("groupId")+'/changeApprovalDueDateConfig',
				type : 'POST',
				data : JSON.stringify(dueDateConfigJSON),
				dataType: 'json',
	            contentType: 'application/json',
				success : function(returnData) {
					formDiv.find("#set-approval-due-date-form-submit-button-disabled").addClass("d-none");
					formDiv.find("#set-approval-due-date-form-submit-button").removeClass("d-none");
					if(returnData["code"] == "SUCCESS") {
						closePopoverFromInside(obj);
						alertSuccess(returnData["message"]);
						fetchDoUAccessList($("#dou").attr("groupId"));
						// fetchDoUGroup($("#dou").attr("groupId"));
					} else {
						alertDanger(returnData["message"]);
					}
				},
				error : function(returnData) {
					formDiv.find("#set-approval-due-date-form-submit-button-disabled").addClass("d-none");
					formDiv.find("#set-approval-due-date-form-submit-button").removeClass("d-none");
					alertDanger("Error Setting Due date, Please try again later!!");
				}
			});
		}
		
		function loadAccessTo(accessList) {
			var peopleList = $("#people-list");
			peopleList.empty();
			
			// Setting Initiator display start
			var roleHeader = document.createElement("li");
			roleHeader.setAttribute("class", "list-group-item list-group-item-dark font-weight-bold");
			roleHeader.innerText = "Initiator";
			peopleList.append(roleHeader);
			
			var user = {};
			user["email"] = group["created_by"]; // document.getElementById("created_by").innerText;
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
					var emptyRow = document.createElement("li");
					emptyRow.setAttribute("class", "list-group-item disabled text-center");
					emptyRow.innerText = "No "+roles[keys[i]];
					peopleList.append(emptyRow);
				}
			}
		}
		
		
		function collapseStatusButtons() {
			if ($("#status-change-btns").css("display") == "none") {
				$("#status-change-btns").css("display", "block");
			} else {
				$("#status-change-btns").css("display", "none");
			}
		}

		
		function downloadDoU() {
			window.location='/rest/dou/group/'+$("#dou").attr("groupId").trim()+'/dou';
		}
		
		
		function setApprovalBtn(obj) {
			$("#user-status-approval-status-change-button-disabled").removeClass("d-none");
			$("#user-status-approval-status-change-button").addClass("d-none");
			var status = $(obj).val().toString();
			
			var statusJSON = {"dou_approval":"", "comment":""};
			statusJSON["dou_approval"] = status.trim().toUpperCase();
			statusJSON["comment"] = $("#user-status-approval-comment").val().trim();
			
			$.ajax({
	            url: '/rest/dou/group/'+$("#dou").attr("groupId")+'/changeApprovalStatus',
	            type: 'post',
	            dataType: 'json',
	            contentType: 'application/json',
	            data: JSON.stringify(statusJSON),
	            success: function (returnData) {
	    			$("#user-status-approval-status-change-button-disabled").addClass("d-none");
	    			$("#user-status-approval-status-change-button").removeClass("d-none");
	            	console.log(returnData);
	            	console.log(returnData["code"]);
	            	if(returnData["code"] == "SUCCESS") {
	            		$("#user-status-approval-dou-modal").modal("hide");
	            		fetchDoUGroup($("#dou").attr("groupId"));
	            		alertSuccess(returnData["message"]);
	            		$("#user-status-approval-comment").val("");
	            	} 
	            	else {
	            		console.log(returnData["message"]);
	            		alertDanger(returnData["message"]);
	            	}
	            },
	            error: function (returnData) {
	    			$("#user-status-approval-status-change-button-disabled").addClass("d-none");
	    			$("#user-status-approval-status-change-button").removeClass("d-none");
	            	alertDanger("Status Change Failed, Please try again later!!");
	            }
	        });
		}
		
		function addComment() {
			var comment = $("#comment").val().trim();
			// console.log(comment);
			if (comment != "") {
				var commentJSON = {"comment":""};
				commentJSON["comment"] = comment;
				commentJSON["comment_by"] = userName;
				commentJSON["comment_time"] = new Date().toISOString();
				
				$("#no-comments-instruction").css("display", "none");
				$("#add-comment-instruction").text("");
				var card = generateCommentCard(commentJSON);
				card.attr("id", "temp-comment-card");
				card.css("opacity", ".4");
				$("#comments-list").prepend(card);
				
				$.ajax({
		            url: '/rest/dou/group/'+$("#dou").attr("groupId")+'/comment',
		            type: 'post',
		            dataType: 'json',
		            contentType: 'application/json',
		            data: JSON.stringify(commentJSON),
		            success: function (returnData) {
		            	// console.log(returnData);
		            	loadComments($("#dou").attr("groupId"));
		            	if(returnData["code"] == "SUCCESS") {
		            		// console.log(returnData["message"]);
		            		$("#comment").val("");
		            		$("#temp-comment-card").replaceWith(generateCommentCard(JSON.parse(returnData["message"])));
		            	} else {
							// alertDanger(returnData["message"]);
		            		$("#add-comment-instruction").text(returnData["message"]);
			            	$("#add-comment-instruction").css("color","red");
			            	$("#temp-comment-card").remove();
		            	}
		            		
		            },
		            error: function (returnData) {
		            	$("#add-comment-instruction").text("Adding Comment failed. Please try again later!!");
		            	$("#add-comment-instruction").css("color","red");
		            	$("#temp-comment-card").remove();
		            }
		        });
				
				
			} else {
				// If comment is empty
				$("#add-comment-instruction").text("Comment cannot be empty!!");
            	$("#add-comment-instruction").css("color","red");
			}
		
		}

		function searchDoUs() {
			$("#search-dou").on(
					"keyup",
					function() {
						var value = $(this).val().toLowerCase();
						$(".dropdown-item").filter(
								function() {
									$(this).toggle(
											$(this).text().toLowerCase()
													.indexOf(value) > -1)
								});
					});
		}

		function searchPeople() {
			$("#search-people").on(
					"keyup",
					function() {
						var value = $(this).val().toLowerCase();
						$(".badge").filter(
								function() {
									$(this).toggle(
											$(this).text().toLowerCase()
													.indexOf(value) > -1)
								});
					});
		}

		function setCollapseEvents() {
			$('#access-list').on('show.bs.collapse', function() {
				$("#access-list-card").addClass("w-100");
			})
			$('#access-list').on('hidden.bs.collapse', function() {
				$("#access-list-card").removeClass("w-100");
			})

		}
		
		function fetchDoUAccessList(groupId) {
			$.get("/rest/dou/group/" + groupId, function(data) {
				if(data["code"]){
					// There is error getting group data
					fetchDoUAccessList(groupId);
//					alertDanger(data["message"]);
//					window.location = "/DoUDetails.jsp";
					} else {
						group = data;
						fetchDoUPermissions(group["_id"]);
						loadAccessTo(group["access_to"]);
					}
			});
		}

		function loadDoUOnReady() {
			var ids = window.location.href.trim().split("?");
			if (ids.length > 1) {
				var idQuery = ids[1].split("=");
				if (idQuery[0].toLowerCase() == "id") {
					if (idQuery[1].length != 0) {
						fetchDoUGroup(idQuery[1]);
					}
				}
			}
		}
		
		function fetchDoUGroup(groupId) {
			$.get("/rest/dou/group/" + groupId, function(data) {loadDoUGroup(data);});
			$.blockUI({  message: "<h4>Loading...<h4>", css: { 
		        border: 'none', 
		        padding: '15px', 
		        backgroundColor: 'none', 
		        '-webkit-border-radius': '10px', 
		        '-moz-border-radius': '10px', 
		        opacity: 1, 
		        color: 'black'
		    } });
		}
		
		function fetchDoUPermissions(groupId) {
			$.ajax({
		        type: "GET",
		        url: "/rest/dou/group/" + groupId +"/permissions",
		        async: false,
		        success: function(globalFeatureAccessLocal) {
		        	globalFeatureAccess = globalFeatureAccessLocal;
		        }
		    });
		}
		
		function loadDoUGroup(data) {
			if (data != null) {
				// console.log(data);
				if(data["code"]){
					// There is error getting group data
					alertDanger(data["message"]);
					window.location = "/DoUDetails.jsp";
					} else {
						
					}
			} else {
				alertDanger("Group not found");
			}
			$.unblockUI();

		}
		
		function loadRevisionHistory(groupId) {
			$.ajax({
		        type: "GET",
		        url: "/rest/dou/" + groupId+"/revisionHistory",
		        async: true,
		        success: function(revisionHistory) {
		        	// console.log(revisionHistory);
		        	populateRevisionHistory(revisionHistory);
		        }
		    });
		}
		
		function populateRevisionHistory(revisionHistory) {
			// assuming no revision History present
			$("#no-revision-history-instruction").css("display", "block");
			$("#revision-history-list").css("display", "block");
			$("#revision-history-list").empty();
			if(revisionHistory != null) {
				if(revisionHistory.length > 0) {
					$("#no-revision-history-instruction").css("display", "none");
					for(var i = 0; i< revisionHistory.length; i++) {
						$("#revision-history-list").prepend(generateRevisionHistoryCard(revisionHistory[i]));
					}
				}
			}
		}
		
		function generateRevisionHistoryCard(event) {
			if(event != null) {
				var rHCard = $("#revision-history-event-template").clone();
				var time = getCurrentTimeZoneTimeWithTime(event["event_time"]);
				// console.log(time.substr(0,time.length-8)+" ---------- "+
				// time.substr(-8));
				rHCard.find("#date").text(time.substr(0,time.length-8));
				rHCard.find("#time").text(time.substr(-8));
				
				if(event["action"] == null)
					{
					rHCard.find("#event-icon").append(eventUtils[event["event_type"]]["glyphicon"]);
					rHCard.find("#event-icon").css("background-color", eventUtils[event["event_type"]]["color"]);
					rHCard.find("#revision-history-body-wrapper").css("border-color", eventUtils[event["event_type"]]["color"]);
					
					var content = eventUtils[event["event_type"]]["content"].replace(eventByVar, event["event_by"]);
					if(event["action_on"] != null) {
						var actionOn = event["action_on"].toString();
						content = content.replace(eventActionOnVar, actionOn);
					}
					
					if(event["to_user_role"] != null) {
						if(event["to_user_role"] == "DOU_INITIATOR") {
							content = content.replace(eventNextUserRoleVar, "Initiator")+'reviewing.';
						} else{
						content = content.replace(eventNextUserRoleVar, roles[event["to_user_role"]])+'approval.';
						}
					}
					
					
					rHCard.find("#revision-history-body").html(content);
					
					
					}
				else {
					rHCard.find("#event-icon").append(eventUtils[event["event_type"]][event["action"]]["glyphicon"]);
					rHCard.find("#event-icon").css("background-color", eventUtils[event["event_type"]][event["action"]]["color"]);
					rHCard.find("#revision-history-body-wrapper").css("border-color", eventUtils[event["event_type"]][event["action"]]["color"]);
					
					
					var content = eventUtils[event["event_type"]][event["action"]]["content"].replace(eventByVar, event["event_by"]);
					if(event["action_on"] != null) {
						var actionOn = event["action_on"].toString();
						content = content.replace(eventActionOnVar, actionOn);
					}
					
					
					rHCard.find("#revision-history-body").html(content);
				}
				rHCard.attr("id",event["event_id"]);
				return rHCard;
			}
		}
		
		function populateComments(comments) {
			// assuming no comments present
			$("#no-comments-instruction").css("display", "block");
			$("#comments-list").css("display", "block");
			$("#comments-list").empty();
			if(comments != null) {
				if(comments.length > 0) {
					$("#no-comments-instruction").css("display", "none");
					for(var i = 0; i< comments.length; i++) {
						$("#comments-list").prepend(generateCommentCard(comments[i]));
					}
				}
			}
		}
		
		
		function loadComments(groupId) {
			$.ajax({
		        type: "GET",
		        url: "/rest/dou/group/" + groupId+"/comments",
		        async: true,
		        success: function(comments) {
		        	populateComments(comments);
		        }
		    });
		}
		
		
		function generateCommentCard(comment) {
			var card = $("#comment-div-template").clone();
			var name = comment["comment_by"].split("@")[0];
			var time = getCurrentTimeZoneTimeWithTime(comment["comment_time"]);
			card.find("#comment-author-div strong").text("@"+name);
			card.find("#comment-body-div").text(comment["comment"]);
			card.find("#comment-time-div").text(time);
			
			if(comment["comment_by"] == userName) {
				card.addClass("float-right bg-light");
				card.find("#comment-author-div").addClass("pr-2 text-right");
			}
			else {
				card.find("#comment-author-div").addClass("pl-2");
			}
			
			card.attr("id","comment-card");
			return card;
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
			var searchResult = jQuery(obj).siblings("#dou-access-to-search-result");
// console.log(searchResult);
			if (email == "") {
				searchResult.empty();
				searchResult.append(
						"<a class='dropdown-item'>Enter emailId to search</a>");

			} else {
				$
						.ajax({
							url : 'https://bluepages.ibm.com/BpHttpApisv3/wsapi?byInternetAddr='
									+ email,
							type : 'GET',
							async : true,
							cache : false,
							contentType : false,
							processData : false,
							success : function(returnData) {
								if (returnData.charAt(0) != '#') {
									searchResult.empty();
									var dropDownElem = searchResult.siblings("#dropdown-item").clone();
									dropDownElem.text(email);
									dropDownElem.css("display","block");
									searchResult.append(dropDownElem);
								} else {
									searchResult.empty();
									searchResult.append(
													"<a class='dropdown-item'>No Match Found</a>");
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
				user = {"email":email, "role":""};
				$("#access-to-email-badges").append(generateUserElement(user));
				$("#edit-access-to-search").val("");
				$('#edit-access-to-search').keyup();
			}
		}
		
		function addDelegateAccessToVal(obj) {
			var peopleList = $("#delegate-access-to-email-badges span");
			var email = obj.innerHTML.trim();
// console.log(email);
			var emailPresent = false; 
			for(var i=0; i<peopleList.length; i++) {
				if(jQuery(peopleList[i]).find("#email").text().trim() == email) {
					emailPresent = true;
					break;
				}
			}
			
			if(!emailPresent) {
				user = {"email":email, "role":userRole};
				$("#delegate-access-to-email-badges").append(userbadgeElement(user));
				$("#delegate-user-access-to-search").val("");
				$('#delegate-user-access-to-search').keyup();
			}
		}
		
		function addAddReviewerToVal(obj) {
			var peopleList = $("#add-reviewer-to-email-badges span");
			var email = obj.innerHTML.trim();
			var emailPresent = false; 
			for(var i=0; i<peopleList.length; i++) {
				if(jQuery(peopleList[i]).find("#email").text().trim() == email) {
					emailPresent = true;
					break;
				}
			}
			
			if(!emailPresent) {
				user = {"email":email, "role":"PRODUCT_TEAM_DOU_REVIEWER"};
				$("#add-reviewer-to-email-badges").append(userbadgeElement(user));
				$("#add-reviewer-access-to-search").val("");
				$('#add-reviewer-access-to-search').keyup();
			}
		}
		
		function removeAccessToEmail(obj) {
			var spanElem = jQuery(obj);
			spanElem.parents('.user-wrapper').remove();
			}
		
		function removeUserBadge(obj) {
			var spanElem = jQuery(obj);
			spanElem.parents('.userbadge-wrapper').remove();
		}
		
		function populateEditAccessForm() {
			$("#edit-access-dou-name").text($("#dou_name").text());
			replaceClass("#edit-access-dou-name", "text-" + previousColor, "text-" + currentColor);
			$("#access-to-email-badges").empty();
			$("#access-submit-instruction").text("");
			
			var peopleList = $(".user-element");
			for(var i=0;i<peopleList.length;i++) {
				user = {"email":jQuery(peopleList[i]).find("#email").text().trim(), "role": jQuery(peopleList[i]).find("#role").attr("selectedRole").trim() }
				$("#access-to-email-badges")
				.append(generateUserElement(user));
			}
		}
		
		function populateDelegateAccessForm() {
			$("#delegate-access-dou-name").text($("#dou_name").text());
			replaceClass("#delegate-access-dou-name", "text-" + previousColor, "text-" + currentColor);
			$("#delegate-access-to-email-badges").empty();
			$("#delegate-access-submit-instruction").text("");
		}
		
		function populateAddReviewerAccessForm() {
			$("#add-reviewer-dou-name").text($("#dou_name").text());
			replaceClass("#add-reviewer-dou-name", "text-" + previousColor, "text-" + currentColor);
			$("#add-reviewer-to-email-badges").empty();
			$("#add-reviewer-submit-instruction").text("");
		}
		
		function userbadgeElement(user) {
			var card = $("#userbadge-template").clone();
			card.find("#email").text(user.email);
			card.find("#role").text(roles[user.role]);
			card.find("#role").attr("selectedRole",user.role);
			card.attr('id',"userbadge-"+user.email.replace(/\./g,"-").replace(/@/g,"-"));
// console.log(card.attr("id"));
			
			return card;
		}
		
		function generateUserElement(user) {
			var card = $("#template-user-wrapper").clone();
			card.find("#email").text(user.email);
			card.attr('id',"userbadge-"+user.email.replace(/\./g,"-").replace(/@/g,"-"));
			var parentRoleElementTemplate = card.find("#template-user-role").parent();
			var roleElementTemplate = jQuery(card.find("#template-user-role"));
			var keys = Object.keys(roles);
			for(var i=0;i<keys.length;i++) {
				var roleElement = roleElementTemplate.clone();
				roleElement.text(roles[keys[i]]);
				roleElement.attr("dropdownVal", keys[i]);
				roleElement.attr("id", "");
				parentRoleElementTemplate.append(roleElement);
				if(user.role == keys[i])
					{
					setUserRole(roleElement)
					}
			}
			roleElementTemplate.remove();
			
			return card;
		}
		
		function setUserRole(obj) {
			var roleElem = jQuery(obj);
			roleElem.parents('.user-wrapper').find('#role').text(roleElem.text());
			roleElem.parents('.user-wrapper').find('#role').attr("selectedRole", roleElem.attr("dropdownVal"));
		}
		
		
		function populateDoUFileForm() {
			$("#update-doufile-modal-title").text("Upload DoU File");
			$("#update-doufile-dou-name").text($("#dou_name").text());
			replaceClass("#update-doufile-dou-name", "text-" + previousColor, "text-" + currentColor);
			
			$("#update-doufile-submit-button").text("Update DoU")
			$("#update-doufile-comment").val("");
		}
		
		function populateDoUFileFormReviewResend() {
			$("#review-resend-doufile-dou-name").text($("#dou_name").text());
			replaceClass("#review-resend-doufile-dou-name", "text-" + previousColor, "text-" + currentColor);
			
			$("#review-resend-comment").val("");
		}
		
		function populateDoUFormReinitiate() {
			$("#reinitiate-dou-name").text($("#dou_name").text());
			replaceClass("#reinitiate-dou-name", "text-" + previousColor, "text-" + currentColor);
			
			$("#reinitiate-dou-comment").val("");
		}
		
		function populateDoUFormCancel() {
			$("#cancel-dou-name").text($("#dou_name").text());
			replaceClass("#cancel-dou-name", "text-" + previousColor, "text-" + currentColor);
		}
		
		function setUserApprovalStatusModal(obj) {
			var value = $(obj).val().toString();
			var status = $(obj).attr("dou-status").toString();
			
			if(status == "reject") {
				replaceClass("#user-status-approval-dou-modal-title", "text-success", "text-danger");
			} else {
				replaceClass("#user-status-approval-dou-modal-title", "text-danger", "text-success");
			}
			
			$("#user-status-approval-dou-modal-title").text(status+" DoU");
			$("#user-status-approval-status").html("&nbsp;"+status+"&nbsp;");
			$("#user-status-approval-dou-name").text($("#dou_name").text());
			$("#user-status-approval-status-change-button").val(value);
			$("#user-status-approval-status-change-button-disabled-value").text(status+"DoU ...");
			$("#user-status-approval-status-change-button").text($(obj).text()+" DoU");
			$("#user-status-approval-status-change-button").attr("class",($(obj).attr("class")));
			// replaceClass("#user-status-approval-status-change-button",
			// removeClass, addClass)
		}
		
		function cancelDoU(obj) {
			$("#cancel-dou-button-disabled").removeClass("d-none");
			$("#cancel-dou-button").addClass("d-none");
			
			var cancelJSON = {"comment":""};
			cancelJSON["comment"] = $("#cancel-dou-comment").val().trim();
			
			$.ajax({
				url : '/rest/dou/group/'+$("#dou").attr("groupId")+'/cancel',
				type : 'POST',
				async : true,
				cache : false,
				dataType: 'json',
	            contentType: 'application/json',
	            data: JSON.stringify(cancelJSON),
	            processData : false,
				success : function(returnData) {
					$("#cancel-dou-button-disabled").addClass("d-none");
					$("#cancel-dou-button").removeClass("d-none");
					if(returnData["code"] == "SUCCESS") {
						$("#cancel-dou-modal").modal('hide');
						alertSuccess(returnData["message"]);
						fetchDoUGroup($("#dou").attr("groupId"));
					} else {
						alertDanger(returnData["message"]);
					}
				},
				error : function(returnData) {
					$("#cancel-dou-button-disabled").addClass("d-none");
					$("#cancel-dou-button").removeClass("d-none");
					alertDanger("Error Re-Initiating DoU, Please try again later!!");
				}
			});
		}
		
		// Program a custom submit function for the Re-Initiate access form
		$("#reinitiate-dou-form").submit(function(event) { {
			// disable the default form submission
			$("#reinitiate-dou-button-disabled").removeClass("d-none");
			$("#reinitiate-dou-button").addClass("d-none");
			event.preventDefault();
			
			// grab all form data
			var formData = new FormData($(this)[0]);
			
			$.ajax({
				url : '/rest/dou/group/'+$("#dou").attr("groupId")+'/reinitiate',
				type : 'POST',
				data : formData,
				enctype :'multipart/form-data',
				async : true,
				cache : false,
				contentType : false,
				processData : false,
				success : function(returnData) {
					$("#reinitiate-dou-button-disabled").addClass("d-none");
					$("#reinitiate-dou-button").removeClass("d-none");
					if(returnData["code"] == "SUCCESS") {
						$("#reinitiate-dou-modal").modal("hide");
						alertSuccess(returnData["message"]);
						fetchDoUGroup($("#dou").attr("groupId"));
						$("#reinitiate-dou-modal input").val("");
						$(".custom-file-label").html("Choose DoU");
					} else {
						alertDanger(returnData["message"]);
					}
				},
				error : function(returnData) {
					$("#reinitiate-dou-button-disabled").addClass("d-none");
					$("#reinitiate-dou-button").removeClass("d-none");
					alertDanger("Error Re-Initiating DoU, Please try again later!!");
				}
			});
		}
		});
		
		$("#review-resend-doufile-dou-form").submit(function(event) { {
			$("#review-resend-doufile-submit-button-disabled").removeClass("d-none");
			$("#review-resend-doufile-submit-button").addClass("d-none");
			
			// disable the default form submission
			event.preventDefault();
			// grab all form data
			var formData = new FormData($(this)[0]);

			$.ajax({
				url : '/rest/dou/group/'+$("#dou").attr("groupId")+'/resend',
				type : 'POST',
				data : formData,
				enctype :'multipart/form-data',
				async : true,
				cache : false,
				contentType : false,
				processData : false,
				success : function(returnData) {
					$("#review-resend-doufile-submit-button-disabled").addClass("d-none");
					$("#review-resend-doufile-submit-button").removeClass("d-none");
					if(returnData["code"] == "SUCCESS") {
						$("#review-resend-doufile-modal").modal("hide");
						alertSuccess(returnData["message"]);
						fetchDoUGroup($("#dou").attr("groupId"));
						$("#review-resend-doufile-modal input").val("");
						$(".custom-file-label").html("Choose DoU");
					} else {
						alertDanger(returnData["message"]);
					}
				},
				error : function(returnData) {
					$("#review-resend-doufile-submit-button-disabled").addClass("d-none");
					$("#review-resend-doufile-submit-button").removeClass("d-none");
					alertDanger("Error Resending DoU, Please try again later!!");
				}
			});
		}
		});
		
		