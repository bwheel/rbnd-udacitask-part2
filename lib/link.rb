class LinkItem < Item
  include Listable
  attr_reader :site_name

  def initialize(url, options={})
    @description = url
    @site_name = options[:site_name]
    @item_type = "link"
  end
  
  def format_name
    @site_name ? @site_name : ""
  end
  
  def details
    format_description(@description) +  "site name: #{format_name}" + format_type()
  end
end
