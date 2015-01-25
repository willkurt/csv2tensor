-- quick example of loading a csv file
dofile("csv2tensor.lua")
sample_tensor = csv2tensor("./data/simple.csv")
print(sample_tensor)