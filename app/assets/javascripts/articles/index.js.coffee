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

  # Post Comment after submission
  $(document).on 'ajax:success', 'form.new-comment', (e, data, status, xhr) ->
    console.log 'clicked'
    html = ''
    html += "<li class='comment clearfix new'>\n"
    html += "<span>#{data.comment.name}</span>,<br/><br/>#{data.comment.content}\n"
    html += "</li>\n" 
    
    $(this).parent('.comments-wrapper').siblings('.comments').prepend(html)
    
    $('.new').fadeIn().removeClass('new').animate({ backgroundColor: 'yellow' }, 'slow').animate({ backgroundColor: 'transparent'  }, 'slow')
    e.preventDefault()

  # Show More Comments when clicked
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
          if $('p.comment_delete a').attr('data-current-user')
            html += '<li class="comment clearfix old">\n'
            html += "<p class='comment_delete'>"
            html += "<a class='icon' rel='nofollow' data-method='delete' data-confirm='Are you sure?' href='articles/#{article_id}/comments/#{comment.id}'>"
            html += "<img src='/assets/button_cancel.png' alt='Button_cancel'>"
            html += "</a></p>"
            html += "<span>#{comment.name}</span>,<br /><br /> #{comment.content}\n"
            html += '</li>\n'
          else
            html += '<li class="comment clearfix old">\n'
            html += "<span>#{comment.name}</span>,<br /><br /> #{comment.content}\n"
            html += '</li>\n'

      parent_container.parent('.right-side').find('.comments').append(html)
      $('.old').fadeIn().removeClass('old').animate({ backgroundColor: 'yellow' }, 'slow').animate({ backgroundColor: 'transparent' }, 'fast')

      # Show the comment button, hide the loading spinner
      parent_container.css('display', 'block')
      $('.loading').css('display', 'none')

      # Hide the more comments button, if no more comments to load
      if parseInt(parent_container.attr('data-offset')) > parseInt(parent_container.attr('data-comments-count'))
        parent_container.css('display', 'none')
      
    parent_container.attr('data-offset', parseInt(parent_container.attr('data-offset')) + 4)
    e.preventDefault()


  # Sticky Navagation Bar to Scroll down
    # $(window).scroll ->
    #   $("#fluid").css "top", $(window).scrollTop()  if $(window).scrollTop() > 370

  # Scroll Up
    $("a[href='#top']").click ->
      $("html, body").animate
        scrollTop: 0
      , "slow"

  # Scroll Link - Paste In Layout/Application
    # <%= link_to 'Scroll Up', '#top', :class => 'scroll_up' %>

  # Toggle Comments
  $(document).on 'click', '.resized-comments', (e) ->
    article_id = $(e.target).attr('data-article-id')
    $.get "articles/#{article_id}/comments.json", (data) ->
    $(this).parents('div.left-side').siblings('.resized-comment-input').slideToggle();
    e.preventDefault()
    
  # Post Resized Comment after submission
  $(document).on 'ajax:success', 'form.new-comment', (e, data, status, xhr) ->

    html = ''
    html += "<li class='resized-comment new'>\n"
    html += "<span>#{data.comment.name}</span>,<br/><br/>#{data.comment.content}\n"
    html += "</li>\n" 
    
    $(this).siblings('.resized-comment-list').prepend(html)
    
    $('.new').fadeIn().removeClass('new').animate({ backgroundColor: 'yellow' }, 'slow').animate({ backgroundColor: 'transparent'  }, 'slow')
    e.preventDefault()

  # Post Resized-Show Comment
   $(document).on 'ajax:success', 'form.new-comment', (e, data, status, xhr) ->

    html = ''
    html += "<li class='resized-comment-show new'>\n"
    html += "<span>#{data.comment.name}</span>,<br/><br/>#{data.comment.content}\n"
    html += "</li>\n" 
    
    $(this).parent('div.resized-comment-input-show').siblings('ul.resized-comment-list-show').prepend(html)
    
    $('.new').fadeIn().removeClass('new').animate({ backgroundColor: 'yellow' }, 'slow').animate({ backgroundColor: 'transparent'  }, 'slow')
    e.preventDefault()

  # Show Resized More Comments
  $(document).on 'click', '.resized-more-comments', (e) ->
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
          if $('p.comment_delete a').attr('data-current-user')
            html += "<li class='resized-comment old'>\n"
            html += "<p class='comment_delete'>"
            html += "<a class='icon' rel='nofollow' data-method='delete' data-confirm='Are you sure?' href='articles/#{article_id}/comments/#{comment.id}'>"
            html += "<img src='/assets/button_cancel.png' alt='Button_cancel'>"
            html += "</a> </p>"
            html += "<span>#{comment.name}</span>,<br /><br /> #{comment.content}\n"
            html += '</li>\n'
          else
            html += '<li class="resized-comment old">\n'
            html += "<span>#{comment.name}</span>,<br /><br /> #{comment.content}\n"
            html += '</li>\n'

      parent_container.parent('.resized-comment-input').find('ul.resized-comment-list').append(html)
      $('.old').fadeIn().removeClass('old').animate({ backgroundColor: 'yellow' }, 'slow').animate({ backgroundColor: 'transparent' }, 'fast')

      # Show the comment button, hide the loading spinner
      parent_container.css('display', 'block')
      $('.loading').css('display', 'none')

      # Hide the more comments button, if no more comments to load
      if parseInt(parent_container.attr('data-offset')) > parseInt(parent_container.attr('data-comments-count'))
        parent_container.css('display', 'none')
      
    parent_container.attr('data-offset', parseInt(parent_container.attr('data-offset')) + 4)
    e.preventDefault()

  # Disable Delete For Non-Admin
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()


  # Show Resized More Comments-Show
  $(document).on 'click', '.resized-more-comments-show', (e) ->
    parent_container = $(this)

    # Hide the comment button, show the loading spinner
    parent_container.css('display', 'none')
    $('.loading').css('display', 'block')
    $('.loading').spin(spinner_options)   

    article_id = $(e.target).attr('data-article-id')
    offset = $(e.target).attr('data-offset')

    # Get comments based on offset
    $.get "#{article_id}/comments.json?offset=#{offset}", (data) ->
      html = ''

      for comment in data.comments 
        do ->
          if $('p.comment_delete a').attr('data-current-user')
            html += "<li class='resized-comment-show old'>\n"
            html += "<p class='comment_delete'>"
            html += "<a class='icon' rel='nofollow' data-method='delete' data-confirm='Are you sure?' href='articles/#{article_id}/comments/#{comment.id}'>"
            html += "<img src='/assets/button_cancel.png' alt='Button_cancel'>"
            html += "</a> </p>"
            html += "<span>#{comment.name}</span>,<br /><br /> #{comment.content}\n"
            html += '</li>\n'
          else
            html += '<li class="resized-comment-show old">\n'
            html += "<span>#{comment.name}</span>,<br /><br /> #{comment.content}\n"
            html += '</li>\n'

      $('.resized-comment-list-show').append(html)
      $('.old').fadeIn().removeClass('old').animate({ backgroundColor: 'yellow' }, 'slow').animate({ backgroundColor: 'transparent' }, 'fast')

      # Show the comment button, hide the loading spinner
      parent_container.css('display', 'block')
      $('.loading').css('display', 'none')

      # Hide the more comments button, if no more comments to load
      if parseInt(parent_container.attr('data-offset')) > parseInt(parent_container.attr('data-comments-count'))
        parent_container.css('display', 'none')
      
    parent_container.attr('data-offset', parseInt(parent_container.attr('data-offset')) + 4)
    e.preventDefault()


  # Infinity Scroll and Pagination of Articles
 # if $('#wrapper').length
 #   $(window).data('scroll_ready', true)
 #   all_articles_fetched = false
 #   page = $('#wrapper').data('article-page')    
 #   
 #   if $(window).data('scroll_ready', true)
 #     $(window).data('scroll_ready', false)
 #
 #
  #    tag = document.createElement('script')
  #    tag.src = "//www.youtube.com/iframe_api"
 #     firstScriptTag = document.getElementsByTagName('script')[0]
 #     firstScriptTag.parentNode.insertBefore(tag, firstScriptTag)
