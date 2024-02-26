# Write PowerShell code to take a string like ‘PowerShell’ and display it in reverse. Your solution can be a simple script or function.

function My-Reversal {
    param(
        [Parameter(Mandatory = $true)]
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
