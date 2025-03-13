# Définition des chemins de fichiers
$sourceFile = "errors.log"
$outputFile = "rogerEst.la"

# Vérifier si le fichier errors.log existe
if (-Not (Test-Path $sourceFile)) {
    Write-Host "Fichier errors.log introuvable"
    exit
}

# Lecture et filtrage des lignes contenant "roger" recherche non sensible à la casse
$matchingLines = Select-String -Path $sourceFile -Pattern "roger" -CaseSensitive:$false

# Pour chaque ligne trouvée on écrit le contenu dans le fichier rogerEst.la
foreach ($match in $matchingLines) {
    Add-Content -Path $outputFile -Value $match.line
}

