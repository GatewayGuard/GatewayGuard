# Dated: 2026-08-15 14:05 EDT
# File: Convert-PdfToMarkdown-2026-08-15.ps1
# Launcher: Run-PdfToMarkdown.bat
#
#  WHAT THIS IS: the missing half of build_readable_twins.py.
#
#  That script sweeps ProjectDocs\ and writes a readable .md twin for every
#  Word and PowerPoint file, because Claude Cloud cannot read a binary --
#  measured 2026-08-13, a controlled result: MarketResearch.docx and .md sit
#  in the same folder, same scope, same commit, and only the .md ever
#  surfaces. The guide .docx was invisible for sixteen days that way.
#
#  It has never handled PDFs, and said so honestly:
#    "No PDF text library is installed on CGDELL (pypdf, PyPDF2 and pymupdf
#     all absent, checked 2026-08-13) and installing one is a change to
#     Bill's machine, not a decision for a script."
#
#  Re-measured 2026-08-15: pypdf, PyPDF2, fitz, pdfminer and pdfplumber are
#  ALL still absent, and pdftotext is not on PATH. But WORD IS INSTALLED, and
#  Word opens PDFs. So this converts through Word's COM interface and installs
#  NOTHING. That was the objection; it no longer applies.
#
#  WHAT IT CHANGES: it writes one .md file. It does not modify, move or delete
#  the PDF. Word runs invisibly and is always shut down, including on error.
#
#  DOES NOT NEED ADMINISTRATOR.
#
#  WHAT IT CANNOT DO: a scanned, image-only PDF has no text to extract and
#  will produce an almost-empty file. That is REPORTED, not silently written --
#  an unreported gap is how the guide stayed invisible for sixteen days.
#
#  ###################################################################
#  #  DOES NOT WORK YET. MEASURED FAILURE, 2026-08-15. READ BEFORE   #
#  #  SPENDING ANY TIME ON THIS.                                     #
#  ###################################################################
#
#  Run against Guide\GatewayGuard_Guide-Standard-14pt-2026-07-16.pdf (0.5 MB,
#  36 pages) it HUNG. Measured after 50 minutes: WINWORD.EXE alive, **11.8
#  seconds of CPU consumed**, MainWindowTitle empty. That is not slow work --
#  a process doing work burns CPU. It is blocked on a modal dialog.
#
#  The dialog is almost certainly Word's "Word will now convert your PDF to an
#  editable Word document", which `DisplayAlerts = 0` does NOT suppress, and
#  which is invisible because the instance is running with Visible = $false.
#  So it waits forever for a click nobody can see.
#
#  ConfirmConversions:$false (passed as Open()'s 2nd positional argument here)
#  suppresses the FILE-FORMAT conversion prompt. It does not suppress the PDF
#  reflow prompt, which is a different dialog.
#
#  UNTRIED, in rough order of promise:
#    1. Registry: HKCU\Software\Microsoft\Office\<ver>\Word\Options
#       DisablePdfReflowNotice = 1 (DWORD). Changes Bill's machine, so it is
#       his call, not a script's.
#    2. Run Word VISIBLE once by hand, convert one PDF, tick "don't show this
#       again". The setting then persists for automated runs.
#    3. Install a PDF text library (pypdf). Also a machine change -- and the
#       original objection build_readable_twins.py raised.
#
#  THE TEN-MINUTE RULE APPLIES AND WAS APPLIED. Fifty minutes of a hung Word
#  process is exactly the case that rule exists for: stop, write it up, do not
#  keep trying. Killed the process, recorded the measurement, moved on.
#
#  AND CHECK IT IS WORTH DOING AT ALL FIRST. The five Guide-*.pdf print
#  editions are RENDERINGS of windows_security_walkthrough_guide_v9.docx,
#  which already has a full-text twin in ProjectDocs\ at 9,363 words. Adding a
#  second copy of the same guide to connector scope makes Cloud hold two
#  versions of one document with no way to tell which wins -- the exact
#  second-copy-goes-stale failure the twins system exists to prevent. If a PDF
#  ever turns out to be NEWER than its .docx, fix the .docx; do not ship a
#  rival text of it.
#
#  USAGE
#    .\Convert-PdfToMarkdown-2026-08-15.ps1 -Pdf "..\Guide\Some-Guide.pdf"
#    .\Convert-PdfToMarkdown-2026-08-15.ps1 -Pdf "..." -OutDir "..\ProjectDocs"
#
#  The default output folder is ProjectDocs\, because that is the folder the
#  connector actually carries. A twin written anywhere else is invisible to
#  Cloud, which is the whole failure this exists to prevent.

