dos, meta = read_doscar(test_file_path*"DOSCAR_mapbi3")

@test dos == read_from_file(test_file_path*"dos_mapbi3_correct.dat")

@testset "DOS Meta-Data" begin 
    @test meta["TEBEG"] == 1.000000000000000E-004
    @test meta["Nion"] == 12
    @test meta["Emax"] == 19.65343672
    @test meta["Emin"] == -20.43469034
    @test meta["NEDOS"] == 301
    @test meta["Ef"] == 1.51355922
end