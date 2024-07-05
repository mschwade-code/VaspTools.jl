poscar = read_poscar(test_file_path*"POSCAR_gaas")

@testset "GaAs POSCAR Parameters" begin
    @test poscar.a == 5.65
    @test poscar.atom_names == ["Ga", "As"]
    @test poscar.lattice == [2.825 2.825 0.0; 0.0 2.825 2.825; 2.825 0.0 2.825]
    @test poscar.rs_atom == [0.0 0.25; 0.0 0.25; 0.0 0.25]
    @test poscar.atom_numbers == [1, 1]
    @test poscar.atom_types == ["Ga", "As"]
end