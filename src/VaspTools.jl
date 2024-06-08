module VaspTools

using OrderedCollections, ArgParse, Plots

include("read_utils.jl")
include("files/read_eigenval.jl")
include("incar.jl")

export read_eigenval, read_incar, set_keyword!, write_incar

include("cli_interface.jl")

end # module
