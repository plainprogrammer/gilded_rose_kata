def update_quality(items)
  items.each do |item|
    next if item.name == 'Sulfuras, Hand of Ragnaros'
    if item.quality < 50
      multiple = quality_change_multiple(item)
      update_item_quality(item, multiple)
    end
    update_item_sell_in(item)
  end
end

def update_item_sell_in(item)
  item.sell_in -= 1
end

def quality_change_multiple(item)
  if item.name == 'Backstage passes to a TAFKAL80ETC concert'
    if item.sell_in <= 5
      3
    elsif item.sell_in <= 10
      2
    else
      1
    end
  elsif item.sell_in <= 0
    2
  else
    1
  end
end

def update_item_quality(item, multiple)
  case item.name
  when 'Aged Brie'
    item.quality += [50 - item.quality, multiple].min
  when 'Backstage passes to a TAFKAL80ETC concert'
    if item.sell_in > 0
      item.quality += [50 - item.quality, multiple].min
    else
      item.quality = 0
    end
  else
    item.quality -= [item.quality, multiple].min
  end
end

#----------------------------
# DO NOT CHANGE THINGS BELOW
#----------------------------
Item = Struct.new(:name, :sell_in, :quality)