#
 #     $(window).scroll (e) ->
 #       if ($(window).scrollTop() >= $(document).height() - $(window).height()) 
 #         $('#wrapper').data('article-page', $('#wrapper').data('article-page') + 1)
 #         
 #         if !all_articles_fetched
 #           $.get "articles?page=" + $('#wrapper').data('article-page'), (data) ->
 #             if data.articles.length <= 0
 #               all_articles_fetched = true
 #             else
 #               if data.articles.length || !all_articles_fetched 
 #                 index = 0
 #                 for article in data.articles
 #                   do ->
 #                     console.log article.id
 #                     index += 1
#
 #                     html = ''
 #                     html += "<div class='article clearfix #{if ((index % 2) > 0) then 'even' else 'odd'}'>"
 #                     html += "<h1 class='title'>"
#
 #                     if $('.title a').attr('data-current-user')
 #                       html += "<a class='#{article.id}-#{article.title}' href='/articles/#{article.id}' data-current-user='true'>#{article.title} </a>"
 #                     else
 #                       html += "#{article.title}"
#
 #                     html += "</h1>\n"
#
 #                     html += "<div class='left-side clearfix'>"
 #                     html += "<p class='description'>"
#
 #                     for image in article.images
 #                       do ->
 #                         html += "<img src='#{image.image_url.url}' />"
