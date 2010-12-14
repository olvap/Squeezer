class Data < ActiveRecord::Migration
  def self.up
    Role.create :name=>'Admin',:desc=>'Es el Rol de administrador'
    User.create :email=>'magicche@hotmail.com',:password=>'admin', :role_ids=>[1]
    Site.create :name =>'Squeezer',:slogan=>'Porque a nadie le gusta exprimir pero a todos les gusta la limonada',:style=>'squeezer'    
  end
end