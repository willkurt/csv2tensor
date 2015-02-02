csv2tensor = require '../csv2tensor'

require 'csvigo'

--helper function

function get_index(s,ls)
   for i,v in ipairs(ls) do
      if s == v then return i end
   end
   return nil
end

--- Testing loading a file ---

function test_values(path)
   local csv_data = csvigo.load({path=path})
   local tensor_data, col_names = csv2tensor.load(path)
   local col_i = nil
   --go through each column in the csv table
   for k,v in pairs(csv_data) do
      col_i = get_index(k,col_names)
      for i,n in ipairs(v) do
         assert(tonumber(n) == tensor_data[i][col_i])
      end
   end
end

test_values("simple.csv")
print("passed basic test of loading csv")

function test_string_arg_include(path)
   local tensor_data, col_names = csv2tensor.load(path,{include={'col_a'}})
   --this one just uses a string rather than a list, used to cause error
   local tensor_data, col_names = csv2tensor.load(path,{include='col_a'})
   local tensor_data, col_names = csv2tensor.load(path,{exclude={'col_a'}})
   --this one just uses a string rather than a list, used to cause error
--   local tensor_data, col_names = csv2tensor.load(path,{exclude='col_a'})
end
test_string_arg_include("simple.csv")
print("single arg in exclude/include passed")


function test_single_column_vector(path)
   local tensor_data, col_names = csv2tensor.load(path,{include={'col_a'}})
   assert(#(col_names) == 1,"failed on colnames")
   assert(#(#tensor_data) == 1,"Nx1 returned")
end
test_single_column_vector("simple.csv")
print("single column as vector passed")
print("tests passed")