param(
    [Parameter(Mandatory = $true)][string]$Pdf,
    [string]$OutDir = "",
    [switch]$NoPause
)

$ErrorActionPreference = "Stop"
Set-Location -Path $PSScriptRoot

$ggRoot = Split-Path -Parent $PSScriptRoot
if (-not $OutDir) { $OutDir = Join-Path $ggRoot "ProjectDocs" }

$ggPdf = Resolve-Path -LiteralPath $Pdf -ErrorAction SilentlyContinue
if (-not $ggPdf) {
    Write-Host "  ERROR: PDF not found: $Pdf" -ForegroundColor Red
    if (-not $NoPause) { Write-Host "  Press Enter to close."; $null = Read-Host }
    exit 1
}
$ggPdf = $ggPdf.Path
$ggName = [System.IO.Path]::GetFileNameWithoutExtension($ggPdf)
$ggOut  = Join-Path $OutDir ($ggName + ".md")
$ggTmp  = Join-Path $env:TEMP ($ggName + "-" + (Get-Date -Format "HHmmss") + ".txt")

Write-Host ""
Write-Host "============================================================"
Write-Host " PDF -> MARKDOWN"
Write-Host " Source : $ggPdf"
Write-Host " Output : $ggOut"
Write-Host " Word runs invisibly. The PDF is not modified."
Write-Host "============================================================"
Write-Host ""

