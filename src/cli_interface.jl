function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table s begin
        "task"
            help = "positional argument 1: task defines which task is to be performed"
            arg_type = String
            default = ""
        "--par"
            help = "define a parameter that is to be adapted"
            arg_type = String
            default = ""
        "--val"
            help = "define the value of the parameter"
            arg_type = String
            default = ""
        "--p"
            help = "set the default path"
            arg_type = String
            default = "~/"
    end
    args :: Dict{String, String} = parse_args(s)
    return args
end

function main()
    time = @elapsed begin
        @time args = parse_commandline()
        task = args["tasl"]
        println("Running task $task ...")
        @show typeof(args)
        println("Parsed args:")
        for (arg,val) in args
            println("  $arg  =>  $val")
        end
        if task == "testpar"
            run_parameter_test()
        end
        
        #file = String(args["file"])
        #if occursin("INCAR", file)
        #    @time incar = read_incar(file)
        #    @time set_keyword!(args["keyword"], args["value"], incar, comment=args["comment"], block_label=args["l"])
        #    @time write_incar(incar)
        #end
    end
    println("Time: $time s")
end