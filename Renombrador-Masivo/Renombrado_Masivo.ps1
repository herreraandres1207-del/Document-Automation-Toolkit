# ----------------------------------------------------
# Herramienta: Renombrador Masivo de Archivos
# Autor: Andrés Moreno
# Descripción:
# Renombra múltiples archivos utilizando una lista de
# nombres almacenada en un archivo TXT.
# Verifica previamente que la cantidad de archivos
# coincida con la cantidad de nombres y evita
# sobrescribir archivos existentes.
# ----------------------------------------------------

$nombres = Get-Content "nombres.txt"

$archivos = Get-ChildItem -File |
Where-Object {
    $_.Name -ne "nombres.txt"
} |
Sort-Object Name

if ($archivos.Count -ne $nombres.Count) {
    Write-Host "ERROR: La cantidad de archivos no coincide con la lista."
    return
}

for ($i = 0; $i -lt $archivos.Count; $i++) {

    $extension = $archivos[$i].Extension
    $nuevoNombre = $nombres[$i] + $extension

    if (Test-Path $nuevoNombre) {
        Write-Host "ERROR: Ya existe $nuevoNombre. Proceso detenido."
        return
    }
}

for ($i = 0; $i -lt $archivos.Count; $i++) {

    $extension = $archivos[$i].Extension

    Rename-Item `
        $archivos[$i] `
        ($nombres[$i] + $extension)
}

Write-Host "RENOMBRADO COMPLETADO SIN ERRORES"