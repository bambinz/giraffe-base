# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$('.notifications-button').click (e) ->
		$('.notifications-button').removeClass("notifications-button-active")
		if($(this).next(".notifications-popup").is(":visible"))
			$(this).next(".notifications-popup").hide(200, 'swing')
			$(this).removeClass("notifications-button-active")
		else
			$(".notifications-popup").hide(200, 'swing')
			$(this).next(".notifications-popup").css({top:e.pageY-45})
			$(this).next(".notifications-popup").show(200, 'swing')
			$(this).addClass("notifications-button-active")
	
	$(document).mouseup (e) ->
		popup = $(".notifications-popup")
		notifications_window = $(".notifications-outer-window")
		notifications_link = $('#notifications_link')
		
		if(popup.is(":visible"))
			if (!popup.is(e.target) && popup.has(e.target).length == 0 && !notifications_window.is(e.target) && notifications_window.has(e.target).length == 0)
				popup.hide(200, 'swing')
				$('.notifications-button').removeClass("notifications-button-active")
		else if(notifications_window.is(":visible"))
			if (!notifications_window.is(e.target) && notifications_window.has(e.target).length == 0 && !notifications_link.is(e.target))
				notifications_window.hide(200, 'swing')
				$('.notifications-button').removeClass("notifications-button-active")
	
	$('#notifications_link').click ->
		$('.notifications-outer-window').toggle(200, 'swing')