#!/usr/bin/env nextflow

/*
 * Use echo to print 'Hello World!' to a file
 */
process sayHello {

    input:
    val greeting //tells Nextflow this is a value (not a path)

    output:
    path 'output.txt'

    script:
    """
    echo '${greeting}' > output.txt
    """
    //${} tells Nextflow this is a variable name that needs to be replaced with actual input (interpolation)
}

/*
*Pipeline parameters
*/
params{
    input: String = 'Kon nichiwa sekai!' //sets default value to input param; param defined on CLI will override this
}

workflow {

    main:
    // emit a greeting
    sayHello(params.input)
    //params.<param_name> tells Nextflow to expect a --<param_name> on CLI; params.input creates a parameter named --input

    publish:
    //declares process output
    first_output = sayHello.out
}

//specifies output options (eg. mode, directory/location); declares the expected output from process (doesn't determine what output will be created)
output {
    first_output {
        path 'hello_world'
        mode 'copy' //sets publish mode for this output; default is symbolic link
    }
}
