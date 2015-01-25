require 'csvigo'
require 'torch'

function csv2tensor(path,opts)
   print("loading data from csv")
   if(opts and opts.exclude and opts.include) then
      print("Warning: both 'exclude' and 'include' specified. Using 'exclude' only")
   end
   local csv_data  = csvigo.load{path=path}
   local col_names, ncols
   if opts and opts.exclude then
      col_names, ncols = _exclude_cols(csv_data,opts.exclude)
   elseif opts and opts.include then
      col_names, ncols = _include_cols(csv_data,opts.include)
   else
      col_names, ncols = _all_cols(csv_data)
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

function _all_cols(csv_data)
   local col_names = {}
   local ncols = 0
   for k,v in pairs(csv_data) do
      ncols = ncols + 1
      col_names[ncols] = k
   end
   return col_names, ncols
end

function _exclude_cols(csv_data,ignore)
   local col_names = {}
   local ncols = 0
   for k,v in pairs(csv_data) do
      if not  _in(k,ignore) then
         ncols = ncols + 1
         col_names[ncols] = k
      end
   end
   return col_names, ncols
end

function _include_cols(csv_data,keep)
   local col_names = {}
   local ncols = 0
   for k,v in pairs(csv_data) do
      if _in(k,keep) then
         ncols = ncols + 1
         col_names[ncols] = k
      end
   end
   return col_names, ncols
end

function _in(s,ls)
   for _, v in ipairs(ls) do
      if v == s then
         return true
      end
   end
   return false
end
