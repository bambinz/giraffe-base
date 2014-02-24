# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	
	hide_visible = () ->
		$('.leaderboard_visible').hide(200, 'swing')
		$('.leaderboard_visible').removeClass('leaderboard_visible')
	
	$('.leaderboard_all_link').click (event) ->
		hide_visible()
		$('.leaderboard_all').show(200, 'swing')
		$('.leaderboard_all').addClass('leaderboard_visible')
		event.preventDefault()
		
	$('.leaderboard_friends_link').click (event) ->
		hide_visible()
		$('.leaderboard_friends').show(200, 'swing')
		$('.leaderboard_friends').addClass('leaderboard_visible')
		event.preventDefault()
			
	$('.leaderboard_companions_link').click (event) ->
		hide_visible()
		$('.leaderboard_companions').show(200, 'swing')
		$('.leaderboard_companions').addClass('leaderboard_visible')
		event.preventDefault()
		
		
	