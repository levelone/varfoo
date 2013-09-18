$(document).on 'mouseenter', '.navlink1', (e) ->
  $('.subnavlink1').css("display","block")
  # $('.subnavlink1').fadeIn().animate({ backgroundColor: 'grey' }, 'fast')

$(document).on 'mouseleave', '.alignment', (e) ->
  $('.subnavlink1').css("display","none")
  # $('.subnavlink1').fadeOut().animate({ backgroundColor: 'transparent' }, 'fast')

$(document).on 'mouseenter', '.navlink2', (e) ->
  $('.subnavlink2').css("display","block")

$(document).on 'mouseleave', '.alignment', (e) ->
  $('.subnavlink2').css("display","none")

$(document).on 'mouseenter', '.navlink3', (e) ->
  $('.subnavlink3').css("display","block")

$(document).on 'mouseleave', '.alignment', (e) ->
  $('.subnavlink3').css("display","none")
