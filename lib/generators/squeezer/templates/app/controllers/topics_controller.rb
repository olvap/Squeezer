class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end
  
  def show
    @topic = Topic.find(params[:id])
    Comment.posts(@topic)
  end
  
  def new
    @topic = Topic.new
    @topic.forum_id=params[:id]
    @post = Post.new 
  end
  
  def create
    @topic = Topic.new(params[:topic])
    @topic=Comment.add_comment(@topic)
    Comment.add_post(@topic.comment.id,params[:post][:body])
    
    flash[:notice]="Listo!"
    redirect_to @topic
  end
  
  def edit
    @topic = Topic.find(params[:id])
  end
  
  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(params[:topic])
      flash[:notice] = "Successfully updated topic."
      redirect_to @topic
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    flash[:notice] = "Successfully destroyed topic."
    redirect_to topics_url
  end
end
