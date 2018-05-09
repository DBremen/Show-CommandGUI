#check whether mandatory controls on the selected tab of the tab control are filled
function Assert-MandatoryTabControls($tabControl){
    $isValid = $true
    $tabMandatoryControls = ($tabControl.Items | where {$_.isSelected}).Content.Children | where {$_.ToolTip -match 'Mandatory'}
    $count=0
   
    foreach ($control in $tabMandatoryControls){
        $count++
        if ($control -is [System.Windows.Controls.TextBox]){
            if ($control.Text.Length -eq 0){
                $isValid = $false
                break
            }
        }
        elseif ($control -is [System.Windows.Controls.ComboBox]){
            if ($control.SelectedIndex -eq -1){
                $isValid = $false
                break
            }
        }
    }
    return $isValid

}