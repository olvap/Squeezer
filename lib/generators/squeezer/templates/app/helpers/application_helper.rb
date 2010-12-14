# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper  
  def link_permitted(*args)
    name = args.first
    
    action = args.second
    obj = args.third    
    options = args.fourth
    
    if permitted_to? action,obj
      if action == :destroy 
        link_to name,options,:confirm => 'Are you sure?', :method => :delete
      else
        link_to name,options
      end
    end
  end

  def show_bar
    "#{link_permitted "Mostrar",:show,controller_name.to_sym,{:action=>:show,:id=>params[:id]}} "
  end
  
  def index_bar
    "#{link_permitted "Ver Todos",:index,controller_name.to_sym,{:action=>:index}} "
  end
  
  def destroy_bar
    "#{link_permitted "Borrar",:destroy,controller_name.to_sym,{:action=>:show,:id=>params[:id]}} "
  end
  
  def historics_bar
    "#{link_permitted "Historico",:historics,controller_name.to_sym,{:action=>:historics,:id=>params[:id]}} "
  end
  
  def edit_bar
    "#{link_permitted "Editar",:edit,controller_name.to_sym,{:action=>:edit,:id=>params[:id]}} "
  end
  
  def new_bar
    "#{link_permitted "Nuevo",:new,controller_name.to_sym,{:action=>:new}} "
  end
  
  def list_bar(a)
    bar=""
    a.each {|x|
      bar +=eval(x.to_s+'_bar') 
    }
    return bar
  end
  
  def action_bar
    h={
     :show => [:index,:new,:edit,:historics,:destroy],
     :index =>[:new],
     :new => [:index],
     :edit => [:index,:show,:new,:historics,:destroy],
     :historics =>[:index,:show,:new,:edit,:destroy],
     :old => [:index,:show,:new,:historics]
    }
    bar=list_bar(h[action_name.to_sym])

    content_for :action_bar do
      bar
    end
  end
end