#
 #                     for video in article.videos
 #                       do ->
 #                         html += "<embed src='http://www.youtube.com/v/#{video.video_url}?version=3&amp;hl=en_US&amp;rel=0' type='application/x-shockwave-flash' width='100%' height='480' allowscriptaccess='always' allowfullscreen='true'></embed>"
 #                     
 #                     html += "#{article.content}"
 #                     html += "</p>"
#
 #                     html += "<p class='author'>#{Date.today(Date.parse(article.created_at)).toString('dd MMM. yyyy')} &middot "
#
 #                     for tag in article.tags 
 #                       do ->
 #                         html += "#{tag.name} &middot "
#
 #                     html += "#{article.comments.length} Comments"
#
 #                     # Extra code for resized-author class
 #                     html += "<ul class='resized-author'>"
 #                     html += "<li class='resized-date first'>#{Date.today(Date.parse(article.created_at)).toString('dd MMM. yyyy')}</li>"
#
 #                     for tag in article.tags 
 #                       do ->
 #                         html += "<li class='resized-tags'>#{tag.name}</li>"
#
 #                     html += "<li>"
 #                     html += "<a class='resized-comments' data-article-id='#{article.id}' href='#'> #{article.comments.length} Comments </a>"
 #                     html += "</ul>"
 #                     html += "</div>"
#
 #                     html += "<div class='right-side clearfix'>"
 #                     html += "<div class='comments-wrapper'>"
 #                     html += "<form class='new-comment' method='post' data-type='json' data-remote='true' action='/articles/#{article.id}/comments' accept-charset='UTF-8'>"
 #                     html += "<div style='margin:0; padding:0; display:inline;'>
 #                              <input type='hidden' value='✓' name='utf8' name='authenticity_token'>
 #                              <input type='hidden' value='IOAjsyjgp9Uql2VnhCqy64SY34pl79Tg8Pb0ctuFr/U=' name='authenticity_token'>
 #                              </div>"
 #                     html += "<div class='field'>
 #                              <input id='comment_name' type='text' size='30' placeholder='Nickname' name='comment[name]'>
 #                              </div>"
 #                     html += "<div class='field'>
 #                              <textarea id='test' type='text' rows='20' placeholder='What is on your mind?' name='comment[content]' cols='40'></textarea>
 #                              </div>"
 #                     html += "<div class='submit'>
 #                              <input class='comment-button' type='submit' value='hit me' name='commit'>
 #                              </div>"
 #                     html += "<input id='redirect_to' type='hidden' value='homepage' name='redirect_to'>"
 #                     html += "</form>"
 #                     html += "</div>"
