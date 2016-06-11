class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = if options[:title] == nil then "" else options[:title] end
    @items = []
  end
  
  def add(type, description, options={})
    type = type.downcase
    
    #TODO: rework as some sort of switch/if else case.
    if type == "todo" || type == "event" || type == "link"
      @items.push TodoItem.new(description, options) if type == "todo"
      @items.push EventItem.new(description, options) if type == "event"
      @items.push LinkItem.new(description, options) if type == "link"
    else
      raise UdaciListErrors::InvalidItemType, "#{type} is an invalid list type."
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
