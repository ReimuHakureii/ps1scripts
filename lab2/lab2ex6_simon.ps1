# Déclaration de la limite de temps du watchdog
$timeout = New-TimeSpan -Hours 1
$sw = [Diagnostics.Stopwatch]::StartNew()

# Chemin du fichier journal de l'activité du watchdog
$logFile = "C:\Users\kurom\Downloads\watchdog_log.txt"

# Boucle principale du watchdog qui tourne toutes les minutes
while ($sw.Elapsed -lt $timeout) {
    # Vérifier si Chrome est en cours d'exécution
    $chromeProcess = Get-Process -Name chrome -ErrorAction SilentlyContinue
    if ($chromeProcess) {
        # Tuer le processus Chrome
        kill -Name "chrome" -Force

        # Afficher un message d'avertissement
        $wshell = New-Object -ComObject Wscript.Shell
        $wshell.Popup("Hell nah bro you aint using Chrome on my watch", 0, "hello if you can read this you are a dork", 0x0)

        # Lancer un autre navigateur MEILLEUR
        Start-Process "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"

        # Enregistrer l'activité dans le fichier journal
        $username = $env:USERNAME
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        "$timestamp - Tentative d'utilisation d'un navigateur de grosse chiasse par $username" | Out-File -FilePath $logFile
    }

    # Attendre 1 minute avant de recommencer la boucle
    Start-Sleep -Seconds 60
}

Write-Host "Fin du watchdog"
