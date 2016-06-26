class EventItem < Item
  include Listable
  attr_reader :start_date, :end_date

  def initialize(description, options={})
    @description = description
    @start_date = Chronic.parse(options[:start_date],) if options[:start_date]
    @end_date = Chronic.parse(options[:end_date],) if options[:end_date]
    @item_type = "event"
  end

  def details
    format_description(@description) + "event dates:  #{format_date(@start_date, @end_date)} " + format_type()
  end
end