$ggWord = $null
$ggDoc  = $null
try {
    Write-Host "  Starting Word..." -ForegroundColor Cyan
    $ggWord = New-Object -ComObject Word.Application
    $ggWord.Visible = $false
    $ggWord.DisplayAlerts = 0          # wdAlertsNone -- no "convert this PDF?" dialog

    Write-Host "  Opening and converting (this is the slow part)..." -ForegroundColor Cyan
    # ConfirmConversions:$false is what suppresses the PDF-import prompt.
    # ReadOnly:$true guarantees the source cannot be written back to.
    $ggDoc = $ggWord.Documents.Open($ggPdf, $false, $true)

    $ggPages = 0
    try { $ggPages = $ggDoc.ComputeStatistics(2) } catch {}   # wdStatisticPages

    Write-Host "  Saving text..." -ForegroundColor Cyan
    $ggDoc.SaveAs([ref]$ggTmp, [ref]7)   # wdFormatUnicodeText
    $ggDoc.Close([ref]$false)
    $ggDoc = $null
}
catch {
    Write-Host ""
    Write-Host "  ERROR during conversion: $_" -ForegroundColor Red
    Write-Host "  Nothing was written." -ForegroundColor Yellow
}
finally {
    # Word MUST be shut down even on failure, or WINWORD.EXE is left running
    # invisibly and the next run opens a second one.
    if ($null -ne $ggDoc)  { try { $ggDoc.Close([ref]$false) } catch {} }
    if ($null -ne $ggWord) { try { $ggWord.Quit() } catch {} }
    if ($null -ne $ggWord) { try { [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($ggWord) } catch {} }
    [GC]::Collect(); [GC]::WaitForPendingFinalizers()
}

if (-not (Test-Path $ggTmp)) {
    Write-Host "  ERROR: Word produced no text file. Nothing written." -ForegroundColor Red
    if (-not $NoPause) { Write-Host "  Press Enter to close."; $null = Read-Host }
    exit 1
}

$ggRaw = Get-Content -LiteralPath $ggTmp -Raw -Encoding Unicode
Remove-Item -LiteralPath $ggTmp -Force -ErrorAction SilentlyContinue

# -- tidy, without pretending it is structured Markdown ---------------------
# Word's text export gives paragraphs, not headings. Inventing '#' levels from
# guesswork would produce a document that LOOKS structured and is wrong in
# places, which is worse for a rewrite than plain paragraphs. So: normalise
# whitespace, drop form feeds, collapse runs of blank lines. Nothing else.
$ggRaw = $ggRaw -replace "`r`n", "`n"
$ggRaw = $ggRaw -replace "`f", "`n"
$ggRaw = $ggRaw -replace "[ `t]+`n", "`n"
$ggRaw = $ggRaw -replace "`n{3,}", "`n`n"
$ggBody = $ggRaw.Trim()

$ggWords = ($ggBody -split '\s+' | Where-Object { $_ }).Count
$ggChars = $ggBody.Length

if ($ggChars -lt 200) {
    Write-Host ""
    Write-Host "  REPORTED, NOT WRITTEN: only $ggChars characters came out." -ForegroundColor Yellow
    Write-Host "  That is what an image-only (scanned) PDF looks like. There is" -ForegroundColor Yellow
    Write-Host "  no text in it to extract, and writing a near-empty twin would" -ForegroundColor Yellow
    Write-Host "  hide that rather than show it." -ForegroundColor Yellow
    if (-not $NoPause) { Write-Host ""; Write-Host "  Press Enter to close."; $null = Read-Host }
    exit 2
}

$ggStamp = Get-Date -Format "yyyy-MM-dd HH:mm"
$ggRel = $ggPdf.Replace($ggRoot + [System.IO.Path]::DirectorySeparatorChar, "")

$ggHeader = @"
<!-- Dated: $ggStamp ET -->
<!-- Editor: Claude Code ($env:COMPUTERNAME) -->
<!-- GENERATED by Tool/Convert-PdfToMarkdown-2026-08-15.ps1 -- do not hand-edit. -->
# $ggName -- readable text

- **Document Name:** $ggName
- **Last Modified:** $ggStamp ET
- **Source of record:** ``$ggRel`` ($ggPages pages)
- **Status:** GENERATED extraction. **The PDF remains the master.**

---

## WHY THIS FILE EXISTS

Claude Cloud cannot read a PDF. measured 2026-08-13, a controlled result:
``GatewayGuard_MarketResearch.docx`` and ``.md`` sit in the same folder, the same
connector scope and the same commit, and **only the ``.md`` ever surfaces**. The
guide ``.docx`` was committed, pushed and completely invisible for sixteen days
on exactly that basis.

So the binary is kept -- git stores and versions it perfectly well, it simply
cannot diff it -- and this is the copy that gets **read and rewritten from**.

## WHAT THIS EXTRACTION IS AND IS NOT

**It is the text, in reading order. It is not the layout.** Word's text export
gives paragraphs, not headings, so no ``#`` levels have been invented here.
Guessed heading levels would produce a document that *looks* structured and is
wrong in places, which is worse to rewrite from than plain paragraphs.

**Page furniture survives** -- running heads, footers and page numbers appear
inline, because a text export cannot tell them from body text. Ignore them.

**$ggWords words, $ggChars characters.** If that looks short against the PDF,
say so rather than working from it.

---

"@

if (-not (Test-Path $OutDir)) { New-Item -ItemType Directory -Path $OutDir -Force | Out-Null }
($ggHeader + $ggBody + "`n") | Out-File -FilePath $ggOut -Encoding utf8

Write-Host ""
Write-Host "  WROTE: $ggOut" -ForegroundColor Green
Write-Host "  $ggPages pages, $ggWords words, $ggChars characters" -ForegroundColor Green
Write-Host ""
Write-Host "  The PDF was not modified." -ForegroundColor Gray
Write-Host ""

if (-not $NoPause) {
    Write-Host "  Press Enter to close this window."
    $null = Read-Host
}
exit 0
