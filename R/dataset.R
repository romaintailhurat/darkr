df_to_ds <- function(df) {
  if (!is.data.frame(df)) {
    stop("The parameter should be a dataframe.")
  }
  if (is.null(dim(df))) {
    stop("The dataframe must not be empty.")
  }
  cols <- names(df)
  # Computing data parameter
  args_mat <- apply(df, 1, function(row) {
    row_to_map_args(names(df), row)
  })
  maps <- apply(args_mat, 2, function(col) {map_of(col)})
  data <- list_of(maps)
  # Types
  tt <- sapply(df, function(col) typeof(col))
  targs <- row_to_map_args(names(tt), tt)
  targs[ targs == "character" ] <- c(J(JAVA_FQDN$Lang$String)$class)
  targs[ targs == "double" ] <- c(J(JAVA_FQDN$Lang$Double)$class)
  types <- map_of(unlist(targs))
  # Roles
  role_enum <- J(JAVA_FQDN$VTL$Dataset)$Role
  tail_ <- tail(cols, length(cols)-1)
  # FIXME simple implem where the 1st column is an identifier, the rest is measure only.
  roles <- map_of(
    c(
      c(head(cols, 1), role_enum$IDENTIFIER),
      c(tail_, replicate(length(tail_), role_enum$MEASURE))
    )
  )
  # Creating the dataset
  ds <- .jnew(
    "fr/insee/vtl/model/InMemoryDataset",
    data,
    types,
    roles
    )
  ds
}
