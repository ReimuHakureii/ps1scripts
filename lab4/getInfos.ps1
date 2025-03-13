# Option bonus
Add-Type -AssemblyName Microsoft.VisualBasic
$username = [Microsoft.VisualBasic.Interaction]::InputBox("Entrez le nom d'utilisateur :", "Saisie d'utilisateur", "")
if ([string]::IsNullOrEmpty($username)) {
    Write-Host "Aucun utilisateur saisi."
    exit
}


# Utilisation de Read-Host (obligatoire)
$username = Read-Host "Entrez le nom d'utilisateur"

# Tentative de récupération des informations de l'utilisateur
try {
    # On utilise Get-LocalUser, disponible sur Windows 10 et versions ultérieures
    $user = Get-LocalUser -Name $username -ErrorAction Stop
} catch {
    "Utilisateur introuvable." | Out-File -FilePath "infos_$username.log" -Encoding UTF8
    exit
}

# Récupération des informations demandées
$FullName      = $user.FullName
$DateCreation  = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$Hostname      = $env:COMPUTERNAME
$PasswordLastSet = $user.PasswordLastSet

# Recherche de l'adresse IPv4 en excluant l'adresse de loopback et les adresses APIPA
$ipAddress = (Get-NetIPAddress -AddressFamily IPv4 |
              Where-Object { $_.IPAddress -notlike "127.*" -and $_.IPAddress -notlike "169.254.*" } |
              Select-Object -First 1).IPAddress

# Construction du contenu du fichier log
$contenu = @"
Nom complet                : $FullName
Date et heure de création  : $DateCreation
Nom de l'hôte              : $Hostname
Dernier changement mdp     : $PasswordLastSet
Adresse IPv4               : $ipAddress
"@

# Écriture écrase le fichier s'il existe déjà
$logFile = "infos_$username.log"
$contenu | Out-File -FilePath $logFile -Encoding UTF8
