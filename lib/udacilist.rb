class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = if options[:title] == nil then "Untitled List" else options[:title] end
    @items = []
  end
  
  def add(type, description, options={})
    type = type.downcase
    
    allowed_types = { todo: TodoItem, link: LinkItem, event: EventItem }
    if allowed_types.keys.include? type.to_sym
      @items.push allowed_types[type.to_sym].new description, options
    else
      raise UdaciListErrors::InvalidItemType, "#{type} type doesn't exist"
    end

  end
  
  def delete(index)
    if index > (@items.length - 1)
      raise UdaciListErrors::IndexExceedsListSize, "#{index} index is outside the list."
    end
    @items.delete_at(index - 1)
  end
  
  def delete_multiple(items_to_remove)
    items_to_remove.each do |item|
      @items.delete(item)
    end
  end

  def all

    Formatador.display_line( "[blue]#{ "-" * @title.length}[/]")
    Formatador.display_line( "[green]#{@title}[/]" )
    Formatador.display_line( "[blue]#{"-" * @title.length}[/]" )
    @items.each_with_index do |item, position|
      Formatador.display_line( "[yellow]#{position + 1})[/] #{item.details}")
    end
  end
  
  def filter(filter_type)
    result = @items.select { |item| item.item_type == filter_type}
    if result.length == 0
      Formatador.display_line("[red]No events by #{filter_type} type[/]")
    else
      result
    end
  end
  
end
