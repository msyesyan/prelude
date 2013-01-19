#encoding: utf-8
module ApplicationHelper

  def return_link(default_url, label = "返回")
    url = params[:ok_url].blank? ? default_url : params[:ok_url]
    link_to label, url, :class => 'btn'
  end
  
  def cancel_link(default_url)
    return_link(default_url, '取消')
  end
  
  def network_size(size)
    result = ""
    
    varietyG = 0
    if size > 1024*1024*1024
      varietyG = size / 1024*1024*1024
      result += "#{varietyG}G"
    end
    
    varietyM = 0
    if size > 1024*1024
      varietyM = (size - varietyG*1024*1024*1024) / 1024*1024
      result += "#{varietyM}M"
    end
    
    varietyK = 0
    if size > 1024
      varietyK = (size - varietyG*1024*1024*1024 - varietyM*1024*1024) / 1024
      result += "#{varietyK}K"
    end
    
    result
  end
end
