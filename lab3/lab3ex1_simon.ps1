# Exercice 1
Param(
    [Parameter(Mandatory = $true)]  # Le paramètre est obligatoire
    [string]$UserName              # Nom de l'usager à rechercher
)

# Utilisation de Get-LocalUser pour récupérer le compte local correspondant
$user = Get-LocalUser -Name $UserName -ErrorAction SilentlyContinue

# Si la variable $user est vide l'usager n'existe pas
if ($null -eq $user) {
    Write-Host "Usager non trouve !"
}
else {
    # Affichage du nom de l'usager
    Write-Host "Usager: $($user.Name)"
    # Affichage de la date et heure de la dernière connexion
    Write-Host "Dernière connexion: $($user.LastLogon)"
}