class Item
  attr_reader :description
  attr_accessor :item_type
  def ==(other_item)
    @description == other_item.description && @item_type == other_item.item_type
  end
end