# ----------------------------------------------------
# Herramienta: Reporte de Tamaños de Archivos
# Autor: Andrés Moreno
# Descripción:
# Genera un archivo TXT con el tamaño en KB de los
# archivos encontrados en la carpeta actual,
# ordenados alfabéticamente por nombre o Enumerados
# orden que los desa.
# ----------------------------------------------------

Get-ChildItem -File |
Where-Object {
    $_.Extension -in @(
        '.pdf',
        '.jpg',
        '.jpeg',
        '.xls',
        '.xlsx',
        '.doc',
        '.docx'
    )
} |
Sort-Object Name |
ForEach-Object {
    [math]::Round($_.Length / 1KB)
} |
Out-File "lista_tamanos_kb.txt"