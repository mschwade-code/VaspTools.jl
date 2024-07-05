using VaspTools, Test

global test_file_path = string(@__DIR__) * "/test_files/"

include("test_incar.jl")

# Test eigenval parser
@testset "parser" begin
    include("parser/test_eigenval.jl")
    include("parser/test_doscar.jl")
    include("parser/test_poscar.jl")
end