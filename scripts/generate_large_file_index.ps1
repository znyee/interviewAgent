param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
    [string]$TargetDir = "",
    [int]$ThresholdMB = 20
)

$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($TargetDir)) {
    $candidate = Get-ChildItem -LiteralPath $RepoRoot -Directory |
        Where-Object { $_.Name -like "agent*" -and $_.Name -ne "agent_knowledge" } |
        Select-Object -First 1

    if ($null -eq $candidate) {
        throw "Could not discover the source archive directory under $RepoRoot"
    }

    $TargetDir = $candidate.Name
}

$targetPath = Join-Path $RepoRoot $TargetDir
if (-not (Test-Path -LiteralPath $targetPath)) {
    throw "Target directory not found: $targetPath"
}

$thresholdBytes = $ThresholdMB * 1MB
$outputJson = Join-Path $targetPath "large_files_manifest.json"
$outputMarkdown = Join-Path $targetPath "LARGE_FILE_INDEX.md"
$targetLabel = Split-Path -Leaf $targetPath

function Get-RelativePath {
    param(
        [string]$BasePath,
        [string]$FullPath
    )

    $base = (Resolve-Path $BasePath).Path.TrimEnd("\")
    $full = (Resolve-Path $FullPath).Path
    return $full.Substring($base.Length + 1).Replace("\", "/")
}

function Get-Category {
    param([System.IO.FileInfo]$File)

    $ext = $File.Extension.ToLowerInvariant()
    $path = $File.FullName.ToLowerInvariant().Replace("\", "/")

    if ($ext -in @(".mp4", ".mov", ".avi", ".mkv")) {
        return "media"
    }

    if ($path -match "(checkpoint-\d+|model-dpo|qwen3-0_6b|qwen2\.5-0\.5b-instruct|deepseek-r1-distill-llama-8b|facebook_opt-|phi-2|distilbert)" -or
        $ext -in @(".safetensors", ".onnx", ".bin", ".h5", ".pt", ".pth", ".ckpt")) {
        return "model-weight"
    }

    if ($path -match "(nltk_data|/volumes/|/wal/)" -or
        $ext -in @(".wal", ".tmp", ".trie", ".pickle", ".pkl", ".db")) {
        return "runtime-cache"
    }

    if ($ext -eq ".ipynb") {
        return "notebook-export"
    }

    if ($path -match "(dataset|imdb|medical_|disc-law|train\.json|plain_text)" -or
        $ext -in @(".parquet", ".jsonl", ".json")) {
        return "dataset"
    }

    return "other"
}

function Get-Description {
    param([string]$Category)

    switch ($Category) {
        "model-weight" { return "Model weights, adapters, or training checkpoints. Keep path and purpose only." }
        "dataset" { return "Raw training data or corpus assets. Keep source and usage notes only." }
        "runtime-cache" { return "Caches, vector DB volumes, or tokenization indexes. Rebuild per environment." }
        "media" { return "Recorded course or demo media. Keep filename and summary only." }
        "notebook-export" { return "Heavy notebook export. Keep title and topic summary, split content later if needed." }
        default { return "Large supplementary file that does not belong in the GitHub repo." }
    }
}

$items = Get-ChildItem -LiteralPath $targetPath -Recurse -File -ErrorAction SilentlyContinue |
    Where-Object { $_.Length -ge $thresholdBytes } |
    Sort-Object Length -Descending |
    ForEach-Object {
        $relativePath = Get-RelativePath -BasePath $RepoRoot -FullPath $_.FullName
        $category = Get-Category -File $_
        $segments = $relativePath.Split("/")
        $module = if ($segments.Length -ge 2) { $segments[1] } else { $TargetDir }

        [PSCustomObject]@{
            relative_path = $relativePath
            size_mb = [math]::Round($_.Length / 1MB, 1)
            extension = $_.Extension
            category = $category
            module = $module
            description = Get-Description -Category $category
        }
    }

$categorySummary = $items |
    Group-Object category |
    Sort-Object Name |
    ForEach-Object {
        [PSCustomObject]@{
            category = $_.Name
            count = $_.Count
            size_gb = [math]::Round((($_.Group | Measure-Object size_mb -Sum).Sum) / 1024, 3)
            description = Get-Description -Category $_.Name
        }
    }

$moduleSummary = $items |
    Group-Object module |
    Sort-Object Name |
    ForEach-Object {
        [PSCustomObject]@{
            module = $_.Name
            count = $_.Count
            size_gb = [math]::Round((($_.Group | Measure-Object size_mb -Sum).Sum) / 1024, 3)
        }
    }

$manifest = [PSCustomObject]@{
    generated_at = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssK")
    repo_root = $RepoRoot
    target_dir = $TargetDir
    threshold_mb = $ThresholdMB
    total_files = $items.Count
    total_size_gb = [math]::Round((($items | Measure-Object size_mb -Sum).Sum) / 1024, 3)
    category_summary = $categorySummary
    module_summary = $moduleSummary
    files = $items
}

$manifest | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $outputJson -Encoding utf8

$lines = [System.Collections.Generic.List[string]]::new()
$null = $lines.Add("# $targetLabel Large File Index")
$null = $lines.Add("")
$null = $lines.Add("This file lists items under $targetLabel/ that are greater than or equal to $ThresholdMB MB.")
$null = $lines.Add("These files stay out of GitHub by default; the repository keeps only paths, usage notes, and indexes.")
$null = $lines.Add("")
$null = $lines.Add("## Summary")
$null = $lines.Add("")
$null = $lines.Add("- Threshold: $ThresholdMB MB")
$null = $lines.Add("- Files: $($manifest.total_files)")
$null = $lines.Add("- Total size: $($manifest.total_size_gb) GB")
$null = $lines.Add("- Generated at: $($manifest.generated_at)")
$null = $lines.Add("")
$null = $lines.Add("## Git Strategy")
$null = $lines.Add("")
$null = $lines.Add("- Track in Git: source code, Markdown, documentation, and lightweight config.")
$null = $lines.Add("- Track as index only: model weights, raw datasets, caches, videos, and heavy notebooks.")
$null = $lines.Add("- Machine-readable manifest: large_files_manifest.json")
$null = $lines.Add("")
$null = $lines.Add("## Category Summary")
$null = $lines.Add("")
$null = $lines.Add("| Category | Files | Size (GB) | Description |")
$null = $lines.Add("| --- | ---: | ---: | --- |")
foreach ($row in $categorySummary) {
    $null = $lines.Add("| $($row.category) | $($row.count) | $($row.size_gb) | $($row.description) |")
}

$null = $lines.Add("")
$null = $lines.Add("## Module Summary")
$null = $lines.Add("")
$null = $lines.Add("| Module | Files | Size (GB) |")
$null = $lines.Add("| --- | ---: | ---: |")
foreach ($row in $moduleSummary) {
    $null = $lines.Add("| $($row.module) | $($row.count) | $($row.size_gb) |")
}

$null = $lines.Add("")
$null = $lines.Add("## Detailed Index")
$null = $lines.Add("")
$null = $lines.Add("| Path | Size (MB) | Category | Description |")
$null = $lines.Add("| --- | ---: | --- | --- |")
foreach ($item in $items) {
    $null = $lines.Add("| $($item.relative_path) | $($item.size_mb) | $($item.category) | $($item.description) |")
}

Set-Content -LiteralPath $outputMarkdown -Value $lines -Encoding utf8

Write-Host "Generated:"
Write-Host "  $outputMarkdown"
Write-Host "  $outputJson"
