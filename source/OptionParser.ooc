import structs/[ArrayList, HashMap]
import Error

OptionParser: class{
    errorHandler : ThrowableError

    actions := HashMap<String, Func(String)> new()

    init: func(ExitOnError: Bool = false) {
        if(ExitOnError) { errorHandler = Error new() } 
        else { errorHandler = Warning new() }
        actions add("default", func(x:String){})
    }

    isShortArg?: func(arg: String) -> Bool { arg startsWith?("-") && !arg startsWith?("--") }
    isLongArg?: func(arg: String) -> Bool { arg startsWith?("--") }

    addOpt: func(arg: String, f: Func(String)){
        if(!validOpt(arg)){ 
            errorHandler throw(arg) 
            return 
        }

        if(actions contains?(arg)) actions[arg] = f
        else actions add(arg, f)
    }

    validOpt: func(arg: String) -> Bool {
        match {
            case isLongArg?(arg) => !arg contains?('=')
            case isShortArg?(arg) => arg size == 2
            case => false
        }
    }

    parseOpt: func(arg: String){
        match {
            case isLongArg?(arg) => 
                argoffset := arg indexOf('=') == -1 ? arg size : arg indexOf('=')
                realArg := arg substring(0, argoffset)
                if(actions contains?(realArg)){
                    actions get(realArg)(arg substring(argoffset + 1, arg size))
                } else {
                    errorHandler throw(realArg)
                }

            case isShortArg?(arg) =>
                realArg := arg substring(0, 2)
                if(actions contains?(realArg)){
                    actions get(realArg)(arg substring(2, arg size))
                } else {
                    errorHandler throw(realArg)
                }

            case => actions get("default")(arg)
        }
    }

    parse: func(args: ArrayList<String>){
        for(argz in args){
            parseOpt(argz)
        }
    }
}
