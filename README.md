# darkr

`darkr` is an R package that wraps [Trevas](https://github.com/InseeFr/Trevas), a Java VTL engine.

## What is VTL ?

> VTL is a standard language for defining validation and transformation rules (set of operators, their syntax and semantics) for any kind of statistical data

For more information, follow [this](https://sdmx.org/?page_id=5096).

## How to use it?

`darkr` will be available on CRAN as soon as a sufficiently large set of features is developed and tested.

For now, you need to clone this repository, open the project in RStudio, then load the package using `devtools::load_all()`. Once done, try:

```R
res <- darkr::vtl_eval("a := 3 * 3; b := 33; c := a + b;")
# 42
```

You cand also use a VTL expression over a dataframe:

```R
df <- darkr::mock_df()
ds <- darkr::df_to_ds(df)
new <- darkr::vtl_eval("new_ds := ds[ drop age ];", ds)
```

## Roadmap

- [x] Basic wrapping of Trevas
- [x] Dataframes operations : 
  - [x] basic support of Trevas dataset operations
  - [x] transformation function from a dataframe to a [Trevas dataset](https://github.com/InseeFr/Trevas/blob/master/vtl-model/src/main/java/fr/insee/vtl/model/Dataset.java)
  - [ ] back from a dataset to a dataframe
- [ ] Support multiple bindings when evaluating a VTL expression

## How to developp?

TODO

### Java dependency

For now, in order to include Trevas as a jar, you need to clone the GitHub repo, and produce the jar file using `mvn package` and then copy it.

In two steps :

```
cd ~/code/vtl/Trevas/vtl-engine/
mvn package
```

then:

```
cd ~/code/vtl/darkr/
cp ../Trevas/vtl-engine/target/vtl-engine-0.1.0-jar-with-dependencies.jar ./java/
```

## Why the name?

Because the package is using [Trevas](https://github.com/InseeFr/Trevas), the Java VTL engine, and [trevas](https://en.wiktionary.org/wiki/trevas) means "darkness" in Portuguese.
