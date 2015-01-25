require 'csvigo'
require 'torch'

function csv2tensor(path)
   print("loading data from csv")
   local csv_data  = csvigo.load{path=path}
   local col_names = {}
   local ncols = 0
   for k,v in pairs(csv_data) do
      ncols = ncols + 1
      col_names[ncols] = k
   end
   local n_rows = #csv_data[col_names[1]]
   print("creating tensor")
   local tensor_data = torch.Tensor(n_rows,#col_names)
   for i,col_name in ipairs(col_names) do
      next_col =  torch.Tensor(csv_data[col_name])
      tensor_data[{{},i}] = next_col
   end
   return tensor_data, col_names
end