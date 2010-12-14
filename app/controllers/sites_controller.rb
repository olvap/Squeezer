class SitesController < InheritedResources::Base
  load_and_authorize_resource
  
  def new
    @files = Dir.open("public/stylesheets/ice")
    @site=site
    if(!@site)
      @site = Site.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @site }
      end
    else
      flash[:notice]="el sitio ya fue creado"
      
    end
  end

  # GET /sites/1/edit
  def edit
    if site
      @site = site
      @files = Dir.open("public/stylesheets/ice")
    else
      redirect_to({:action=>new})
    end
  end

  # POST /sites
  # POST /sites.xml
  def create    
    @site = Site.new(params[:site])
    respond_to do |format|
      if @site.save
        flash[:notice] = 'El sitio fue creado'
        format.html { redirect_to(:controller=>"users",:action=>'sign_up') }
        format.xml  { render :xml => @site, :status => :created, :location => @site }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sites/1
  # PUT /sites/1.xml
  def update
    @site = Site.find(params[:id])
       
    respond_to do |format|
      if @site.update_attributes(params[:site])
        files = Dir.open("public/stylesheets/ice/#{@site.style}/ice")
        FileUtils.cp_r files ,"app/views/layouts/ice/#{@site.style}"
        flash[:notice] = 'Site was successfully updated.'
        format.html { redirect_to(@site) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @site = Site.last
    @site.destroy
    redirect_to(@site)
  end
end
