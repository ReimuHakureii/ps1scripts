# Declaration limite de temps de la boucle
$timeout = New-TimeSpan -Minutes 60
# Demarrage d'un compteur de temps
$sw = [Diagnostics.Stopwatch]::StartNew()
# Boucle fonctionnant jusqu'à l'atteinte de la limite de temps
while ($sw.Elapsed -lt $timeout) {
    Get-Process | Where-Object { $_.Name -match '^Test' -and $_.WS/1MB -gt 50 } | kill -force
    #Temps entre chaque boucle
    Start-Sleep -Seconds 30
}
Write-Host "Fin de la tâche"