function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table s begin
        "file"
            help = "file which is to be read."
            arg_type = String
            default = ""
        "keyword"
            help = "positional argument number 1"
            arg_type = String
            default = ""
        "value"
            help = "positional argument number 2"
            arg_type = String
            default = ""
        "comment"
            help = "positional argument number 3"
            arg_type = String
            default = ""
        "--l"
            help = "label"
            arg_type = String
            default = ""
    end
    args :: Dict{String, String} = parse_args(s)
    return args
end

function main()
    time = @elapsed begin
        @time args = parse_commandline()
        @show typeof(args)
        println("Parsed args:")
        for (arg,val) in args
            println("  $arg  =>  $val")
        end
        file = String(args["file"])
        if occursin("INCAR", file)
            @time incar = read_incar(file)
            @time set_keyword!(args["keyword"], args["value"], incar, comment=args["comment"], block_label=args["l"])
            @time write_incar(incar)
        end
    end
    println("Time: $time s")
end