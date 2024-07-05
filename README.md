# VaspTools.jl

`VaspTools.jl` is a Julia package designed to streamline the analysis of VASP (Vienna Ab initio Simulation Package) output files. It provides a comprehensive suite of tools for parsing and visualizing data from VASP calculations, including electronic structure, band structure, density of states, and more. With a focus on ease of use and performance, VaspTools.jl leverages Julia's capabilities to handle large datasets efficiently, making it an essential tool for computational materials scientists and researchers. Whether you're conducting routine analysis or developing custom workflows, VaspTools.jl offers the flexibility and functionality needed to enhance your VASP data analysis experience.

## Parsing

### DFT Eigenvalues

Here's an example of how to to read the EIGENVAL file from a VASP calculation and extract the k-points and energy bands:

```
using vasptools

# Define the path to the EIGENVAL file
eigenval_path = "path/to/EIGENVAL"

# Read the EIGENVAL file
kpoints, E_bands, occs = read_eigenval(eigenval_path)
```