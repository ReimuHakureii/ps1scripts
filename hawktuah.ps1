# Script à nommer lab2ex1_VotreNom.ps1

# Ajout du type AssemblyName du module System.Windows.Forms pour les boîtes de dialogue
Add-Type -AssemblyName System.Windows.Forms

# Création d'un objet boîte de dialogue
$wshell = New-Object -ComObject Wscript.Shell

# Appel de la boîte. La réponse est placée dans $reponse. La réponse est un nombre selon le bouton pressé.
$reponse = $wshell.Popup("Voulez-vous pouvoir double-cliquer les .ps1 ?", 30, "Modification du registre", 0x3)

# Création d’un lien vers l’utilisation des entrées du registre
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT

if ($reponse -eq 6) { # Test si on VEUT pouvoir double-cliquer
    # Attribution à la propriété (default) de la ligne de commande nécessaire
    Set-ItemProperty -Path "HKCR:\Microsoft.PowerShellScript.1\Shell\open\command" -name '(Default)' `
        -Value '"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -noLogo -ExecutionPolicy remotesigned -file "%1" %*'
    # Utilisation de Popup pour afficher un message
    $wshell.Popup('Double-click ACTIVE !', 10, 'Information', 0x0)
}
elseif ($reponse -eq 7) { # Test si on NE VEUT PAS double-cliquer
    # Attribution à la propriété (default) de la ligne de commande vide
    Set-ItemProperty -Path "HKCR:\Microsoft.PowerShellScript.1\Shell\open\command" -name '(Default)' -Value ''
    # Utilisation de Popup pour afficher un message
    $wshell.Popup('Double-click DESACTIVE !', 10, 'Information', 0x0)
}
elseif ($reponse -eq -1) { # Test si on NE FAIT RIEN
    # Obtention de l'heure et des minutes
    $dateTime = Get-Date -UFormat "%H : %M"
    # Fenêtre de dialogue avec message concaténé et délais de 10 secondes
    $wshell.Popup("Il est $dateTime et tu n'as rien d'autre à faire ???", 10, "Pas de Modification Au registre", 0x0)
}

# Destruction du lien vers le registre
Remove-PSDrive HKCR
