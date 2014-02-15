# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	
	$(".username_field").focus()
	
	$('#edit_profile_button').click (event) ->
		hide_focused()
		$('.edit_profile').addClass('has_focus')
		$('.edit_profile').show(200, 'swing')
		event.preventDefault()
		
	$('#change_password_button').click (event) ->
		$('.password_fields').toggle(200, 'swing')
		event.preventDefault()
		
	hide_focused = () ->
		$('.has_focus').hide(200, 'swing')
		$('.has_focus').removeClass('has_focus')
		
	show_profile = () ->
		createCookie("profileTab", "myProfile", 1)
		hide_focused()
		$('.show_profile').addClass('has_focus')
		$('.show_profile').show(200, 'swing')
		$('.nav_top_title').text("My Profile")
		event.preventDefault()
	
	show_my_friends = () ->
		createCookie("profileTab", "myFriends", 1)
		hide_focused()
		$('.my_friends').addClass('has_focus')
		$('.my_friends').show(200, 'swing')
		$('.nav_top_title').text("My Friends")
		event.preventDefault()
		
	show_settings = () ->
		createCookie("profileTab", "settings", 1)
		hide_focused()
		$('.settings').addClass('has_focus')
		$('.settings').show(200, 'swing')
		$('.nav_top_title').text("Settings")
		event.preventDefault()
		
	show_my_badges = () ->
		createCookie("profileTab", "my_badges", 1)
		hide_focused()
		$('.my_badges').addClass('has_focus')
		$('.my_badges').show(200, 'swing')
		$('.nav_top_title').text("My Badges")
		event.preventDefault()
		
	$('#cancel_button').click (event) ->
		show_profile()
		
	$('#nav_my_profile').click (event) ->
		show_profile()
		
	$('#nav_my_friends').click (event) ->
		show_my_friends()
		
	$('#nav_my_badges').click (event) ->
		show_my_badges()
		
	$('#nav_settings').click (event) ->
		show_settings()
		
	if (readCookie("profileTab") == "myProfile")
		show_profile()
	else if (readCookie("profileTab") == "myFriends")
		show_my_friends()
	else if (readCookie("profileTab") == "my_badges")
		show_my_badges()
	else if (readCookie("profileTab") == "settings")
		show_settings()
	else
		show_profile()
	
	
	
	
	