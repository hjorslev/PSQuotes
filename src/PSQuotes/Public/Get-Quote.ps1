function Get-Quote {
    <#
    .SYNOPSIS
    Get an inspirational random quote.

    .DESCRIPTION
    Get an inspirational random quote from api.quotable.io.

    .EXAMPLE
    Get-Quote

    .EXAMPLE
    Get-Quote | Show-Quote

    Formats the quote nicely.

    .NOTES
    Author: Frederik Hjorslev Poulsen

    Modified: 24-04-2020
    #>

    [CmdletBinding()]
    param (
    )

    process {
        #region RandomQuote
        $RandomQuote = Invoke-RestMethod -Uri 'https://api.quotable.io/random'
        [PSCustomObject]@{
            ID      = $RandomQuote._id
            Tags    = $RandomQuote.tags
            Content = $RandomQuote.content
            Author  = $RandomQuote.author
            Length  = $RandomQuote.length
        }
        #endregion RandomQuote
    } # Process
} # Cmdlet