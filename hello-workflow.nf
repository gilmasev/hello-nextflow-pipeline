#!/usr/bin/env nextflow

/*
 * Use echo to print 'Hello World!' to a file
 */
process sayHello {

    input:
    val greeting

    output:
    path "${greeting}-output.txt"

    script:
    """
    echo '${greeting}' > '${greeting}-output.txt'
    """
}

process convertToUpper { //requires adding a block to workflow for the new process
    input:
    path input_file

    output:
    path "UPPER-${input_file}" //MUST be in doubel quotations

    script:
    """
    cat '${input_file}' | tr '[a-z]' '[A-Z]' > 'UPPER-${input_file}'
    """
    //tr = UNIX text replacement; this code converts all file contents to UPPER case
}

process collectGreetings {
    input:
    path input_files

    output:
    path "COLLECTED-output.txt"

    script:
    """
    cat ${input_files} > 'COLLECTED-output.txt'
    """
}

process batching {
    input:
    path input_files
    val batch_name

    output:
    path "COLLECTED-${batch_name}-output.txt"

    script:
    """
    cat ${input_files} > 'COLLECTED-${batch_name}-output.txt'
    """
}

process count_greetings{
input:
path input_files
val batch_name

output:
path "counted-${batch_name}-output.txt", emit: outfile
path "${batch_name}-report.txt", emit: report

script:
total_greetings = input_files.size() //gets the number of files in input_files array
"""
cat ${input_files} > 'counted-${batch_name}-output.txt'
echo 'There were ${total_greetings} greetings in this batch.' > '${batch_name}-report.txt'
"""
}

/*
 * Pipeline parameters
 */
params {
    input: Path = 'data/greetings.csv'
    batch: String = 'batch' //can override default value by specifying on CLI --batch
}

workflow {

    main:
    // create a channel for inputs from a CSV file
    greeting_ch = channel.fromPath(params.input)
                        .splitCsv()
                        .map { line -> line[0] }
    // emit a greeting
    sayHello(greeting_ch)
    // convert greeting to UPPERcase

    convertToUpper(sayHello.out)
    //convertToUpper.out.view { contents -> "Before collect: $contents" }

    //collect all greetings into one file
    collectGreetings(convertToUpper.out.collect())
    //convertToUpper.out.collect().view { contents -> "After collect: $contents" }

    //batch
    batching(convertToUpper.out.collect(), params.batch) //to provide multiple inputs into a process, list them in the call parantheses, separated by commas, and in the same order as they are listed in the definition block of the process

    //count greetings
    count_greetings(convertToUpper.out.collect(), params.batch)


    publish:
    first_output = sayHello.out
    uppercased = convertToUpper.out
    collected = collectGreetings.out
    batch_report = count_greetings.out.report
}

output {
    first_output {
        path 'hello_workflow'
        mode 'copy'
    }
    uppercased {
        path 'hello_workflow'
        mode 'copy'
    }
    collected {
        path 'hello_workflow'
        mode 'copy'
    }

    batch_report {
        path 'hello_workflow'
        mode 'copy'
    }
}
