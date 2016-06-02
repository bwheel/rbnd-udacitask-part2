class TodoItem < Item
  include Listable
  attr_reader :due, :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due], ) : options[:due]
    
    if options[:priority] == "low" || options[:priority] == "medium" || options[:priority] == "high" || options[:priority] == nil
      @priority = options[:priority]
    else
      raise UdaciListErrors::InvalidPriorityValue, "#{options[:priority]} is wrong priority value"
    end
    
    @item_type = "todo"
    
  end
  
  def details
    format_description(@description) + "due: " +
    format_date(@due, nil) +
    format_priority(@priority)
  end
end
