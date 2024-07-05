using VaspTools, Test

include("test_incar.jl")

# Test eigenval parser
@testset "parser" begin
    include("parser/test_eigenval.jl")
end