# Demande de saisie du nom de l'usager
$UserName = Read-Host "Entrez le nom d'usager à rechercher"

# Utilisation Get-LocalUser pour récupérer le compte local correspondant
$user = Get-LocalUser -Name $UserName -ErrorAction SilentlyContinue

# Quand l'usager n'est pas trouvé on affiche un message d'erreur
if ($null -eq $user) {
    Write-Host "Usager non trouvé !"
}
else {
    # Affichage du nom de l'usager et de la date/heure de sa dernière connexion
    Write-Host "Usager: $($user.Name)"
    Write-Host "Dernière connexion: $($user.LastLogon)"
}