require 'rails/generators/resource_helpers'
require 'rails/generators/rails/model/model_generator'
require 'active_support/core_ext/object/blank'

class SqueezerGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
   
  source_root File.expand_path('../templates', __FILE__)

  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1 )
    end
  end
      
  def squeez
    gem "will_paginate", "~> 3.0.pre2"  
    puts "paginacion"
    gem 'haml'
    puts "para escribir en haml en lugar de html"
    gem 'devise',"~>1.1.rc2"
    puts "maneja la registracion de usuario, login, emails de confirmacion, etc"
    gem 'paperclip'
    puts "para subir archivos"
    gem 'cancan'
    puts "permisos para roles"
    gem 'nifty-generators'
    puts "un generador de scaffold mas lindo"
    gem 'jquery-rails'
    puts "para usar jquery en lugar de prototype"
    gem 'inherited_resources'
    puts "para no tener que repetir el mismo controlardor todas las veces, util para entidades simples."
    gem 'mysql'
    puts "para usar mysql"
    gem "meta_search"
    puts "hace las busquedas mas faciles"
    gem "rails_helpers_fix"
    puts "hasta que salga laversion 3.1 esto soluciona el error de no inclir los helpers"
    
    generate('bundler install')
    generate('jquery:install --ui')
    generate('devise:install')
    generate('devise user')
    #generate('nifty:layout')
    #generate('devise:views')

    #models
    cf_m "user.rb"
    cf_m "ability.rb"

    #vistas
    cf_v "layouts/application.html.erb"
    cf_v "layouts/_msn.haml"
    cf_v "layouts/_login.html.erb"
    cf_v "layouts/_sidebar.html.haml"
    cf_v "layouts/_menu.html.haml"
    cf_v "layouts/_msn.haml"
    cf_v "layouts/_footer.html.haml"
    cf_v "layouts/_ice.haml"
    copy_file("public/javascripts/application.js","public/javascripts/application.js")
    copy_file("public/javascripts/jquery.layout.min-1.2.0.js","public/javascripts/jquery.layout.min-1.2.0.js")
    
    copy_file("config/devise.rb","config/initializers/devise.rb")          
    
    FileUtils.cp_r(File.expand_path('../templates/public/stylesheets', __FILE__),'public/')     
    
    migrations
    
  end
  
  private

  def migrations
    #migraciones    
    cf_mig("create_roles")
    cf_mig("create_pages")
    cf_mig("create_blogs")
    cf_mig("create_comments")
    cf_mig("create_posts")
    cf_mig("create_roles_users")
    cf_mig("create_sites")
    cf_mig("add_username_user")
    cf_mig("squeez_data")
    cf_mig("page_data")    
  end
  
  def cf_mig(dir)  
    migration_template "db/migrate/#{dir}.rb", "db/migrate/#{dir}"
    sleep 1
  end
  
  def cf_js(dir)
    copy_file("public/javascripts/#{dir}","public/javascripts/#{dir}")
  end
  
  def cf_h(dir)
    copy_file("app/helpers/#{dir}","app/helpers/#{dir}")
  end
   
  def cf_v(dir)
    copy_file("app/views/#{dir}","app/views/#{dir}")
  end
  
  def cf_m(dir)
    copy_file("app/models/#{dir}","app/models/#{dir}")
  end
  
  def cf_c(dir)
    copy_file("app/controllers/#{dir}","app/controllers/#{dir}")
  end
  
end