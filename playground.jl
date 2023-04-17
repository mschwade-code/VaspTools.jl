using VaspTools

@time blocks = read_incar("test/test_files/INCAR")
@time set_keyword!("ENCUT", "300", blocks)
@time write_incar(blocks)
@show blocks