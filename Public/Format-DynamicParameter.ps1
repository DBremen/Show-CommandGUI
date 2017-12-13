function Format-DynamicParameter {
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline=$True,Mandatory=$true)]
        [object]$InputObject,
        [Parameter(ValueFromPipeline=$false,Mandatory=$false)]
        [string[]]$ExclusionList = @('parameterValue','isDynamic','defaultValue','required','aliases','type','Position','pipelineInput','globbing'),
        [Parameter(ValueFromPipeline=$false,Mandatory=$false)]
        [hashtable]$SelectLookup = @{
            required = @{N='Mandatory';E={[bool]::Parse($_.required)}}
            position = @{N='Position';E={$_.position}}
            defaultValue = @{N='Default';E={$_.defaultValue}}
            type = @{N='Type';e={iex "[$(if('SwitchParameter' -eq $_.type.name){'Switch'}else{$_.type.name})]"}}
            parameterValueGroup = @{N='ValidateSet';e={$_.parameterValueGroup.parameterValue}}
        }
    )
    Begin{}
    Process{
    $Param = $(
        if ($_){
            $_
        } else {
            $InputObject
        }
    )
    $SelectProperties = @{
        PropertyList = ((($Param | Get-Member -MemberType Properties | select -ExpandProperty Name) + 'defaultValue') | select -Unique)
        ExclusionList = $ExclusionList
        Lookup = $SelectLookup
    }
    
    $Param | select (New-PoshSelectStatement @SelectProperties)
    }
    End{}
}