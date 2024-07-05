using VaspTools, BenchmarkTools, Plots




@time blocks = read_incar("test/test_files/INCAR")

blocks
@time set_keyword!("ENCUT", "350", blocks)
@time write_incar(blocks)
@show blocks

kp, Es, occs = read_eigenval("test/test_files/EIGENVAL_gaas")

poscar = read_xdatcar("test/test_files/POSCAR_gaas")

@show poscar.Rs

write_to_file(dos, "test/test_files/dos_mapbi3_correct")

Es == VaspTools.read_from_file("Es_correct.dat")

@show occs[:, 1]

band_plot = plot(title="Band Structure", xlabel="k-point index", ylabel="Energy (eV)", legend=false)
for i in axes(Es, 1)
    plot!(band_plot, 1:80, Es[i, :])
end
display(band_plot)

#display()