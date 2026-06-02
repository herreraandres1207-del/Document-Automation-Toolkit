# ----------------------------------------------------
# Herramienta: Listado de Nombres de Archivos
# Autor: Andrés Moreno
# Descripción:
# Genera un archivo TXT con los nombres de los archivos
# encontrados en la carpeta actual.
# ----------------------------------------------------

Get-ChildItem -File |
Where-Object {
    $_.Extension -eq '.mp4'  -or
    $_.Extension -eq '.pdf'  -or
    $_.Extension -eq '.jpg'  -or
    $_.Extension -eq '.jpeg' -or
    $_.Extension -eq '.xls'  -or
    $_.Extension -eq '.xlsx' -or
    $_.Extension -eq '.doc'  -or
    $_.Extension -eq '.docx' -or
    $_.Extension -eq '.avi'  -or
    $_.Extension -eq '.mkv'  -or
    $_.Extension -eq '.mov'  -or
    $_.Extension -eq '.wmv'  -or
    $_.Extension -eq '.mxf'  -or
    $_.Extension -eq '.mp3'  -or
    $_.Extension -eq '.wav'  -or
    $_.Extension -eq '.flac' -or
    $_.Extension -eq '.aac'  -or
    $_.Extension -eq '.ogg'  -or
    $_.Extension -eq '.m4a'
} |
Select-Object -ExpandProperty Name |
Out-File "lista_nombres.txt"