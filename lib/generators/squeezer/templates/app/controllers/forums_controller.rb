class ForumsController < ApplicationController
  filter_resource_access
  def index
    @forums = Forum.all
  end
  
  def show
    search = Topic.search(params[:search]).forum_id_equals(@forum.id)
    @topics = search.all.paginate(:per_page => 20, :page => params[:page])    
  end
  
  def new
  end
  
  def create
    if @forum.save
      flash[:notice] = "Successfully created forum."
      redirect_to @forum
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @forum.update_attributes(params[:forum])
      flash[:notice] = "Successfully updated forum."
      redirect_to @forum
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @forum = Forum.find(params[:id])
    @forum.destroy
    flash[:notice] = "Successfully destroyed forum."
    redirect_to forums_url
  end
end
