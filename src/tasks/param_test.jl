function run_parameter_test(param, param_range; path="~/")
    for value in param_range
        folder = param*"_"*value
        mkdir(path*folder)
        cp(path*"KPOINTS", path*folder*"/KPOINTS", force=true)
        cp(path*"POTCAR", path*folder*"/POTCAR", force=true)
        cp(path*"POSCAR", path*folder*"/POSCAR", force=true)
        incar = read_incar(path*"INCAR")
        set_keyword!(param, value, incar)
        write_incar(incar, path*folder*"/INCAR")
    end
end