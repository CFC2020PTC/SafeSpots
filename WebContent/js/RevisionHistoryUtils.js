var eventByVar = "$$__EVENT_BY_VAR__$$";
var eventActionVar = "$$__EVENT_ACTION_VAR__$$";
var eventActionOnVar = "$$__EVENT_ACTION_ON_VAR__$$";
var eventNextUserRoleVar = "$$__EVENT_NEXT_USER_ROLE_VAR__$$";

var eventUtils = {
	"MOD_DOU" : {
		"INITIATE" : {
			"color":"#4e73df",
			"glyphicon":'<i class="fas fa-file-contract"></i>',
			"content": '<b>'+eventByVar+'</b> have <b class="text-primary text-uppercase">INITIATED</b> the DoU.'
		},
		"RE_INITIATE" : {
			"color":"#4e73df",
			"glyphicon":'<i class="fas fa-redo"></i>',
			"content": '<b>'+eventByVar+'</b> have <b class="text-uppercase" style="color: #4e73df;">RE-INITIATED</b> the DoU.'
		},
		"UPDATE" : {
			"color":"#cc6600",
			"glyphicon":'<i class="fas fa-file-contract"></i><sup><i class="fas fa-arrow-circle-up"></i></sup>',
			"content": '<b>'+eventByVar+'</b> have <b class="text-uppercase" style="color: #cc6600;">UPDATED</b> the DoU.'
		},
		"CANCEL" : {
			"color":"#e74a3b",
			"glyphicon":'<i class="fas fa-file-contract"></i><sup><i class="fas fa-ban"></i></sup>', // far fa-times-circle
			"content": '<b>'+eventByVar+'</b> have <b class="text-uppercase" style="color: #e74a3b;">CANCELED</b> the DoU.'
		},
		"APPROVE" : {
			"color":"#1cc88a",
			"glyphicon":'<i class="fas fa-handshake"></i>', //far fa-check-circle
			"content": 'The DoU is <b class="text-uppercase" style="color: #1cc88a;">APPROVED</b>.'
		}
	},
	"MOD_ACCESS" : {
		"ADD_REVIEWER" : {
			"color":"#6c757d",
			"glyphicon":'<i class="fas fa-user-plus"></i>',
			"content": '<b>'+eventByVar+'</b> <b class="text-uppercase" style="color: #6c757d;">ADDED</b> <b>'+eventActionOnVar+'</b> as Product Reviewer.' 
		},
		"DELEGATE" : {
			"color":"#6c757d",
			"glyphicon":'<small><i class="fas fa-user-slash"></i><i class="fas fa-chevron-right"></i><i class="fas fa-user"></i></small>', //far fa-hand-point-right, fas fa-sign-out-alt, fas fa-users-cog
			"content": '<b>'+eventByVar+'</b> <b class="text-uppercase" style="color: #6c757d;">DELEGATED</b> the DoU to <b>'+eventActionOnVar+'</b>.'
		}
	},
	"MOD_DOU_APPROVAL" : {
		"APPROVE" : {
			"color":"#1cc88a",
			"glyphicon":'<i class="fas fa-check-circle"></i>', // fas fa-check, far fa-thumbs-up
			"content": '<b>'+eventByVar+'</b> have <b class="text-uppercase" style="color: #1cc88a;">APPROVED</b> the DoU.'
		},
		"REJECT" : {
			"color":"#e74a3b",
			"glyphicon":'<i class="fas fa-times-circle"></i>', //fas fa-times, far fa-thumbs-down
			"content": '<b>'+eventByVar+'</b> have <b class="text-uppercase" style="color: #e74a3b;">REJECTED</b> the DoU.'
		},
		"REVIEW_RESEND" : {
			"color":"#007bff",
			"glyphicon":'<i class="fas fa-retweet"></i>',
			"content": '<b>'+eventByVar+'</b> have <b class="text-uppercase" style="color: #007bff;">REVIEWED & RESENT</b> the DoU.'
		}
	},
	"MOD_PHASE" : {
		"color":"#36b9cc",
		"glyphicon":'<i class="fas fa-file-export"></i>',
		"content": 'The DoU has moved to <b>'+eventNextUserRoleVar+'s</b> for '
	},
	"MOD_ATTACHMENTS" : {
		"ADD" : {
			"color":"#1cc88a",
			"glyphicon":'<i class="fas fa-paperclip"></i>',
			"content": '<b>'+eventByVar+'</b> <b class="text-uppercase" style="color: #1cc88a;">ADDED</b> these attachments : <b>'+eventActionOnVar+'</b>'
		},
		"REMOVE" : {
			"color":"#e74a3b",
			"glyphicon":'<i class="far fa-trash-alt"></i>',
			"content": '<b>'+eventByVar+'</b> <b class="text-uppercase" style="color: #e74a3b;">REMOVED</b> these attachments : <b>'+eventActionOnVar+'</b>'
		},
		"UPDATE" : {
			"color":"#cc6600",
			"glyphicon":'<i class="fas fa-paperclip"></i><sub><i class="fas fa-arrow-circle-up"></i></sub>',
			"content": '<b>'+eventByVar+'</b> <b class="text-uppercase" style="color: #cc6600;">UPDATED</b> these attachments : <b>'+eventActionOnVar+'</b>'
		}
	}
};