module VaspTools

using OrderedCollections, ArgParse, Plots, BenchmarkTools

include("read_utils.jl")
include("parser/eigenval.jl"); include("parser/doscar.jl"); include("parser/poscar.jl"); include("parser/xdatcar.jl")
include("parser/incar.jl")

include("tasks/param_test.jl"); include("tasks/change_incar.jl")

export read_eigenval, read_doscar, read_incar, set_keyword!, write_incar, Poscar, read_poscar, write_poscar, read_xdatcar
export get_value_for_keyword, change_incar!
export write_to_file, read_from_file

export run_parameter_test

include("cli_interface.jl")

end # module
