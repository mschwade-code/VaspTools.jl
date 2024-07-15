function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table s begin
        "task"
            help = "positional argument 1: task defines which task is to be performed"
            arg_type = String
            default = "none"
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
            default = "./"
        "--incar"
            help = "set the name of the INCAR file"
            arg_type = String
            default = "INCAR"
    end
    args :: Dict{String, String} = parse_args(s)
    return args
end

function main()
    time = @elapsed begin
        @time args = parse_commandline()
        task = args["task"]
        println("Running task $task ...")
        @show typeof(args)
        println("Parsed args:")
        for (arg,val) in args
            println("  $arg  =>  $val")
        end
        if task == "testpar"
            run_parameter_test(args["par"], split(args["val"], ","); path=args["p"])
        elseif task == "set"
            set_keyword_in_incar!(args["par"], args["val"], args["p"]*args["incar"])
        elseif task == "none"
            println("Task is none. Exiting ...")
        end
    end
    println("Time: $time s")
end