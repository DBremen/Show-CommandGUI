function Get-DynamicParameter {
    Param(
        [Parameter(ValueFromPipeline=$True,Mandatory=$true)]
        [ValidateScript({$_.GetType() -in @([System.Management.Automation.FunctionInfo],[System.Management.Automation.CmdletInfo])})]$Command
    )
    (
        $Command | Get-Help
        #Get-help Disable-IAIUser
    ).Syntax.syntaxItem.parameter | ?{
        $_.name -notin @('WhatIf','Confirm')
    } | Format-DynamicParameter
}