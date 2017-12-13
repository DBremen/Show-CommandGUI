function Get-Folder($InitialDirectory='MyDocuments'){
    Add-Type -AssemblyName System.Windows.Forms
    $openFolderDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $openFolderDialog.ShowNewFolderButton = $true
    $openFolderDialog.RootFolder = $InitialDirectory
    $result = $openFolderDialog.ShowDialog()
    if ($result -eq [System.Windows.Forms.DialogResult]::OK){
        $openFolderDialog.SelectedPath
    }
}