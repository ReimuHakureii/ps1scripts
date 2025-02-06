# Exercice 1 : Écriture conditionnelle au registre avec fenêtre de dialogue
# Retours possibles de la fonction $wshell.Popup(...):
# 6 : L'utilisateur a cliqué sur Oui.
# 7 : L'utilisateur a cliqué sur Non.
# -1 : Timeout ou fermeture de la boîte de dialogue sans réponse.

# Paramètres utilisés dans l'appel de $wshell.Popup(...):
# 1er paramètre : Le message à afficher dans la boîte de dialogue.
# 2e paramètre : Temps limite en secondes avant que la boîte se ferme automatiquement.
# 3e paramètre : Le titre de la fenêtre de dialogue.
# 4e paramètre : Type d'icône et de boutons (0x3 : Icône d'interrogation avec boutons Oui et Non).

Add-Type -AssemblyName System.Windows.Forms
$wshell = New-Object -ComObject Wscript.Shell
$reponse = $wshell.Popup("Voulez-vous pouvoir double-cliquer les .ps1 ?",30,"Modification du registre",0x3)

New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT

if ($reponse -eq 6) { # 6 = Oui
    Set-ItemProperty -Path "HKCR:\Microsoft.PowerShellScript.1\Shell\open\command" -Name '(Default)' -Value '"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -noLogo -ExecutionPolicy remotesigned -file "%1" "%*"'
    $wshell.Popup('Double-click ACTIVE !',10,'Information',0x0)
}
elseif ($reponse -eq 7) { # 7 = Non
    Set-ItemProperty -Path "HKCR:\Microsoft.PowerShellScript.1\Shell\open\command" -Name '(Default)' -Value ''
    $wshell.Popup('Double-click DESACTIVE !',10,'Information',0x0)
}
else { # Autre (Timeout ou Annuler)
    $dateTime = Get-Date -UFormat "%H:%M"
    $wshell.Popup("Il est $dateTime et tu n'as rien d'autre à faire ???",10,"Pas de Modification Au registre",0x0)
}
Remove-PSDrive HKCR