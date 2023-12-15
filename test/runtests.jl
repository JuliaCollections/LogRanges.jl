using LogRanges
using Test
using Aqua

@testset "LogRanges.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(LogRanges, deps_compat=false)
        Aqua.test_deps_compat(LogRanges, check_extras=false)
    end

    @testset "LogRange" begin
        # basic idea
        @test logrange(2, 16, 4) ≈ [2, 4, 8, 16]
        @test LogRange(1/8, 8.0, 7) ≈ [0.125, 0.25, 0.5, 1.0, 2.0, 4.0, 8.0]
        @test logrange(1000, 1, 4) ≈ [1000, 100, 10, 1]
        @test LogRange(1, 10^9, 19)[1:2:end] ≈ 10 .^ (0:9)

        # negative & complex
        @test LogRange(-1, -4, 3) == [-1, -2, -4]
        @test LogRange(1, -1+0.0im, 3) ≈ [1, im, -1]
        @test LogRange(1, -1-0.0im, 3) ≈ [1, -im, -1]

        # endpoints
        @test LogRange(0.1f0, 100, 33)[1] === 0.1f0
        @test LogRange(0.789, 123_456, 135_790)[[begin, end]] == [0.789, 123_456]
        @test LogRange(nextfloat(0f0), floatmax(Float32), typemax(Int))[end] === floatmax(Float32)
        @test LogRange(nextfloat(Float16(0)), floatmax(Float16), 66_000)[end] === floatmax(Float16)
        @test first(LogRange(pi, 2pi, 3000)) === LogRange(pi, 2pi, 3000)[1] === Float64(pi)
        @test last(LogRange(-0.01, -0.1, 3000)) === last(LogRange(-0.01, -0.1, 3000))[end] === -0.1
        if Int == Int64
            @test LogRange(0.1, 1000, 2^54)[end] === 1000.0
            @test LogRange(-0.1, -1000, 2^55)[end] === -1000.0
        end

        # empty, only, NaN, Inf
        @test first(LogRange(1, 2, 0)) === 1.0
        @test last(LogRange(1, 2, 0)) === 2.0
        @test collect(LogRange(1, 2, 0)) == Float64[]
        @test isnan(first(LogRange(0, 2, 0)))
        @test only(LogRange(2pi, 2pi, 1)) === LogRange(2pi, 2pi, 1)[1] === 2pi
        @test isnan(LogRange(1, NaN, 3)[2])
        @test isnan(LogRange(NaN, 2, 3)[2])
        @test isnan(LogRange(1f0, NaN32, 3)[2])
        @test isnan(LogRange(NaN32, 2f0, 3)[2])
        @test isnan(LogRange(0, 2, 3)[1])
        @test isnan(LogRange(0, -2, 3)[1])
        @test isnan(LogRange(-0.0, +2.0, 3)[1])
        @test isnan(LogRange(0f0, 2f0, 3)[1])
        @test isnan(LogRange(0f0, -2f0, 3)[1])
        @test isnan(LogRange(-0f0, 2f0, 3)[1])
        @test isinf(LogRange(1, Inf, 3)[2])
        @test -Inf === LogRange(-1, -Inf, 3)[2]
        @test isinf(LogRange(1f0, Inf32, 3)[2])
        @test -Inf32 === LogRange(-1f0, -Inf32, 3)[2]
        # constant
        @test LogRange(1, 1, 3) == fill(1.0, 3)
        @test LogRange(-1f0, -1f0, 3) == fill(-1f0, 3)
        @test all(isnan, LogRange(0.0, -0.0, 3))
        @test all(isnan, LogRange(-0f0, 0f0, 3))

        # subnormal Float64
        x = LogRange(1e-320, 1e-300, 21) .* 1e300
        @test x ≈ LogRange(1e-20, 1, 21) rtol=1e-6

        # types
        @test eltype(LogRange(1, 10, 3)) == Float64
        @test eltype(LogRange(1, 10, Int32(3))) == Float64
        @test eltype(LogRange(1, 10f0, 3)) == Float32
        @test eltype(LogRange(1f0, 10, 3)) == Float32
        @test eltype(LogRange(1f0, 10+im, 3)) == ComplexF32
        @test eltype(LogRange(1f0, 10.0+im, 3)) == ComplexF64
        @test eltype(LogRange(1, big(10), 3)) == BigFloat
        @test LogRange(big"0.3", big(pi), 50)[1] == big"0.3"
        @test LogRange(big"0.3", big(pi), 50)[end] == big(pi)

        # more constructors
        @test logrange(1,2,3) === LogRange(1,2,3) == LogRange{Float64}(1,2,3)
        @test logrange(1f0, 2f0, length=3) == LogRange{Float32}(1,2,3)

        # errors
        @test_throws ArgumentError LogRange(1, 10, -1)
        @test_throws ArgumentError LogRange(1, 10, 1) # endpoints must not differ
        @test_throws DomainError LogRange(1, -1, 3)   # needs complex numbers
        @test_throws ArgumentError LogRange(1, 10, 2)[true]
        @test_throws BoundsError LogRange(1, 10, 2)[3]
        @test_throws ArgumentError LogRange{Int}(1,4,5)  # no integer ranges

        # printing
        @test repr(LogRange(1,2,3)) == "LogRange{Float64}(1.0, 2.0, 3)"
        @test repr("text/plain", LogRange(1,2,3)) == "3-element LogRange{Float64, Base.TwicePrecision{Float64}}:\n 1.0, 1.41421, 2.0"
    end

    @testset "_log_twice64_unchecked" begin
        # it roughly works
        @test big(LogRanges._log_twice64_unchecked(exp(1))) ≈ 1.0
        @test big(LogRanges._log_twice64_unchecked(exp(123))) ≈ 123.0

        # it gets high accuracy
        @test abs(big(log(4.0)) - log(big(4.0))) < 1e-16
        @test abs(big(LogRanges._log_twice64_unchecked(4.0)) - log(big(4.0))) < 1e-30

        # it handles subnormals
        @test abs(big(LogRanges._log_twice64_unchecked(1e-310)) - log(big(1e-310))) < 1e-20

        # it accepts negative, NaN, etc without complaint:
        @test LogRanges._log_twice64_unchecked(-0.0).lo isa Float64
        @test LogRanges._log_twice64_unchecked(-1.23).lo isa Float64
        @test LogRanges._log_twice64_unchecked(NaN).lo isa Float64
        @test LogRanges._log_twice64_unchecked(Inf).lo isa Float64
    end

end
