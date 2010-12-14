# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module SqueezerHelper

  require 'digest/md5'
  
  def gravatar_url_for(email, options = {})
    image_tag("http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}")
  end
  
  def wysiwug
    content_for(:head) { javascript_include_tag('jquery.cleditor.min')}
    content_for(:head) { stylesheet_link_tag('CLEditor1_3_0/jquery.cleditor')}
    raw "<script>$(function(){$('.wysiwyg').cleditor();});</script>"
  end
  
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end
  
  def show_title?
    @show_title
  end
  
  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end
  
  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end
   

  
  def link_to(*args, &block)
    if block_given?
      options = args.first || {}
      html_options = args.second
      link_to(capture(&block), options, html_options)
    else
      name = args[0]
      options = args[1] || {}
      html_options = args[2]

      html_options = convert_options_to_data_attributes(options, html_options)
      url = url_for(options)
      
      if (url.split('/').last == url.split('/')[1])
        action ="index"
      else      
        action = url.split('/').last
        if action.to_i > 0
          action = "show"
          if args[2]
            if args[2][:method]
              action = "destroy"
            end
          end
        end
      end
      #controller = url.split('/')[1].chop.capitalize
      
      href = html_options['href']
      tag_options = tag_options(html_options)

      href_attr = "href=\"#{ERB::Util.html_escape(url)}\"" unless href
      classes="class='sq-#{action}'"      

      #if(can?(action.to_sym, controller) || controller >="User")
        "<a #{classes} #{href_attr}#{tag_options}>#{ERB::Util.html_escape( name || url)}</a>".html_safe
      #end
      
      
    end
  end

end
