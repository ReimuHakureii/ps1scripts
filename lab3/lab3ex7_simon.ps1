# Demander le nom de l'usager à rechercher
$UserName = Read-Host "Entrez le nom de l'usager à rechercher"

# Vérifier si l'utilisateur existe
$user = Get-LocalUser -Name $UserName -ErrorAction SilentlyContinue
if ($null -eq $user) {
    Write-Host "Usager '$UserName' non existant."
    exit
}

# Liste des groupes des groupes à vérifier
$groupesCibles = @("Administrateurs", "Utilisateurs", "Invités", "Visiteurs", "Comptables")
$userGroupMembership = @()

# Vérifier si l'usager est membre des groupes cibles
foreach ($grp in $groupesCibles) {
    $group = Get-LocalGroup -Name $grp -ErrorAction SilentlyContinue
    if ($group) {
        $membres = Get-LocalGroupMember -Group $grp -ErrorAction SilentlyContinue
        if ($membres -and ($membres | Where-Object { $_.Name -eq $UserName })) {
            $userGroupMembership += $grp
        }
    }
}

# Afficher les résultats
if ($userGroupMembership.Count -eq 0) {
    Write-Host "L'usager '$UserName' n'est membre d'aucun groupe cible."
} else {
    Write-Host "L'usager '$UserName' est membre des groupes suivants :"
    $userGroupMembership | ForEach-Object { Write-Host "- $_" }
}