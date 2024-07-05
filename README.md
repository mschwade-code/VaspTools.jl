# VaspTools.jl

`VaspTools.jl` is a Julia package designed to streamline the analysis of VASP (Vienna Ab initio Simulation Package) output files. It provides a comprehensive suite of tools for parsing and visualizing data from VASP calculations, including electronic structure, band structure, density of states, and more. With a focus on ease of use and performance, `VaspTools.jl` leverages Julia's capabilities to handle large datasets efficiently.

## Parsing

### DFT Eigenvalues

Here's an example of how to read the EIGENVAL file from a VASP calculation and extract the k-points, energy bands and occupancies:

```julia
using VaspTools

# Define the path to the EIGENVAL file
eigenval_path = "path/to/EIGENVAL"

# Read the EIGENVAL file
kpoints, E_bands, occs = read_eigenval(eigenval_path)
```

### DFT Density of States (DOS)

To read the DOSCAR file and extract the density of states:

```julia
doscar_path = "path/to/DOSCAR"

# Read the DOSCAR file
dos, meta = read_doscar(doscar_path)
```