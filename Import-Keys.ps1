$keyDir=$env:APPDATA + "\Keys\"
$CryptoPath = "HKLM:\SOFTWARE\Wow6432Node\Crypto Pro\Settings\Users\"
$sid = [System.Security.Principal.WindowsIdentity]::GetCurrent().user.value
$UserPath = $CryptoPath + $sid + "\Keys"

foreach ($key in (Get-Item -Path $keyDir |  Get-ChildItem -ErrorAction SilentlyContinue)) {
    Write-Host "----"
    $folder = $key.PSPath.Split(":")[-2] + ":" + $key.PSPath.Split(":")[-1]
    try {
        #$bytes = [System.IO.File]::ReadAllBytes()
        $header = [io.file]::ReadAllBytes($folder + '\header.key')
        $masks = [io.file]::ReadAllBytes($folder + '\masks.key')
        $masks2 = [io.file]::ReadAllBytes($folder + '\masks2.key')
        $name = [io.file]::ReadAllBytes($folder + '\name.key')
        $primary = [io.file]::ReadAllBytes($folder + '\primary.key')
        $primary2 = [io.file]::ReadAllBytes($folder + '\primary2.key')
        $keyName = [System.Text.Encoding]::GetEncoding(1251).GetString($name[4..($name.length)])
        if ((Test-Path -Path ($CryptoPath + $sid)) -eq $false) {
            New-Item -Path $CryptoPath -Name $sid
        }
        if ((Test-Path -Path $UserPath) -eq $false) {
            New-Item -Path ($CryptoPath + $sid) -Name "Keys"
        }
        if ((Test-Path -Path ($UserPath +"\"+$keyName )) -eq $false) {
            New-Item -Path $UserPath -Name $keyName
            New-ItemProperty -Path ($UserPath +"\"+$keyName ) -Name 'header.key' -Value $header
            New-ItemProperty -Path ($UserPath +"\"+$keyName ) -Name 'masks.key' -Value $masks
            New-ItemProperty -Path ($UserPath +"\"+$keyName ) -Name 'masks2.key' -Value $masks2
            New-ItemProperty -Path ($UserPath +"\"+$keyName ) -Name 'name.key' -Value $name
            New-ItemProperty -Path ($UserPath +"\"+$keyName ) -Name 'primary.key' -Value $primary
            New-ItemProperty -Path ($UserPath +"\"+$keyName ) -Name 'primary2.key' -Value $primary2

        }       

    }
    catch {
        continue
    }

}

