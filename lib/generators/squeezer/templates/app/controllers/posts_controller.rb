class PostsController < InheritedResources::Base
  load_and_authorize_resource

  def edit
    @post = Post.find(params[:id])
    render "comments/edit"
  end
  def create
    @post = Post.new(params[:post])
    @post.user =current_user
    if @post.save
      redirect_to(@post.comment.commentable, :notice => 'Post was successfully created.')
    else
      redirect_to :back
      flash[:error]="Completa todos los datos" 
    end
  end

  def destroy
    @post.destroy
    redirect_to @post.comment.commentable
  end
end
