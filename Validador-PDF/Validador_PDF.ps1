# ----------------------------------------------------
# Herramienta: Validador de Archivos PDF
# Autor: Andrés Moreno
# Descripción:
# Analiza archivos PDF utilizando QPDF para detectar
# documentos dañados, corruptos o ilegibles.
# Genera un informe detallado con los resultados de
# la validación y un resumen general.
# ----------------------------------------------------

$revisados = 0
$funcionan = 0
$no_legibles = 0

$fecha = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
$rutaActual = Get-Location

$reporte = @()

$reporte += "INFORME DE VALIDACIÓN DE ARCHIVOS PDF"
$reporte += "Fecha de ejecución: $fecha"
$reporte += "Carpeta analizada: $rutaActual"
$reporte += "------------------------------------------------------------"
$reporte += ""

Get-ChildItem *.pdf |
ForEach-Object {

    $revisados++

    $resultado = & "C:\Program Files\qpdf 12.3.2\bin\qpdf.exe" `
        --show-npages `
        $_.FullName `
        2>&1

    if ($LASTEXITCODE -ne 0 -or -not $resultado) {

        $no_legibles++

        $reporte += "ARCHIVO NO LEGIBLE: $($_.Name)"
        $reporte += "Detalle del error detectado:"
        $reporte += ""

        foreach ($linea in $resultado) {
            $reporte += "  $linea"
        }

        $reporte += ""
        $reporte += "------------------------------------------------------------"
        $reporte += ""

    }
    else {

        $funcionan++
    }
}

$reporte += ""
$reporte += "================ RESUMEN GENERAL ================"
$reporte += "Total de archivos revisados: $revisados"
$reporte += "Archivos funcionales: $funcionan"
$reporte += "Archivos no legibles: $no_legibles"

$nombreReporte = "Informe_Validacion_PDF_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

$reporte |
Out-File $nombreReporte -Encoding UTF8