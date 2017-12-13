function test{
    [CmdletBinding(DefaultParameterSetName='Basic')]
    Param
    (
        [Parameter(Mandatory=$true, 
                   Position=0,
                   ParameterSetName='Basic')]
        [ValidateNotNullOrEmpty()]
        [ValidateSet("sun", "moon", "earth")] 
        [string]$choice,
        [ValidateRange(2,5)]
        $number,
        [ValidatePattern("^[a-z]")]
        [ValidateLength(2,5)]
        [String]$pattern,
        [ValidateScript({$_ -like '*test'})]
        $string,
        [Parameter(ParameterSetName='Advanced')]
        [switch]$switch,
        [Parameter(Mandatory=$true, ParameterSetName='Advanced')]
        $filePath = 'c:\test.txt',
        [Parameter(Mandatory=$true, ParameterSetName='Basic')]
        $folderPath = 'c:\'
    )
    "pattern: $pattern"
    "number: $number"
    "string: $string"
    if ($PSCmdlet.ParameterSetName -eq 'Advanced'){
        "switch: $switch"
        "filePath: $filePath"
    }
    else{
        "choice: $choice"
        "folderPath: $folderPath"
    }
}

Show-CommandGUI -command test
