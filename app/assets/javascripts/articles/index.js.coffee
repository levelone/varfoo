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

  $(document).on 'ajax:success', 'form.new-comment', (e, data, status, xhr) ->
    console.log 'clicked'
    html = ''

    if !$(this).parent('.comments-wrapper').siblings('.comments').length
      html += '<ul>'

    html += '<li class="comment clearfix new">\n'
    html += "<span>#{data.comment.user.name}</span> says:<br/>#{data.comment.content}\n"
    html += '</li>\n' 

    if !$(this).parent('.comments-wrapper').siblings('.comments').length
      html += '</ul>'
    
    $(this).parent('.comments-wrapper').siblings('.comments').prepend(html)
    
    $('.new').fadeIn().removeClass('new').animate({ backgroundColor: 'yellow' }, 'slow').animate({ backgroundColor: 'default'  }, 'slow')
    e.preventDefault()

  $(document).on 'click', '.more-comments', (e) ->
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
          html += "<span>#{comment.user.name}</span> says:<br />#{comment.content}\n"
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

  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  if $('#wrapper').length
    $(window).data('scroll_ready', true)
    all_articles_fetched = false
    page = $('#wrapper').data('article-page')    
    
    if $(window).data('scroll_ready', true)
      $(window).data('scroll_ready', false)


      tag = document.createElement('script')
      tag.src = "//www.youtube.com/iframe_api"
      firstScriptTag = document.getElementsByTagName('script')[0]
      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag)

      $(window).scroll (e) ->
        if ($(window).scrollTop() >= $(document).height() - $(window).height()) 
          $('#wrapper').data('article-page', $('#wrapper').data('article-page') + 1)
          
          if !all_articles_fetched
            $.get "articles?page=" + $('#wrapper').data('article-page'), (data) ->
              if data.articles.length <= 0
                all_articles_fetched = true
              else
                if data.articles.length || !all_articles_fetched 
                  for article in data.articles
                    do ->

                      html = ''
                      html += "<div class='article clearfix even'>"
                      html += "<div class='page'>"
                      html += "<h1 class='title'>"

                      # $.get "sessions/#{user.id}", (data) ->
                      #   if user.id present
                      #     console.log data.length
                      html += "<a class='#{article.id}-#{article.title}' href='/articles/#{article.id}'>#{article.title}</a>"

                      html += "</h1>\n"
                      html += "<p class='author'>#{article.created_at} &middot "

                      for tag in article.tags 
                        do ->
                          html += "#{tag.name} &middot "

                      html += "<span>#{article.comments.length} Comments</span>"
                      html += "<div class='left-side clearfix'>"
                      html += "<p class='description'>"

                      for image in article.images
                        do ->
                          html += "<img src='#{image.image_url.url}' />"


                      for video in article.videos
                        do ->
                          html += "#{video.video_url}"
                      

                      html += "#{article.content}"
                      html += "</p>"
                      html += "</div>"
                      html += "<div class='right-side clearfix'>"
                      html += "<div class='comments-wrapper'>"
                      html += "<form class='new-comment' method='post' data-type='json' data-remote='true' action='/articles/#{article.id}/comments' accept-charset='UTF-8'>"
                      html += "<div style='margin:0; padding:0; display:inline;'>
                               <input type='hidden' value='✓' name='utf8' name='authenticity_token'>
                               <input type='hidden' value='IOAjsyjgp9Uql2VnhCqy64SY34pl79Tg8Pb0ctuFr/U=' name='authenticity_token'>
                               </div>"

                      html += "<div class='field'>
                               <textarea id='test' type='text' rows='20' placeholder='What is on your mind?' name='comment[content]' cols='40'></textarea>
                               </div>"
                      html += "<div class='submit'>
                               <input class='btn btn-success' type='submit' value='Submit' name='commit'>
                               </div>"
                      html += "<input id='redirect_to' type='hidden' value='homepage' name='redirect_to'>"
                      html += "</div>"


                      $.get "articles/#{article.id}/comments", (data) ->
                        if data.comments.length
                          html += "<ul class='comments'>\n"

                        # if article.comments.length > 5
                          #write count code here...

                        for comment in data.comments
                          do ->
                            html += "<li class='comment'>\n"
                            html += "<span>#{comment.user.name}</span> says:<br/>#{comment.content}\n"
                            html += "</li>\n"

                        if data.comments.length
                          html += "</ul>\n"

                        html += "<a class='more-comments' loading='target' data-offset='5' data-comments-count='#{article.comments.length}'
                                 data-article-id='#{article.id}' href='#'>more</a>"
                        html += "<div class='loading'></div>"
                      
                        html += "</div>"
                        html += "</div>"
                        html += "</div>"
                        html += "\n"

                        $('#wrapper').append(html)

                    # determins if it should grab new results
                    $(window).data('scroll_ready', true)