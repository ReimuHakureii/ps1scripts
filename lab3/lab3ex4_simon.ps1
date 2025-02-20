# Demande de saisie du nom de l'usager à supprimer
$UserName = Read-Host "Entrez le nom d'usager à supprimer"

# Importation des fonctions pour gérer les boîtes de dialogue
Add-Type -AssemblyName System.Windows.Forms

# Récupération du compte usager.
$user = Get-LocalUser -Name $UserName -ErrorAction SilentlyContinue

# Si l'usager n'existe pas, on affiche un message et on termine le script
if ($null -eq $user) {
    Write-Host "Usager non trouve !"
    exit
}

# Affichage des informations de l'usager
Write-Host "Usager: $($user.Name)"
Write-Host "Dernière connexion: $($user.LastLogon)"

# Affichage d'une boîte de dialogue pour demander la confirmation de suppression
$result = [System.Windows.Forms.MessageBox]::Show("Voulez-vous vraiment supprimer l'usager '$UserName' ?", "Confirmation", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)

# Si l'utilisateur clique sur "Oui", suppression du compte
if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
    Remove-LocalUser -Name $UserName
    Write-Host "Usager '$UserName' supprimé."
}
else {
    Write-Host "Suppression annulée."
}