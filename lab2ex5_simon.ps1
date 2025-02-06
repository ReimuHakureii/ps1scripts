# Exercice 5 : Démarrage en arrière-plan
Start-Job -ScriptBlock { & "C:\Users\kurom\downloads\lab2ex4_simon.ps1" }
# Voir les jobs en cours : Get-Job
# Arrêter un job : Stop-Job -Id <ID>