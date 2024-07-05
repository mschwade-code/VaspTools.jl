"""
    struct Xdatcar

A structure to represent the data contained in a VASP XDATCAR file.

# Fields
- `lattice::Array{Float64, 2}`: A 3x3 array representing the lattice vectors.
- `configs::Array{Float64, 3}`: A 3xNionxNconfig array where each slice `configs[:, :, j]` represents the atomic positions for configuration `j`.
"""
struct Xdatcar
    lattice :: Array{Float64, 2}
    configs :: Array{Float64, 3}
end

Xdatcar(path_to_xdatcar::AbstractString) = read_xdatcar(path_to_xdatcar)

"""
    read_xdatcar(xdatcar::AbstractString) -> Xdatcar

Read the configurations in the `xdatcar` file and store them in an `Xdatcar` object.

# Arguments
- `xdatcar::AbstractString`: The path to the XDATCAR file.

# Returns
- `Xdatcar`: An `Xdatcar` object containing the lattice vectors and configurations.
"""
function read_xdatcar(xdatcar::AbstractString)
    lines = open_and_read(xdatcar)
    lines = split_lines(lines)

    # Scaling parameter
    a = parse(Float64, lines[2][1])

    # Lattice vectors
    lattice = a .* parse_lines_as_array(lines[3:5], i1=1, i2=3)

    # Number of ions
    Nion = sum(parse.(Int64, lines[7]))

    # Find starting line of configurations
    i_start, _ = next_line_with("Direct", lines)

    # Calculate the number of configurations
    L = length(lines)
    Nconfig = Int((L - i_start + 1) / (Nion + 1))

    # Initialize the configurations array
    configs = zeros(Float64, 3, Nion, Nconfig)

    # Parse the configurations
    for j in 1:Nconfig, i in 1:Nion
        k = j + i_start + Nion * (j - 1) + i - 1
        configs[:, i, j] = parse.(Float64, lines[k][1:3])
    end

    return Xdatcar(lattice, configs)
end
