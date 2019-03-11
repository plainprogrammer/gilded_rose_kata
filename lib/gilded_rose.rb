def update_quality(items)
  items.each do |item|
    next if item.name == 'Sulfuras, Hand of Ragnaros'
    if item.quality < 50
      multiple = quality_change_multiple(item)
      update_item_quality(item, multiple)
    end
    item.sell_in -= 1
  end
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
    item.quality += multiple
  when 'Backstage passes to a TAFKAL80ETC concert'
    if item.sell_in > 0
      item.quality += multiple
    else
      item.quality = 0
    end
  when /^Conjured/
    item.quality -= (2 * multiple)
  else
    item.quality -= multiple
  end
  item.quality = [[0, item.quality].max, 50].min
end

#----------------------------
# DO NOT CHANGE THINGS BELOW
#----------------------------
Item = Struct.new(:name, :sell_in, :quality)
