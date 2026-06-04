# ----------------------------------------------------
# Herramienta: Validador de Archivos PDF
# Autor: Andres Moreno
# Descripcion:
# Analiza archivos PDF utilizando QPDF para detectar
# errores estructurales, corrupcion interna e
# inconsistencias documentales.
# Genera un informe detallado con los resultados de
# la validacion y un resumen general.
# ----------------------------------------------------

$revisados = 0
$funcionan = 0
$erroresEstructura = 0

$fecha = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
$rutaActual = Get-Location

$reporte = @()

$reporte += "INFORME DE VALIDACION DE ARCHIVOS PDF"
$reporte += "Fecha de ejecucion: $fecha"
$reporte += "Carpeta analizada: $rutaActual"
$reporte += "------------------------------------------------------------"
$reporte += ""

Get-ChildItem *.pdf | ForEach-Object {

    $revisados++

    $resultado = & "C:\Program Files\qpdf 12.3.2\bin\qpdf.exe" `
        --check `
        $_.FullName `
        2>&1

    if ($LASTEXITCODE -ne 0) {

        $erroresEstructura++

        $reporte += "ARCHIVO CON ERRORES DE ESTRUCTURA: $($_.Name)"
        $reporte += ""
        $reporte += "El archivo puede abrirse y visualizarse normalmente,"
        $reporte += "pero QPDF detecto inconsistencias en su estructura interna."
        $reporte += ""
        $reporte += "Estas inconsistencias pueden ocasionar problemas en:"
        $reporte += " - Validacion documental"
        $reporte += " - Firma digital"
        $reporte += " - Procesamiento automatizado"
        $reporte += " - Conservacion y archivado digital"
        $reporte += ""
        $reporte += "Detalle tecnico detectado:"
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
$reporte += "Archivos sin errores detectados: $funcionan"
$reporte += "Archivos con errores de estructura: $erroresEstructura"
$reporte += ""

$nombreReporte = "Informe_Validacion_PDF_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

$reporte | Out-File $nombreReporte -Encoding UTF8

Write-Host ""
Write-Host "Validacion finalizada."
Write-Host "Reporte generado: $nombreReporte"
Write-Host "Archivos revisados: $revisados"
Write-Host "Archivos sin errores: $funcionan"
Write-Host "Archivos con errores de estructura: $erroresEstructura"