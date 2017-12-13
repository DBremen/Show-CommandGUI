function Get-GroupedDynamicParameter {
    Param(
        [Parameter(ValueFromPipeline=$True,Mandatory=$true)]
        $Parameters
    )
    
    Begin{}
    Process{
        if ($_) {
            $Params = $_
        }
        else {
            $Params = $Parameters
        }
        $ParameterSetSelect = @(
            @{N='Count';E={$theseParams | Measure-Object | Select -ExpandProperty Count}},
            @{N='Name';e={if( -not $theseParams[0].ParameterSetName){'Default'}else{$theseParams[0].ParameterSetName}}},
            @{N='Group';e={$theseParams}}
        )
    
        $AllParamSets = $Params | Select @{N='ParameterSet';E={if( -not $_.ParameterSetName){'Default'}else{$_.ParameterSetName}}} -Unique | Select -ExpandProperty ParameterSet

        $AllParamSets | %{
            $ThisSet = $(
                if ($_ -eq 'Default') {
                    $null
                }
                else {
                    $_
                }
            )

            $theseParams = $Params | ? {$_.ParameterSetName -eq $ThisSet}
            $true | select $ParameterSetSelect
        }
    }
    End{}
}