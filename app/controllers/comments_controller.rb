class CommentsController < ApplicationController
	before_filter :require_login, :only => [:new, :create]

	def index
		@comment = Comment.all
	end

  def new
		@comment = Comment.new
	end

  def create
		@comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id

		if @comment.save
			redirect_to comments_path(@comment)
		else
			render :action => :new
		end
	end

	def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		redirect_to comments_path, :notice => 'Comment removed!'
	end

	private

	def require_login
		redirect_to root_path, :notice => 'Sign up or sign in first!' if current_user.blank?
	end
end
