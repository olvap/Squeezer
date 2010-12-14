class CommentsController < ApplicationController
  load_and_authorize_resource
  
  def show
    time = Time.at(params[:after].to_i + 1)
    @post = Post.where("comment_id = ? and created_at > ?",@comment.id,time)
  end
  
  def open
    @comment = Comment.find(params[:id])
    @comment.open=1
    @comment.save
    redirect_to :back
  end
  
  def close
    @comment = Comment.find(params[:id])
    @comment.open = false
    @comment.save
    redirect_to :back
  end

  def new
    @comment = Comment.new
    @comment.commentable_id = params[:id]
    @comment.open = true
    @comment.commentable_type = params[:type]
    @comment.save
    redirect_to :back
  end

  def remove
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to :back  
  end
end
