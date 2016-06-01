class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = if options[:title] == nil then "" else options[:title] end
    @items = []
  end
  
  def add(type, description, options={})
    type = type.downcase
    if type == "todo" || type == "event" || type == "link"
      @items.push TodoItem.new(description, options) if type == "todo"
      @items.push EventItem.new(description, options) if type == "event"
      @items.push LinkItem.new(description, options) if type == "link"
    else
      raise udaciListErrors::InvalidItemType, "#{type} is an invalid list type."
    end
  end
  
  def delete(index)
    if index > (@items.length - 1)
      raise UdaciListErrors::IndexExceedsListSize, "#{index} index is outside the list."
    end
    @items.delete_at(index - 1)
  end
  
  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end
