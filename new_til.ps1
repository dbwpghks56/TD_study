# 오늘 날짜로 새 TIL 노트를 만든다.
# 사용법: .\new_til.ps1 [주제]   (TIL/ 안에 파일을 만든다. 주제는 영문 슬러그 권장, 비우면 날짜만 사용)
param([string]$Topic = "")

$ErrorActionPreference = "Stop"
Set-Location -LiteralPath (Join-Path $PSScriptRoot "TIL")

$Template = "_template.md"
$Readme   = "README.md"
$Date     = Get-Date -Format "yyyy-MM-dd"
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

if ([string]::IsNullOrWhiteSpace($Topic)) {
    $Topic = Read-Host "주제 (영문 권장, 비우면 날짜만)"
}

$Topic = $Topic.Trim()
$Slug  = $Topic -replace "\s", "-"

if ($Slug -ne "") {
    $File  = "$Date-$Slug.md"
    $Title = $Topic
} else {
    $File  = "$Date.md"
    $Title = "주제"
}

if (Test-Path -LiteralPath $File) {
    Write-Error "이미 있음: $File"
    exit 1
}
if (-not (Test-Path -LiteralPath $Template)) {
    Write-Error "템플릿 없음: $Template"
    exit 1
}

# 첫 줄만 바꾸고 나머지는 템플릿 그대로 (줄바꿈 보존)
$Text = [System.IO.File]::ReadAllText((Resolve-Path -LiteralPath $Template))
$Nl   = if ($Text.Contains("`r`n")) { "`r`n" } else { "`n" }
$Idx  = $Text.IndexOf($Nl)
$Rest = if ($Idx -ge 0) { $Text.Substring($Idx) } else { "" }
$Out  = "# $Date · $Title" + $Rest
[System.IO.File]::WriteAllText((Join-Path (Get-Location) $File), $Out, $Utf8NoBom)

# README 표의 마지막 행 뒤에 한 줄 추가
if (Test-Path -LiteralPath $Readme) {
    $Row   = "| $Date | [$Title]($File) |  |"
    $RText = [System.IO.File]::ReadAllText((Resolve-Path -LiteralPath $Readme))
    $RNl   = if ($RText.Contains("`r`n")) { "`r`n" } else { "`n" }
    $Lines = [System.Collections.Generic.List[string]]($RText -split $RNl)
    $Last  = -1
    for ($i = 0; $i -lt $Lines.Count; $i++) {
        if ($Lines[$i].StartsWith("|")) { $Last = $i }
    }
    if ($Last -ge 0) {
        $Lines.Insert($Last + 1, $Row)
        [System.IO.File]::WriteAllText((Resolve-Path -LiteralPath $Readme), ($Lines -join $RNl), $Utf8NoBom)
    }
}

Write-Host "생성: $(Join-Path (Get-Location) $File)"
