#' The goal of this file is to store experiments with rJava et Trevas
#' in order to share insights and troubles.
#' Should be push the GitHub repo as necessary.

# Dataset operations ----

# __ Creating the dataset

# We can create a simple dataframe from the `test_utils` module
df <- mock_df_naw()

# This dataframe has 3 columns, the first one will be the identifier
names(df)
# > "name"   "age"    "weight"

# We transform the R dataframe into a dataset ; more specifically a
# Trevas vtl-model InMemoryDataset
dataset <- df_to_ds(df)
dataset$getClass()$toString()
# > class fr.insee.vtl.model.InMemoryDataset

# Creation of the VTL engine and inject the dataset in the context
engine <- get_engine()
context <- engine$getContext()
SC <- rJava::J("javax/script/ScriptContext")
context$setAttribute("ds1", dataset, SC$ENGINE_SCOPE)
context$getAttribute("ds1")$getClass()$toString() == "class fr.insee.vtl.model.InMemoryDataset"
# > TRUE

# We check the structures part of the dataset
ds_struct <- dataset$getDataStructure()
ds_struct_array <- ds_struct$toArray()
# Extracting components...
name_component <- ds_struct_array[[1]]
age_component <- ds_struct_array[[2]]
weight_component <- ds_struct_array[[3]]
# ...displaying their attributes
cat_comp(name_component)
cat_comp(age_component)
cat_comp(weight_component)
# > Component name: name / Component type: class java.lang.String / Component role: IDENTIFIER
# > Component name: age / Component type: class java.lang.Long / Component role: MEASURE
# > Component name: weight / Component type: class java.lang.Long / Component role: MEASURE

# Checking data
data_points <- dataset$getDataPoints()
dp_array <- data_points$toArray()
col_one <- dp_array[[1]]$toArray()
cat_datapoints_vector(col_one)
# > Element 1 : Hadrien -> class java.lang.String
# > Element 2 : 33 -> class java.lang.Long
# > Element 3 : 40 -> class java.lang.Long


# __ `drop` statement

# The "age" component exists...
context$getAttribute("ds1")$getDataStructure()$toArray()[[2]]$getName()
# ...but the drop statement doesn't work
drop_dataset <- engine$eval("ds := ds1[drop age];")
# > Error in .jcall("RJavaTools", "Ljava/lang/Object;", "invokeMethod", cl,  :
# >  java.lang.NullPointerException

# __ `filter` statement

# Trying to use the filter statement on the age component, sadly won't work
age_dataset <- engine$eval("ds := ds1[filter age > 10 and age < 50];")
# > Error in .jcall("RJavaTools", "Ljava/lang/Object;", "invokeMethod", cl,  :
# >  java.lang.UnsupportedOperationException: implement the other comparison

# Filter on "name" return a dataset...
hadrien_dataset <- engine$eval("ds := ds1[filter name = \"Hadrien\"];")
# ...that is empty
hadrien_dataset$getDataPoints()$toArray()$length
# > 0
