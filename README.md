# LogRanges

## This package is unmaintained. You may use `Base.logrange` starting in Julia 1.11 or [`Compat.logrange`](https://github.com/JuliaLang/Compat.jl) instead.

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://JuliaCollections.github.io/LogRanges.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://JuliaCollections.github.io/LogRanges.jl/dev/)
[![Build Status](https://github.com/JuliaCollections/LogRanges.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/JuliaCollections/LogRanges.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/JuliaCollections/LogRanges.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/JuliaCollections/LogRanges.jl)
[![PkgEval](https://JuliaCI.github.io/NanosoldierReports/pkgeval_badges/L/LogRanges.svg)](https://JuliaCI.github.io/NanosoldierReports/pkgeval_badges/L/LogRanges.html)
[![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

Provides `logrange` and `LogRange` which are analogous to `Base.range` and `Base.LinRange`,
but with logaritmically spaced elements. For example

```julia
julia> using LogRanges

julia> logrange(1, 1000, 7)
7-element LogRange{Float64, Base.TwicePrecision{Float64}}:
 1.0, 3.16228, 10.0, 31.6228, 100.0, 316.228, 1000.0
```

That's it. This is a very lightweight dependency.
```julia
julia> @time_imports using LogRanges
      0.5 ms  LogRanges
```
