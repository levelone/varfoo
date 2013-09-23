class Articles::LikesController < ApplicationController

  def create
    @article = Article.find(params[:article_id])

    # Create Redis key and add article to session
    # Else Redis key already exists!
    if $redis.hset("session_id:#{request.session_options[:id]}", "article_id:#{@article.id}", 'like') == true
      puts 'Thanks for liking!'
      respond_to do |format|
        # Increase likes_count if Redis key exists
        @article.update_attributes(likes_count: @article.likes_count + 1)

        # Redis key expires if exists after 24 hours
        $redis.expire("session_id:#{request.session_options[:id]}", 86400)

        # Command to check when key expires
        # $redis.ttl("session_id:#{request.session_options[:id]}")

        # Command to inspect child element of parent key
        # $redis.hkeys("session_id:#{request.session_options[:id]}")
        # $redis.hget("session_id:#{request.session_options[:id]}", "article_id:#{@article.id}")
        # $redis.hexists("session_id:#{request.session_options[:id]}", "article_id:#{@article.id}")

        format.html  { redirect_to root_path, notice: 'Thanks for liking!' }
        format.json  { render :json => @article }
      end
    else
      puts 'Oops! You already liked this!'
      respond_to do |format|
        format.html  { redirect_to root_path, notice: 'Oops! You already liked this!' }
        format.json  { render :json => @article }
      end
    end
  end
end
