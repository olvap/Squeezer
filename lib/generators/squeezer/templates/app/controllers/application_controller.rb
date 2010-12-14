# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  protect_from_forgery
  layout 'application'  
  
  helper_method :site
  helper_method :latests
  
  def latests
    Blog.paginate :page =>1,:per_page=>5, :order => 'created_at DESC'
  end
  
  def site
    return Site.last
  end
  
  rescue_from CanCan::AccessDenied do |exception|  
    flash[:error] = "Acceso no permitido!"  
    redirect_to root_url  
  end  
  
end