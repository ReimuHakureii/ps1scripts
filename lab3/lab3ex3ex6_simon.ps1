# Définir le chemin du fichier contenant la liste des usagers
$fichier = "C:\Users\kurom\Downloads\ListeUsagers.usr"
# Vérifier si le fichier existe
if (-Not (Test-Path $fichier)) {
    Write-Host "Le fichier '$fichier' est introuvable. Vérifiez le chemin."
    exit
}
# Lire toutes les lignes du fichier dans un tableau $lignes
$lignes = Get-Content $fichier
# MDP à utiliser pour tous les comptes
$password = ConvertTo-SecureString "tge" -AsPlainText -Force
# Parcourir chaque ligne pour créer les comptes
foreach ($ligne in $lignes) {
    # Vérifier que la ligne n'est pas vide (cas où il y aurait des lignes vides).
    if ($ligne.Trim() -eq "") {
        continue
    }
    # Séparer la ligne en quatre champs : Nom / NomComplet / Description / Groupe
    $tabChamps = $ligne.Split('/')
    # Vérifier que la ligne contient exactement quatre champs
    if ($tabChamps.Length -ne 4) {
        Write-Host "La ligne '$ligne' ne contient pas exactement quatre champs. Ignorée."
        continue
    }
    # Récupération des champs
    $UserName = $tabChamps[0]
    $FullName = $tabChamps[1]
    $Description = $tabChamps[2]
    $Groupe = $tabChamps[3]

    # Vérifier si l'usager existe déjà pour éviter les doublons.
    $existingUser = Get-LocalUser -Name $UserName -ErrorAction SilentlyContinue
    if ($null -eq $existingUser) {
        # Créer le compte local avec les propriétés demandées.
        New-LocalUser -Name $UserName -FullName $FullName -Description $Description -Password $password -PasswordNeverExpires -AccountNeverExpires -UserMayNotChangePassword

        # Ajouter l'usager au groupe spécifié | > EXERCICE 6 <
        Add-LocalGroupMember -Group "Users" -Member $UserName

        Write-Host "Compte '$UserName' créé et ajouté au groupe '$Groupe'."
    }
    else {
        Write-Host "Le compte '$UserName' existe déjà. Aucune action effectuée."
    }
    # Créer le groupe s'il n'existe pas | > EXERCICE 6 <
    $existingGroup = Get-LocalGroup -Name $Groupe -ErrorAction SilentlyContinue
    if ($null -eq $existingGroup) {
        New-LocalGroup -Name $Groupe
        Write-Host "Groupe '$Groupe' créé."
    }

    Add-LocalGroupMember -Group $Groupe -Member $UserName -ErrorAction SilentlyContinue
    Write-Host "Compte '$UserName' ajouté au groupe '$Groupe'."
}