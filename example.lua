-- quick example of loading a csv file
dofile("csv2tensor.lua")
sample_tensor, col_names = csv2tensor("./data/simple.csv")
print(sample_tensor)
print(col_names)


sample_tensor2, col_names2 = csv2tensor("./data/simple.csv",{exclude={"col_a"}})
print(sample_tensor2)
print(col_names2)

sample_tensor3, col_names3 = csv2tensor("./data/simple.csv",{include={"col_a"}})
print(sample_tensor3)
print(col_names3)
