class Articles::CommentsController < ApplicationController
	before_filter :require_login, :only => [:new, :create]

	def index
		@article = Article.find(params[:article_id])
		@comments = @article.comments
	end

  def new
  	@article = Article.find(params[:article_id])
  	@comment = Comment.new
  	require_login
	end

  def create
  	@article = Article.find(params[:article_id])
		@comment = Comment.new(params[:comment])

    @comment.article_id = params[:article_id]
    @comment.user_id = current_user.id

		if @comment.save
			redirect_to root_path, :notice => 'Comment created!'
		else
			render :action => :new
		end
	end

	def edit
  	@article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
  end

  def update
  	@article = Article.find(params[:article_id])
	  @comment = Comment.find(params[:id])

    @comment.update_attributes(params[:comment])
	  redirect_to article_comments_path, :notice => 'Comment successfully updated!'
  end

	def show
    @comment = Comment.find(params[:id])
	end

	def destroy
		@article = Article.find(params[:article_id])
		@comment = Comment.find(params[:id])

    @comment.destroy

    redirect_to article_comments_path, :notice => 'Comment removed!'
	end

	private

	def require_login
		redirect_to log_in_path, :notice => 'Log in or Sign up first!' if current_user.blank?
	end
end
