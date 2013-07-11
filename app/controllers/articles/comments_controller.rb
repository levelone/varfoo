class Articles::CommentsController < ApplicationController
  #before_filter :require_login, :only => [:new, :create]

  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments.order('id DESC').limit(4).offset(params[:offset])

    respond_to do |format|
      format.json { render :json => { :comments => @comments }.to_json and return }
    end
  end

  def new
    @article = Article.find(params[:article_id])
    @comment = Comment.new
    # require_login
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = Comment.new(params[:comment])

    @comment.article_id = params[:article_id]

    # #Comment Adding
    # if current_user present?
    #   @comment.user_id = current_user.id
    # else
    #   @comment.user_id = 9
    # end

    if @comment.save
      respond_to do |format|
        format.html { redirect_to root_path, :notice => 'Comment created!' }
        format.json { render :json => { :comment => @comment }.to_json and return }
      end
    else  
      respond_to do |format|
        format.html { flash[:error] = "#{@comment.errors.full_messages.to_sentence}"
                      redirect_to root_path(:anchor => "#{@article.id}-#{@article.title.parameterize}") }
        format.json { render :json => @comment.errors.full_messages and return }
      end
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

    redirect_to root_path, :notice => 'Comment removed!'
  end

  # private

  # def require_login
  #   redirect_to log_in_path, :notice => 'Log in or Sign up first!' if current_user.blank?
  # end
end
