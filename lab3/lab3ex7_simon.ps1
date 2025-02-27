# Demander le nom de l'usager à rechercher
$username = Read-Host "Entrez le nom de l'usager à rechercher"

# Vérifier que l'usager existe
$user = Get-LocalUser -Name $username -ErrorAction SilentlyContinue
if (!$user) {
    Write-Host "L'usager '$username' n'existe pas." -ForegroundColor Red
    exit
}

# Définir la liste des groupes locaux à vérifier
$groupes = @("Administrateurs", "Utilisateurs", "Invités", "Visiteurs", "Comptables")
$userGroupes = @()

# Pour chacun des groupes, vérifier si l'usager en fait partie
foreach ($groupe in $groupes) {
    # Récupérer les membres du groupe (en cas d'erreur, on passe au groupe suivant)
    $membres = Get-LocalGroupMember -Group $groupe -ErrorAction SilentlyContinue
    if ($membres) {
        foreach ($membre in $membres) {
            # Comparaison : on teste si le nom du membre correspond exactement ou se termine par "\$username"
            if ($membre.Name -eq $username -or $membre.Name -like "*\$username") {
                $userGroupes += $groupe
                break  # inutile de continuer à parcourir ce groupe
            }
        }
    }
}

# Afficher le résultat
Write-Host "`nL'usager '$username' fait partie des groupes suivants :"
if ($userGroupes.Count -eq 0) {
    Write-Host "Aucun des groupes vérifiés."
} else {
    foreach ($g in $userGroupes) {
        Write-Host "- $g"
    }
}