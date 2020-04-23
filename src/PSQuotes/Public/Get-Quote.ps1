function Get-Quote {
    [CmdletBinding()]
    param (

    )

    process {
        $RandomQuote = Invoke-RestMethod -Uri 'https://api.quotable.io/random'
        if ([string]::IsNullOrWhiteSpace($RandomQuote.author)) {
            $Quote = "$($RandomQuote.content)`v`t$([char]0x2014) Anonymous"
            Write-Host -Object ($Quote -replace '^|\r?(\n)', ('$1    {0} ' -f [char]0x258c)) -ForegroundColor Magenta
        } else {
            $Quote = "$($RandomQuote.content)`v`t$([char]0x2014) $($RandomQuote.author)"
            Write-Host -Object ($Quote -replace '^|\r?(\n)', ('$1    {0} ' -f [char]0x258c)) -ForegroundColor Magenta
        }
    } # Process
} # Cmdlet