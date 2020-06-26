# 参考
# https://qiita.com/gzock/items/1c934d6577eec3b7f7ff

# ステップ記録ツールの実行ファイルパス
$psr = Join-Path -Path $env:windir -ChildPath system32\psr.exe

# 対象プロセスのプロセスIDを取得
$targetProcessName = Read-Host -Prompt '対象のプロセス名を入力してください。例：notepad'
$yesno = Read-Host "$($targetProcessName) よろしいですか？(Y/N)"
if ($yesno -ne 'Y') {
    Write-Host '中止します。'
    exit
}

# 複数取れたらとりあえず最初の1つ
$targetPid = (Get-Process -Name $targetProcessName).Id | Select-Object -First 1
Write-Host "processId : $targetPid"

# エビデンスのフルパスを組み立て
$evidenceFileName = (Get-Date -Format "yyyyMMddHHmmss_") + $targetProcessName +  ".zip"
# Write-Host $evidenceFileName
#TODO: もっとそれっぽいところに変える
#TODO: 設定ファイルか引数あたりで変えられると良いのか？
$evidenceDir = Join-Path -Path $env:userprofile -ChildPath 'Documents\Temp\psr'
# Write-Host $evidenceDir
#TODO: なかったら作る
# Test-Path $evidenceDir
$evidence = Join-Path -Path $evidenceDir -ChildPath $evidenceFileName
# Write-Host $evidence

# ステップ記録ツールに渡す引数リストを組み立て
#$arguments = @('/start','/sc 1','/maxsc 99','/gui 1',"/recordpid $targetPid","/output $evidence")
$arguments = @('/start','/maxsc 99',"/recordpid $targetPid","/output $evidence")
# Write-Host $arguments

# ステップ記録ツール実行
Start-Process -FilePath $psr -ArgumentList $arguments

# ↓文字化けする。
Write-Host '記録を開始しました。'
Write-Host 'もし開始されていなかったらステップ記録ツールのGUI上で「記録の開始」を押してください。'
# Write-Host '記録を開始するにはステップ記録ツールのGUI上で「記録の開始」を押してください。'
Write-Host '記録を停止するにはステップ記録ツールのGUI上で「記録の停止」を押してください。'
Write-Host "エビデンスフォルダを開きます"
Invoke-Item -Path $evidenceDir