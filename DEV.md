# Developper's guide

## Environment

R version ?

### Java

Because the underlying VTL engine is Trevas, a proper JVM is needed, with Java 11+.

## Release

In order to be ready releasing the package, run:

```r
devtools::check()
```

to check if everything is ok with the package, then:

```r
check_rhub()
```

to run `R CMD check` on various platforms (thanks to [R-hub](https://docs.r-hub.io/)).
