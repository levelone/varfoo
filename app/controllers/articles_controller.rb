class ArticlesController < ApplicationController
  before_filter :check_if_admin, :only => [:new, :create, :edit, :update]

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
  	@article = Article.find params[:id]
    # flash[:error] = "#{@article.errors.full_messages.to_sentence}"
    # redirect_to root_path(:anchor => "#{@article.id}-#{@article.title.parameterize}")
	end

  def new
  	@article = Article.new
  end

  def create
    @article = current_user.articles.new (params[:article])
    # @article.user_id = current_user.id

    # authentication = current_user.authentications.where(:provider => 'twitter').first

    # twitter_client = Twitter::Client.new(
    #   :oauth_token => authentication.token,
    #   :oauth_token_secret => authentication.secret
    # )

    # twitter_client.update('Posted: "' + @article.title + '" ... on http://www.Varfoo.com #' + @article.tag_list + '')

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

  private

  def check_if_admin
    current_user.present? && current_user.admin
  end
end
