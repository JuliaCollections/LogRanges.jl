using LogRanges
using Test
using Aqua

@testset "LogRanges.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(LogRanges)
    end
    # Write your tests here.
end
