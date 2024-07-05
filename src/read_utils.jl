"""
    open_and_read(file::AbstractString) -> Vector{String}

Open a file, read all lines, and return them as a vector of strings.

# Arguments
- `file::AbstractString`: The path to the file to be read.

# Returns
- `lines::Vector{String}`: A vector where each element is a line from the file.
"""
function open_and_read(file)
    f = open(file)
    lines = readlines(f)
    close(f)
    return lines
end

"""
    split_lines(lines::Vector{String}) -> Vector{Vector{String}}

Split each line of the input vector of strings into its constituent non-empty elements.

# Arguments
- `lines::Vector{String}`: A vector of strings, where each string represents a line to be split.

# Returns
- `split_lines::Vector{Vector{String}}`: A vector of vectors of strings, where each inner vector 
contains the non-empty elements of the corresponding line from the input.
"""
function split_lines(lines)
    split_lines = Vector{Vector{String}}(undef, length(lines))
    Threads.@threads for l in eachindex(lines)
        split_elements = String[]
        @views for element in split(lines[l], " ")
            if element ≠ ""; push!(split_elements, element); end
        end
        split_lines[l] = split_elements
    end
    return split_lines
end

"""
    parse_lines_as_array(line; i1, i2, type)
Parse `lines` as a 2d array of `type` starting from index `i1` ending at `i2` in
each line.
"""
function parse_lines_as_array(lines; i1=1, i2=3, type=Float64)
    Nj = length(lines); Ni = length(i1:i2)
    array = Array{type, 2}(undef, Nj, Ni)
    for (j, line) in enumerate(lines)
        array[j, :] = parse.(type, line[i1:i2])
    end
    return array
end

"""
    next_line_with(keywords, lines)
Find the next line in lines that contains a set of keywords.
"""
function next_line_with(keywords::AbstractArray, lines)
    index = false; keyline = false
    for (i, line) in enumerate(lines)
        if all(keyword->keyword in line, keywords)
            index = i
            keyline = line
            return index, keyline
        end
    end
end

next_line_with(s::String, lines) = next_line_with([s], lines)

"""
    write_to_file(M, filename)

Write the Array `M` and shape to a new file with name `filename`.
"""
function write_to_file(M, filename)
    file = open(filename*".dat", "w")
    print(file, "   "); for k in 1:length(size(M)); print(file, size(M, k), "  "); end; print(file, "\n")
    for e in collect(Iterators.flatten(M))
        println(file, e)
    end
    close(file)
end

"""
    read_from_file(filename, type)

Read an Array `M` with elements of `type` from the file with name `filename`.
"""
function read_from_file(filename; type=Float64)
    lines = open_and_read(filename)
    Ns = Tuple(parse.(Int64, filter!(el->el≠"", split(lines[1], " "))))
    M = parse.(type, lines[2:end])
    return reshape(M, Ns)
end