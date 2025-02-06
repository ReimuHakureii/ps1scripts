# Exercice 1 : Écriture conditionnelle au registre avec fenêtre de dialogue
Add-Type -AssemblyName System.Windows.Forms
$wshell = New-Object -ComObject Wscript.Shell
$reponse = $wshell.Popup("Voulez-vous pouvoir double-cliquer les .ps1 ?",30,"Modification du registre",0x3)

New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT

if ($reponse -eq 6) { # 6 = Oui
    Set-ItemProperty -Path "HKCR:\Microsoft.PowerShellScript.1\Shell\open\command" -Name '(Default)' -Value '"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -noLogo -ExecutionPolicy remotesigned -file "%1" "%*"'
    [System.Windows.MessageBox]::Show('Double-click ACTIVE !')
}
elseif ($reponse -eq 7) { # 7 = Non
    Set-ItemProperty -Path "HKCR:\Microsoft.PowerShellScript.1\Shell\open\command" -Name '(Default)' -Value ''
    [System.Windows.MessageBox]::Show('Double-click DESACTIVE !')
}
else { # Autre (Timeout ou Annuler)
    $dateTime = Get-Date -UFormat "%H:%M"
    $wshell.Popup("Il est $dateTime et tu n'as rien d'autre à faire ???",10,"Pas de Modification Au registre",0x0)
}
Remove-PSDrive HKCR