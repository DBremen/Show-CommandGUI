function Get-File($InitialDirectory, [switch]$AllowMultiSelect){  
    Add-Type -AssemblyName System.Windows.Forms
    $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $openFileDialog.InitialDirectory = $InitialDirectory
    $openFileDialog.ShowHelp = $true
    $openFileDialog.Filter = "All files (*.*)| *.*"
    if ($AllowMultiSelect) { $openFileDialog.MultiSelect = $true }
    $result = $openFileDialog.ShowDialog() 
    if ($result -eq [System.Windows.Forms.DialogResult]::OK){
        if ($allowMultiSelect) { 
            $openFileDialog.Filenames 
        } 
        else { 
            $openFileDialog.Filename 
        }
    }
}
