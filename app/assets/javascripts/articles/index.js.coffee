jQuery ->
  $('form#new_comment').on 'ajax:success', (e, data, status, xhr) ->
    html = ''
    html += '<li class="comment clearfix new">\n'
    html += "<span>#{data.comment.user.name}: </span>#{data.comment.content}\n"
    html += '</li>\n' 

    $(this).parent('#comments_wrapper').siblings('#comments').prepend(html)
    $('.new').fadeIn().removeClass('new').animate({ backgroundColor: 'yellow' }, 'slow').animate({ backgroundColor: '#fff' }, 'fast')
    e.preventDefault();

    $('.more_comments').click (e) ->
    # article_id = $(e.target).attr('data-article-id')
    # offset = $(e.target).attr('data-offset')
    # $.get "articles/#{article_id}/comments.json?offset=#{offset}", (data) ->



# html = ''
# html += '<li class="comment clearfix">\n'
# html += "<span>#{data.comment.user.name}: </span>#{data.comment.content}\n"
# html += '</li>\n' 

    e.preventDefault();

    # html = ''
    # html += '<div class="right-side clearfix"\n'
    # html += '<ul>\n'
    # html += '<li class="comment clearfix">\n'
    # html += '<span>#{data.comments}</span>\n'
    # html += '</li>\n'
    # html += '</ul>\n'
    # html += '</div>\n'

    # $('#comments #comments_wrapper').after(html)
    # e.preventDefault();