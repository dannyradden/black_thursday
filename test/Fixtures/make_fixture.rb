require 'csv'
table = CSV.table("./data/items.csv")


array = [12334105, 12334113, 12334123, 12334141, 12334195]


table.delete_if do |row|
  !array.include?(row[:merchant_id]) #&& !array2.include?(row[:id])
end

File.open("./test/fixtures/item_fixture.csv", 'w') do |f|
  f.write(table.to_csv)
end
