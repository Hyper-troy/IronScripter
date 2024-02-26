#     Begginer
# Write PowerShell code to take a string like ‘PowerShell’ and display it in 
# reverse. Your solution can be a simple script or function.

﻿#     Intermediate
# Your challenge is based on the Beginner exercise. Take a sentence like, “This
# is how you can improve your PowerShell skills,” and write PowerShell code to
# display the entire sentence in reverse with each word reversed. You should be
# able to encode and decode text. Ideally, your functions should take pipeline
# input.

function My-Reversal {
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$toReverse
    )

    $arrayK =  1..$toReverse.Length
    $counter =  $toReverse.Length
    $reversed = ""

    foreach ($array in $arrayK) {
        $counter--
        $reversed += $toReverse.chars($counter)
    }
write-host $reversed
}
