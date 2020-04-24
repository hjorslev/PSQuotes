function Show-Quote {
    <#
    .SYNOPSIS
    Formats the quote nicely.

    .DESCRIPTION
    Cuts text to console-appropriate widths for viewing, where possible.

    .PARAMETER Content
    Enter a string.

    .PARAMETER Author
    Enter a string.

    .PARAMETER QuoteColor
    Choose a color for the quote.

    .EXAMPLE
    Show-Quote -Content 'Friendship at first sight, like love at first sight, is said to be the only truth.' -Author 'Herman Melville'

    .EXAMPLE
    Get-Quote | Show-Quote

    .INPUTS
    Show-Quote accepts pipeline input for the $Content parameter.

    .OUTPUTS
    Nothing. All output is sent only to the host / information stream.

    .NOTES
    Author: Joel Sallow (https://github.com/vexx32/PSKoans)

    This cmdlet is a rework of Write-ConsoleLine. The output is inspired by
    how the Koans are displayed in the PSKoans project.

    Modified by: Frederik Hjorslev Poulsen (https://github.com/hjorslev/PSQuotes)

    Modified: 24-04-2020
#>


    [CmdletBinding()]
    [OutputType([void])]
    param(
        [Parameter(Position = 0,
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Content,

        [Parameter(Position = 1,
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [string]$Author,

        [Parameter(Mandatory = $false)]
        [ConsoleColor]$QuoteColor
    )

    begin {
        Write-Host -Object ""
        $Prefix = "    $([char]0x258c)"

        if ($QuoteColor) {
            $Color = @{ ForegroundColor = [ConsoleColor]::$QuoteColor }
        } else {
            $Color = @{ ForegroundColor = [ConsoleColor]::Magenta }
        }

        $Width = $host.UI.RawUI.WindowSize.Width - ($Prefix.Length + 2)
    }

    process {
        # Ugly mode since width either not detectable or too small to bother
        if ($Width -lt 20) {
            Write-Host -Object $Content
        } else {
            $RemainingText = $Content.TrimEnd()

            while ($RemainingText.Length -gt $Width) {
                $CompleteLine = $RemainingText.Substring(0, $Width)
                $TailFragment = ($CompleteLine -split "[- ]")[-1].Length
                $BestFitLine = $CompleteLine.Substring(0, $CompleteLine.Length - $TailFragment).TrimEnd()

                Write-Host -Object ($Prefix + $BestFitLine) @Color

                $RemainingText = $RemainingText.Substring($CompleteLine.Length - $TailFragment)
            }
            if ([string]::IsNullOrWhiteSpace($Author)) {
                Write-Host -Object "$($Prefix + $RemainingText)`v`t$([char]0x2014) Anonymous" @Color
            } else {
                Write-Host -Object "$($Prefix + $RemainingText)`v`t$([char]0x2014) $($Author)" @Color
            }
        }
    } # Process
} # Cmdlet