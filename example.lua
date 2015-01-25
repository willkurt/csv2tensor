-- quick example of loading a csv file
csv2tensor = require 'csv2tensor'
sample_tensor, col_names = csv2tensor.load("./data/simple.csv")
print(sample_tensor)
print(col_names)


sample_tensor2, col_names2 = csv2tensor.load("./data/simple.csv",{exclude={"col_a"}})
print(sample_tensor2)
print(col_names2)

sample_tensor3, col_names3 = csv2tensor.load("./data/simple.csv",{include={"col_a"}})
print(sample_tensor3)
print(col_names3)
