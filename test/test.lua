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

function test_include_order(path)
   local keep = {'col_a','col_b'}
   local _, col_names = csv2tensor.load(path,
                                        {include=keep})
   for i,k in ipairs(keep) do
      assert(col_names[i] == k,"include order wrong")
   end
   local keep = {'col_b','col_c','col_a'}
   local _, col_names = csv2tensor.load(path,
                                        {include=keep})
   for i,k in ipairs(keep) do
      assert(col_names[i] == k,"include order wrong")
   end
end
test_include_order("simple.csv")
print("passed include order")

function test_general_column_order(path)
   local _, col_names = csv2tensor.load(path)
   for i = 1,(#col_names-1) do
      assert(col_names[i] < col_names[i+1], "columns in incorrect order")
   end
end

test_general_column_order("simple.csv")
print("passed general column order")

function test_exclude_column_order(path)
   local _, col_names = csv2tensor.load(path,{exclude='col_a'})
   for i = 1,(#col_names-1) do
      assert(col_names[i] < col_names[i+1], "columns in incorrect order")
   end
end
test_exclude_column_order("simple.csv")
print("passed exclude column order")
print("tests passed")