require './dimensiondata.rb'

puts Dimensiondata::Client.new("https://api-na.dimensiondata.com/oec/0.9", "phillip.spies","W&u6we-refru").network.create("test","NA3")

