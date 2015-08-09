import os/Terminal 

ThrowableError: abstract class{
    message: String
    init: func()
    throw: abstract func(option: String)
}

Warning: class extends ThrowableError {
    init: func

    throw: func(option: String){
        Terminal setFgColor(Color yellow)
        "Invalid Option: %s" printfln(option)
        Terminal reset()
    }
}

Error: class extends ThrowableError {
    init: func 

    throw: func(option: String) {
        Terminal setFgColor(Color red)
        "Invalid Option: %s, Interrupted." printfln(option)
        Terminal reset()
        exit(1)
    }
}
