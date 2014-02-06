# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	
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
		
	$('#cancel_button').click (event) ->
		show_profile()
		
	$('#nav_my_profile').click (event) ->
		show_profile()
		
	$('#nav_my_friends').click (event) ->
		show_my_friends()
		
	$('#nav_settings').click (event) ->
		show_settings()
		
	console.log("here")
	if (readCookie("profileTab") == "myProfile")
		show_profile()
		console.log("here2")
	else if (readCookie("profileTab") == "myFriends")
		show_my_friends()
		console.log("here3")
	else if (readCookie("profileTab") == "settings")
		show_settings()
		console.log("here4")
	
	
	
	
	