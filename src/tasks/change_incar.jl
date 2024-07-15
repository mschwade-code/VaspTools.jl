"""
    change_incar!(keyword::AbstractString, value::AbstractString, file::AbstractString)

Modify the value of a specified keyword in the INCAR file.

# Arguments
- `keyword::AbstractString`: The keyword in the INCAR file whose value needs to be changed.
- `value::Any`: The new value to set for the specified keyword.
- `file::AbstractString`: The path to the INCAR file.

# Example
```julia
change_incar("ENCUT", 520, "INCAR")

This changes the value of the ENCUT keyword to 520 in the INCAR file located at the specified path.
"""
function set_keyword_in_incar!(keyword, value, file; out=file)
    incar = read_incar(file)
    set_keyword!(keyword, value, incar)
    write_incar(incar, out)
end