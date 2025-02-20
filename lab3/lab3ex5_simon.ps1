# Définition du chemin du fichier contenant la liste des utilisateurs
$fichier = "C:\Users\kurom\Downloads\ListeUsagers.usr"

# Vérifie si le fichier ListeUsagers.usr existe
if (-not (Test-Path $fichier)) {
    Write-Host "Le fichier '$fichier' est introuvable."
    exit  # Arrête l'exécution du script si le fichier est absent
}

# Lecture du contenu du fichier ligne par ligne
$lignes = Get-Content $fichier
$comptesSupprimes = 0  # Compteur pour suivre le nombre de comptes supprimés

# Boucle à travers chaque ligne du fichier
foreach ($ligne in $lignes) {
    if ($ligne.Trim() -eq "") { continue }  # Ignore les lignes vides

    # Séparation des champs en utilisant '/' comme délimiteur
    $tabChamps = $ligne.Split('/')
    if ($tabChamps.Count -lt 1) {  # Vérifie que la ligne contient au moins un élément (le nom d'utilisateur)
        Write-Host "Ligne incorrecte : '$ligne'"
        continue
    }

    $UserName = $tabChamps[0]  # Extraction du nom d'utilisateur

    # Récupération des informations de l'utilisateur local
    $user = Get-LocalUser -Name $UserName -ErrorAction SilentlyContinue

    if ($null -eq $user) {
        Write-Host "Compte '$UserName' introuvable."  # Si l'utilisateur n'existe pas, afficher un message
    }
    else {
        # Vérifie si l'utilisateur ne s'est jamais connecté (LastLogon = null)
        if ($null -eq $user.LastLogon) {
            Remove-LocalUser -Name $UserName  # Suppression de l'utilisateur
            $comptesSupprimes++  # Incrémente le compteur de suppression
            Write-Host "Compte '$UserName' supprimé (aucune connexion détectée)."
        }
        else {
            # Affiche la dernière date de connexion si l'utilisateur a déjà utilisé le compte
            Write-Host "Compte '$UserName' conservé (dernière connexion : $($user.LastLogon))."
        }
    }
}