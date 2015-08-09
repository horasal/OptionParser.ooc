use OptionParser
import structs/ArrayList

main: func(args: ArrayList<String>) -> Int{
    op := OptionParser new()
    // add new options
    op addOpt("-T", |x| "got short parameter: %s" printfln(x))
    op addOpt("--test", |x| "got long praameter: %s" printfln(x))

    // default action (for any thing than do not start with "-", "--" or extra sep
    op addOpt("default", |x| "default filename: %s" printfln(x))

    op parse(args)

    0
}
