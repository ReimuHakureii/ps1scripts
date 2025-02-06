# Exercice 2 : Utilisation de Where-Object et du pipe
# Description de l'effet du code ci-bas :
# Ce script arrête de force les processus dont le nom correspond exactement à "TestProcessus".

# Explication du rôle du symbole | (pipe) :
# Le symbole | (pipe) permet de passer la sortie d'une commande en entrée de la commande suivante.

# Explication de la fonction de chaque bloc de code séparé par un | :
# 1. Get-Process : Récupère la liste des processus en cours d'exécution.
# 2. Where-Object { $_.Name -eq 'TestProcessus' } : Filtre pour ne conserver que les processus ayant le nom "TestProcessus".
# 3. kill -force : Termine de force les processus filtrés.

Get-Process | Where-Object { ($_.name -eq 'TestProcessus') } | kill -force