"""
    read_doscar(file::AbstractString)

Read the `DOSCAR` VASP output file and extract the density of states (DOS) data.

# Arguments
- `file::AbstractString`: The path to the `DOSCAR` file.

# Returns
- `dos::Array{Float64, 2}`: A transposed array where each row contains the energy and DOS values.
- `meta::Dict{String, Float64}`: A dictionary containing metadata from the `DOSCAR` file, including:
    - `"TEBEG"`: The initial temperature.
    - `"Nion"`: The number of ions.
    - `"Emax"`: The maximum energy.
    - `"Emin"`: The minimum energy.
    - `"NEDOS"`: The number of DOS points.
    - `"Ef"`: The Fermi energy.
"""
function read_doscar(file)
    lines = open_and_read(file)
    lines = split_lines(lines)
    meta = Dict()
    Emax, Emin, NEDOS, Ef, _ = parse.(Float64, lines[6])[1:5]
    meta["TEBEG"] = parse(Float64, lines[3][1])
    _, meta["Nion"] = parse.(Float64, lines[1])[1:2]
    meta["Emax"] = Emax; meta["Emin"] = Emin; meta["NEDOS"] = NEDOS
    meta["Ef"] = Ef
    dos = parse_lines_as_array(lines[7:Int(NEDOS)+6])
    return transpose(dos), meta
end

"""
    read_doscar_with_pdos(file::AbstractString)

Read the `DOSCAR` VASP output file and extract both the total density of states (DOS) and the projected density of states (PDOS) data.

# Arguments
- `file::AbstractString`: The path to the `DOSCAR` file.

# Returns
- `dos::Array{Float64, 2}`: A transposed array where each row contains the energy and DOS values.
- `pdos::Vector{Array{Float64, 2}}`: A vector of transposed arrays, each representing the PDOS for a specific ion, where each row contains the energy and PDOS values for different orbitals.
- `meta::Dict{String, Float64}`: A dictionary containing metadata from the `DOSCAR` file, including:
    - `"TEBEG"`: The initial temperature.
    - `"Nion"`: The number of ions.
    - `"Emax"`: The maximum energy.
    - `"Emin"`: The minimum energy.
    - `"NEDOS"`: The number of DOS points.
    - `"Ef"`: The Fermi energy.
"""
function read_doscar_with_pdos(file)
    lines = open_and_read(file)
    lines = split_lines(lines)
    meta = Dict()
    Emax, Emin, NEDOS, Ef, _ = parse.(Float64, lines[6])[1:5]
    meta["TEBEG"] = parse(Float64, lines[3][1])
    _, meta["Nion"] = parse.(Float64, lines[1])[1:2]
    meta["Emax"] = Emax; meta["Emin"] = Emin; meta["NEDOS"] = NEDOS
    meta["Ef"] = Ef
    dos = parse_lines_as_array(lines[7:Int(NEDOS)+6])
    pdos = Matrix{Float64}[]
    for i in 1:Int(meta["Nion"])
        ibegin = i*Int(NEDOS)+7+i
        iend = (i+1)*Int(NEDOS)+6+i
        push!(pdos, parse_lines_as_array(lines[ibegin:iend], i1=1, i2=10))
    end
    return transpose(dos), transpose.(pdos), meta
end