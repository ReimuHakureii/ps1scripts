# Demande de saisie des informations à l'utilisateur
$UserName    = Read-Host "Entrez le nom d'usager"
$FullName    = Read-Host "Entrez le nom complet"
$Description = Read-Host "Entrez la description"

# Conversion de la chaîne tge en objet SecureString pour le mot de passe
$password = ConvertTo-SecureString "tge" -AsPlainText -Force

# Création du compte local
New-LocalUser -Name $UserName `
              -FullName $FullName `
              -Description $Description `
              -Password $password `
              # Le mot de passe ne va pas expirer
              -PasswordNeverExpires `
              # Le compte n'expire jamais
              -AccountNeverExpires `
              # L'utilisateur ne peut pas changer son mot de passe
              -UserMayNotChangePassword

# Ajout du nouvel usager au groupe Utilisateurs
Add-LocalGroupMember -Group "Utilisateurs" -Member $UserName

# Message de confirmation
Write-Host "Compte '$UserName' créé et ajouté au groupe Utilisateurs."