class ArticlesController < ApplicationController
	def index
    @articles = Article.includes :comments
	end

	def edit
  	@article = Article.find params[:id]
    authorize! :create, @article
	end

  def update
  	@article = Article.find params[:id]
    @article.update_attributes(params[:article])
	  redirect_to article_path, :notice => 'Update successful!'
  end

	def show
  	@article = Article.find params[:id]
	end

  def new
  	@article = Article.new
  	authorize! :create, @article
  end

  def create
    @article = Article.new params[:article]
    @article.user_id = current_user.id

		if @article.save
			redirect_to articles_path(@article)
		else
			render :action => :new
		end
  end

  def destroy
  	@article = Article.find params[:id]

		@article.destroy
		redirect_to articles_path, :notice => 'Article Removed'
    authorize! :destroy, @article
  end
end