#
 #                     $.get "articles/#{article.id}/comments", (data) ->
 #                       html += "<ul class='comments'>\n"
#
 #                       for comment in data.comments
 #                         do ->
 #                           html += "<li class='comment'>\n"
#
 #                           if $('p.comment_delete a').attr('data-current-user')
 #                             html += "<p class='comment_delete'>"
 #                             html += "<a class='icon' rel='nofollow' data-method='delete' data-confirm='Are you sure?' href='/articles/#{article.id}/comments/#{comment.id}'>"
 #                             html += "<img src='/assets/button_cancel.png' alt='Button_cancel'>"
 #                             html += "</a></p>"
 #                             html += "<span>#{comment.name}</span>,<br/><br/>#{comment.content}\n"
 #                             html += "</li>\n"
 #                           else
 #                             html += "<span>#{comment.name}</span>,<br/><br/>#{comment.content}\n"
 #                             html += "</li>\n"
#
 #                       html += "</ul>\n"
#
 #                       if data.comments_count > 4 
 #                         html += "<a class='more-comments' data-offset='4' data-comments-count='#{data.comments.length}'
 #                                  data-article-id='#{article.id}' href='#'>more</a>"
 #                         html += "<div class='loading'></div>"
#
 #                       html += "</div>"
 #                       html += "<div class='resized-comment-input' style='display:none;'>"
 #                       html += "<form class='new-comment' method='post' data-type='json' data-remote='true' action='/articles/#{article.id}/comments' accept-charset='UTF-8'>"
 #                       html += "<div style='margin:0; padding:0; display:inline;'>
 #                                <input type='hidden' value='✓' name='utf8' name='authenticity_token'>
 #                                <input type='hidden' value='IOAjsyjgp9Uql2VnhCqy64SY34pl79Tg8Pb0ctuFr/U=' name='authenticity_token'>
 #                                </div>"
 #                       html += "<div class='field'>
 #                                <input id='comment_name' type='text' size='30' placeholder='Nickname' name='comment[name]'>
 #                                </div>"
 #                       html += "<div class='field'>
 #                                <textarea id='test' type='text' rows='20' placeholder='What is on your mind?' name='comment[content]' cols='40'></textarea>
 #                                </div>"
 #                       html += "<div class='submit'>
 #                                <input class='btn btn-success' type='submit' value='Submit' name='commit'>
 #                                </div>"
 #                       html += "<input id='redirect_to' type='hidden' value='homepage' name='redirect_to'>"
 #                       html += "</form>"
#
 #                       
 #                       html += "<ul class='resized-comment-list'>\n"
#
 #                       for comment in data.comments
 #                         do ->
 #                           html += "<li class='resized-comment'>\n"
#
 #                           if $('p.comment_delete a').attr('data-current-user')
 #                             html += "<p class='comment_delete'>"
 #                             html += "<a class='icon' rel='nofollow' data-method='delete' data-confirm='Are you sure?' href='/articles/#{article.id}/comments/#{comment.id}'>"
 #                             html += "<img src='/assets/button_cancel.png' alt='Button_cancel'>"
 #                             html += "</a></p>"
 #                             html += "<span>#{comment.name}</span>,<br/><br/>#{comment.content}\n"
 #                             html += "</li>\n"
 #                           else
 #                             html += "<span>#{comment.name}</span>,<br/><br/>#{comment.content}\n"
 #                             html += "</li>\n"
#
 #                       html += "</ul>\n"
#
 #                       if data.comments_count > 4 
 #                         html += "<a class='resized-more-comments' data-offset='4' data-comments-count='#{article.comments.length}'
 #                                  data-article-id='#{article.id}' href='#'>more</a>"
 #                         html += "<div class='loading'></div>"
 #                         html += "</div>"
#
 #                       html += "</div>"
 #                       html += "\n"
#
 #                       $('#wrapper').append(html)
#
#
 #                   # determins if it should grab new results
 #                   $(window).data('scroll_ready', true)
