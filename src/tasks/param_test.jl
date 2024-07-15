"""
    run_parameter_test(param::AbstractString, param_range::AbstractVector; path::AbstractString="./")

Create directories for parameter testing and copy necessary files into each directory.

# Arguments
- `param::AbstractString`: The parameter to be tested.
- `param_range::AbstractVector`: A range or vector of values to test for the parameter.
- `path::AbstractString="./"`: The base path where the directories and files are located. Default is the current directory.
"""
function run_parameter_test(param, param_range; path="./")
    for value in param_range
        folder = param*"_"*value
        mkdir(path*folder)
        for file in ["KPOINTS", "POTCAR", "POSCAR"]
            if file in readdir(path)
                cp(path*file, path*folder*"/$file", force=true)
            end
        end
        set_keyword_in_incar!(param, value, path*"INCAR", out=path*folder*"/INCAR")
    end
end