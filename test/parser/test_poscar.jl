poscar = read_poscar(test_file_path*"POSCAR_gaas")

@testset "GaAs POSCAR Read" begin
    @test poscar.a == 5.65
    @test poscar.atom_names == ["Ga", "As"]
    @test poscar.lattice == [2.825 2.825 0.0; 0.0 2.825 2.825; 2.825 0.0 2.825]
    @test poscar.rs_atom == [0.0 0.25; 0.0 0.25; 0.0 0.25]
    @test poscar.atom_numbers == [1, 1]
    @test poscar.atom_types == ["Ga", "As"]
end

write_poscar(poscar)
poscar2 = read_poscar("POSCAR")
@testset "GaAs POSCAR Write" begin
    @test poscar2.a == 1.00
    @test poscar2.atom_names == ["Ga", "As"]
    @test poscar2.lattice == [2.825 2.825 0.0; 0.0 2.825 2.825; 2.825 0.0 2.825]
    @test poscar2.rs_atom == [0.0 0.25; 0.0 0.25; 0.0 0.25]
    @test poscar2.atom_numbers == [1, 1]
    @test poscar2.atom_types == ["Ga", "As"]
end

rm("POSCAR")