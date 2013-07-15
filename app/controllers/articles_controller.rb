class ArticlesController < ApplicationController
	def index
    # @articles = Article.order('created_at DESC').page params[:page]
    @articles = Article.order('id DESC').includes(:comments).includes(:tags).includes(:images).includes(:videos).page(params[:page]).per(4)

    # added code for infinity scroll
    respond_to do |format|
      format.json { render :json => { :articles => @articles }.to_json(:include => [:tags, :videos, :images, :comments] ) and return }
      format.html
    end
	end

	def edit
  	@article = Article.find params[:id]
	end

  def update
  	@article = Article.find params[:id]
    @article.update_attributes(params[:article])
	  redirect_to article_path, :notice => 'Update successful!'
  end

	def show
    if current_user.present?
    	@article = Article.find params[:id]
    else
      flash[:error] = "#{@article.errors.full_messages.to_sentence}"
      redirect_to root_path(:anchor => "#{@article.id}-#{@article.title.parameterize}")
    end
	end

  def new
  	@article = Article.new
  end

  def create
    @article = current_user.articles.new (params[:article])
    # @article.user_id = current_user.id

    authentication = current_user.authentications.where(:provider => 'twitter').first

    twitter_client = Twitter::Client.new(
      :oauth_token => authentication.token,
      :oauth_token_secret => authentication.secret
    )

    twitter_client.update(@article.title)

		if @article.save
			redirect_to article_path(@article)
		else
			render :action => :new
		end
  end

  def destroy
  	@article = Article.find params[:id]

		@article.destroy
		redirect_to articles_path, :notice => 'Article Removed'
  end
end
