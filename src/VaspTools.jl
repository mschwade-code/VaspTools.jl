module VaspTools

using OrderedCollections, ArgParse, Plots

include("read_utils.jl")
include("parser/eigenval.jl"); include("parser/doscar.jl"); include("parser/poscar.jl"); include("parser/xdatcar.jl")
include("incar.jl")

export read_eigenval, read_doscar, read_incar, set_keyword!, write_incar, Poscar, read_poscar, write_poscar, read_xdatcar
export write_to_file, read_from_file

include("cli_interface.jl")

end # module
