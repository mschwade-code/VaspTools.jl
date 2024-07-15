using VaspTools, Test

global test_file_path = string(@__DIR__) * "/test_files/"

# Test eigenval parser
@testset "parser" begin
    include("parser/test_eigenval.jl")
    include("parser/test_doscar.jl")
    include("parser/test_poscar.jl")
    include("parser/test_xdatcar.jl")
    include("parser/test_incar.jl")
end

@testset "tasks" begin
    include("tasks/param_test/test_param_test.jl")
end