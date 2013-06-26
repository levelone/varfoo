jQuery ->
  spinner_options =
    lines: 7, # The number of lines to draw
    length: 0, # The length of each line
    width: 5, # The line thickness
    radius: 5, # The radius of the inner circle
    corners: 1, # Corner roundness (0..1)
    rotate: 56, # The rotation offset
    direction: 1, # 1: clockwise, -1: counterclockwise
    color: '#000', # #rgb or #rrggbb
    speed: 0.6, # Rounds per second
    trail: 34, # Afterglow percentage
    shadow: false, # Whether to render a shadow
    hwaccel: false, # Whether to use hardware acceleration
    className: 'spinner', # The CSS class to assign to the spinner
    zIndex: 2e9, # The z-index (defaults to 2000000000)
    top: 0, # Top position relative to parent in px
    left: 'auto' # Left position relative to parent in px

  $('form.new-comment').on 'ajax:success', (e, data, status, xhr) ->
    html = ''
    html += '<li class="comment clearfix new">\n'
    html += "<span>#{data.comment.user.name}: </span>#{data.comment.content}\n"
    html += '</li>\n' 

    $(this).parent('.comments-wrapper').siblings('.comments').prepend(html)
    
    $('.new').fadeIn().removeClass('new').animate({ backgroundColor: 'yellow' }, 'slow').animate({ backgroundColor: 'default'  }, 'slow')
    e.preventDefault()

  $('.comments-wrapper').siblings('.more-comments').click (e) ->
    parent_container = $(this)

    # Hide the comment button, show the loading spinner
    parent_container.css('display', 'none')
    $('.loading').css('display', 'block')
    $('.loading').spin(spinner_options)   

    article_id = $(e.target).attr('data-article-id')
    offset = $(e.target).attr('data-offset')

    # Get comments based on offset
    $.get "articles/#{article_id}/comments.json?offset=#{offset}", (data) ->
      html = ''

      for comment in data.comments 
        do ->
          html += '<li class="comment clearfix old">\n'
          html += "<span>#{comment.user.name}: </span>#{comment.content}\n"
          html += '</li>\n'


      parent_container.parent('.right-side').find('.comments').append(html)
      $('.old').fadeIn().removeClass('old').animate({ backgroundColor: 'yellow' }, 'slow').animate({ backgroundColor: '#fff' }, 'fast')

      # Show the comment button, hide the loading spinner
      parent_container.css('display', 'block')
      $('.loading').css('display', 'none')

      # Hide the more comments button, if no more comments to load
      if parseInt(parent_container.attr('data-offset')) > parseInt(parent_container.attr('data-comments-count'))
        parent_container.css('display', 'none')
      
    parent_container.attr('data-offset', parseInt(parent_container.attr('data-offset')) + 5)

    e.preventDefault()

  # $('.loading').spin(spinner_options)