function New-PoshSelectStatement {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string[]]$PropertyList,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [string[]]$ExclusionList,
        [Parameter(Mandatory=$false)]
        [hashtable]$Lookup
    )
    [string[]]$keys = $(
        if (-not ([string]::isNullOrEmpty(($Lookup.Keys)))){
            $Lookup.Keys
        } else {
            @()
        }
    )

    [string[]]$Exclude = $(
        if (-not ([string]::isNullOrEmpty($ExclusionList))){
            $ExclusionList
        } else {
            $()
        }
    )

    $PropertyList | %{
        if ($_ -in $keys){
            $Lookup[$_]
        } else {
            if ($_ -notin $Exclude){
                $_
            }
        }
    }
}
