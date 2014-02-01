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
		hide_focused()
		$('.show_profile').addClass('has_focus')
		$('.show_profile').show(200, 'swing')
		event.preventDefault()
		
	$('#cancel_button').click (event) ->
		show_profile()
		
	$('#nav_my_profile').click (event) ->
		show_profile()
		$('.nav_top_title').text("My Profile")
		
	$('#nav_my_friends').click (event) ->
		hide_focused()
		$('.my_friends').addClass('has_focus')
		$('.my_friends').show(200, 'swing')
		$('.nav_top_title').text("My Friends")
		event.preventDefault()
		
	$('#nav_settings').click (event) ->
		hide_focused()
		$('.settings').addClass('has_focus')
		$('.settings').show(200, 'swing')
		$('.nav_top_title').text("Settings")
		event.preventDefault()