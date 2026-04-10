param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("interview", "resume")]
    [string]$Mode,
    [string]$Slug = "session",
    [string]$Company = "",
    [string]$Role = "",
    [string]$Topic = ""
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$timestamp = Get-Date -Format "yyyyMMdd_HHmm"
$dateLabel = Get-Date -Format "yyyy-MM-dd"

function Get-SafeSlug {
    param([string]$Value)

    $safe = $Value.ToLowerInvariant() -replace "[^a-z0-9\-]+", "-"
    $safe = $safe.Trim("-")
    if ([string]::IsNullOrWhiteSpace($safe)) {
        return "session"
    }

    return $safe
}

$safeSlug = Get-SafeSlug -Value $Slug

switch ($Mode) {
    "interview" {
        $templatePath = Join-Path $repoRoot "output\templates\mock_interview_session.md"
        $targetDir = Join-Path $repoRoot "output\sessions"
        $fileName = "interview_${timestamp}_${safeSlug}.md"
    }
    "resume" {
        $templatePath = Join-Path $repoRoot "output\templates\resume_tailoring_task.md"
        $targetDir = Join-Path $repoRoot "output\resume_tasks"
        $fileName = "resume_${timestamp}_${safeSlug}.md"
    }
}

if (-not (Test-Path -LiteralPath $templatePath)) {
    throw "Template not found: $templatePath"
}

New-Item -ItemType Directory -Force -Path $targetDir | Out-Null

$content = Get-Content -LiteralPath $templatePath -Raw -Encoding UTF8
$content = $content.Replace("{{DATE}}", $dateLabel)
$content = $content.Replace("{{COMPANY}}", $Company)
$content = $content.Replace("{{ROLE}}", $Role)
$content = $content.Replace("{{TOPIC}}", $Topic)

$outputPath = Join-Path $targetDir $fileName
Set-Content -LiteralPath $outputPath -Value $content -Encoding UTF8

Write-Host $outputPath
