class BlogsController < InheritedResources::Base 
  load_and_authorize_resource
  
  def index
    @blogs = Blog.find(:all,:order=>'created_at desc')
  end
    
  def create
    @blog = Blog.new(params[:blog])
    @blog.user =current_user
    if @blog.save
      flash[:notice] = "Successfully created blog."
      redirect_to @blog
    else
      render :action => 'new'
    end
  end
  
end
