#!/usr/bin/env nextflow

/*
 * Use echo to print 'Hello World!' to a file
 */
process sayHello {

    input:
    val greeting

    output:
    path "${greeting}-output.txt" //names output file(s) based on the input (dynamic naming); MUST be in doubel quotations

    script:
    """
    echo '${greeting}' > '${greeting}-output.txt'
    """
}

/*
 * Pipeline parameters
 */
params {
    input: Path = 'data/greetings.csv'
}

workflow {

    main:
    /*//array of input greetings
    greetings_array = ['Hello', 'Hola', 'Konnichiwa']
    //create channel for inputs (strings); queue designed to handle inputs efficiently and shuttle them from one step to another in multi-step workflows + providing parallelism, etc.
    greeting_ch = channel.of(greetings_array) //accepts multiple inputs; but only saves the last one to output.txt file, 'Kon nichiwa'; but saves all to the work sub-directories; -ansi-log flase CLI option disables this behavior and creates separate work sub-directories for each input
                         //.view() //inspects contents of channel (debugging tool, like Python print())
                         .view { greeting -> "Before flatten: $greeting" }
                         .flatten() //takes contents of an array and treates them as individual items; without this it treats the array, brackets and all, as a string
                         .view { greeting -> "After flatten: $greeting" }
    */

    //create channel for CSV file inputs
    greeting_ch = channel.fromPath(params.input)
                         .view { csv -> "Before flatten: $csv" }
                         .splitCsv()
                         .view { csv -> "After splitCsv: $csv" }
                         .map { row -> row[0] } //takes 0th item from row in the channel; flatten() wouldn't work here bc of it would flatten everything, not row by row
                         .view { csv -> "After map: $csv" }


    // emit a greeting
    sayHello(greeting_ch) //tells Nextflow to run sayHello process on contents of greeting_ch channel

    publish:
    first_output = sayHello.out
}

output {
    first_output {
        path 'hello_channels'
        mode 'copy'
    }
}
