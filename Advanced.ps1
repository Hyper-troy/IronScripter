# Advanced
# Once you’ve accomplished the intermediate-level task, create a PowerShell
# script to display a WPF form. The form should have a place where the user can
# enter a plaintext or encoded string and then buttons to encode or decode. The
# encoded or decoded value should be displayed in the form and copied to the
# clipboard. For bonus points, toggle upper and lower case when reversing the
# word. For example, ‘Shell’ should become ‘LLEHs.’

Add-Type -AssemblyName PresentationFramework

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="String Reversal" Height="200" Width="400">
    <Grid>
        <TextBox Name="txtInput" HorizontalAlignment="Left" Height="23" Margin="10,10,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="200"/>
        <TextBox Name="txtOutput" HorizontalAlignment="Left" Height="23" Margin="10,50,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="200"/>
        <Button Content="Reverse" HorizontalAlignment="Left" Margin="10,90,0,0" VerticalAlignment="Top" Width="75" Name="btnReverse"/>
        <CheckBox Content="Toggle Case" HorizontalAlignment="Left" Margin="10,130,0,0" VerticalAlignment="Top" Name="chkToggleCase"/>
    </Grid>
</Window>
"@

$reader = New-Object System.Xml.XmlNodeReader $xaml
$window = [Windows.Markup.XamlReader]::Load($reader)

$btnReverse = $window.FindName("btnReverse")
$txtInput = $window.FindName("txtInput")
$txtOutput = $window.FindName("txtOutput")
$chkToggleCase = $window.FindName("chkToggleCase")

function My-Reversal {
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$toReverse,
        [switch]$ReverseCase
    )

    $arrayK =   1..$toReverse.Length
    $counter =  $toReverse.Length
    $reversed = ""

    foreach ($array in $arrayK) {
        $counter--
        $reversed += $toReverse.chars($counter)
    }

    if ($ReverseCase) {
        $reversed = $reversed.ToCharArray() | ForEach-Object {
            if ([char]::IsUpper($_)) {
                [char]::ToLower($_)
            } else {
                [char]::ToUpper($_)
            }
        }       
    }

    return $reversed -join ""
}

$btnReverse.Add_Click({
    $input = $txtInput.Text
    $reversed = $input | My-Reversal -ReverseCase:$chkToggleCase.IsChecked
    $txtOutput.Text = $reversed
    $reversed | Set-Clipboard
})

$window.ShowDialog()
