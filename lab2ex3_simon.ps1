# Demande le nom du processus à l'utilisateur
$processName = Read-Host "Entrez le nom du processus à tuer (ex: TestProcessus)"

# Demande la valeur minimale de mémoire de travail
$memoryThreshold = Read-Host "Entrez la valeur minimale de mémoire de travail en Mo"

# Liste les processus, filtre ceux qui correspondent au nom entré et qui ont une mémoire supérieure au seuil, puis les termine
Get-Process | Where-Object { $_.Name -match "^$processName" -and $_.WS -gt $memoryThreshold } | kill -force

# Affichage du résultat
Write-Host "Les processus correspondant à '$processName' avec une mémoire supérieure à $memoryThreshold MB ont été arrêtés."