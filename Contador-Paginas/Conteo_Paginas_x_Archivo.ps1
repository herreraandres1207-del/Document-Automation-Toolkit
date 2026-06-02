# ----------------------------------------------------
# Herramienta: Contador de Páginas PDF
# Autor: Andrés Moreno
# Descripción:
# Obtiene la cantidad de páginas de todos los archivos
# PDF de la carpeta actual y genera un archivo TXT
# con los resultados.
# Requiere QPDF instalado en el sistema.
# ----------------------------------------------------

Get-ChildItem *.pdf |
ForEach-Object {
    & "C:\Program Files\qpdf 12.3.2\bin\qpdf.exe" `
        --show-npages `
        $_.FullName `
        2>$null
} |
Out-File "paginas.txt"