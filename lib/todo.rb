class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due], ) : options[:due]
    
    if options[:priority] == "low" || options[:priority] == "med" || options[:priority] == "high" || options["priority"] == nil
      @priority = options[:priority]
    else
      raise udaciListErrors::InvalidPriorityValue, "#{type} "
    end
  end
  
  def details
    format_description(@description) + "due: " +
    format_date(@due, nil) +
    format_priority(@priority)
  end
end
