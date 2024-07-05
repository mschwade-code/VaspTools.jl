xdatcar = read_xdatcar(test_file_path*"XDATCAR_gaas")

@testset "XDATCAR GaAs" begin
    @test xdatcar.lattice == [5.65 0.0 0.0; 0.0 5.65 0.0; 0.0 0.0 5.65]
    @test xdatcar.configs == read_from_file(test_file_path*"configs_gaas_correct.dat")
end