class Site < ActiveRecord::Base
  #validates_attachment_presence :logo
  #validates_attachment_size :logo, :less_than => 5.megabytes
  #validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png']
  
  #validates_attachment_presence :icon
  #validates_attachment_size :icon, :less_than => 5.megabytes
  #validates_attachment_content_type :icon, :content_type => ['image/jpeg', 'image/png']
  validates_presence_of :name
  has_attached_file :logo, :styles => { :thumb => "100x100>" },
                             :url  => "/assets/sites/:id/:style/:basename.:extension",
                             :path => ":rails_root/public/assets/sites/:id/:style/:basename.:extension"
                             
  has_attached_file :icon, :styles => { :small => "10x10>", :thumb => "10x10>" },
                             :url  => "/assets/sites/:id/:style/:basename.:extension",
                             :path => ":rails_root/public/assets/sites/:id/:style/:basename.:extension"                              
end
