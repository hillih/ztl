[
  { name: 'Halka', symbol: 'ha', sex: 0, position: 1 },
  { name: 'Bluzka', symbol: 'bl', sex: 0, position: 2 },
  { name: 'Spódnica', symbol: 'sa', sex: 0, position: 3 },
  { name: 'Serdak', symbol: 'se', sex: 0, position: 4 },
  { name: 'Fartuch', symbol: 'fa', sex: 0, position: 5 },
  { name: 'Wianek/chusta', symbol: 'ng', sex: 0, position: 6 },
  { name: 'Korale', symbol: 'kr', sex: 0, position: 7 },
  { name: 'Warkocz', symbol: 'wa', sex: 0, position: 8 },
  { name: 'Buty damskie', symbol: 'bd', sex: 0, position: 9 },
  { name: 'Koszula', symbol: 'ko', sex: 1, position: 1 },
  { name: 'Spodnie', symbol: 'sp', sex: 1, position: 2 },
  { name: 'Sukmana', symbol: 'sk', sex: 1, position: 3 },
  { name: 'Pas', symbol: 'pa', sex: 1, position: 4 },
  { name: 'Buty męskie', symbol: 'bm', sex: 1, position: 5 }
].each do |type|
  oet = OutfitElementType.find_by(symbol: type[:symbol].upcase)
  unless oet
    new_oet = OutfitElementType.create!(type)
    puts "Created: #{new_oet.name}"
  end
end
