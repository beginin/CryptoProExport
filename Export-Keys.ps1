$savedir=$env:APPDATA + "\Keys\"
$remotedir = "C:\1\"
$CryptoPath = "HKLM:\SOFTWARE\Wow6432Node\Crypto Pro\Settings\Users\"
$sid = [System.Security.Principal.WindowsIdentity]::GetCurrent().user.value
$UserPath = $CryptoPath + $sid + "\Keys"

foreach ($key in Get-Item -Path $UserPath  | Get-ChildItem -ErrorAction SilentlyContinue -Recurse) {
   
    try {
 
        $folder = $savedir + $key.Name.Split("\\")[-1]
        $remotefolder = $remotedir + $key.Name.Split("\\")[-1]
        $header = Get-ItemProperty -Path $key.PSPath -Name header.key -ErrorAction Stop
        $masks = Get-ItemProperty -Path $key.PSPath -Name masks.key -ErrorAction Stop
        $masks2 = Get-ItemProperty -Path $key.PSPath -Name masks2.key -ErrorAction Stop
        $name = Get-ItemProperty -Path $key.PSPath -Name name.key -ErrorAction Stop
        $primary = Get-ItemProperty -Path $key.PSPath -Name primary.key -ErrorAction Stop
        $primary2 = Get-ItemProperty -Path $key.PSPath -Name primary2.key -ErrorAction Stop
        New-Item -ItemType Directory -Force -Path $folder
        [io.file]::WriteAllBytes($folder + '\header.key',$header.'header.key')
        [io.file]::WriteAllBytes($folder + '\masks.key',$masks.'masks.key')
        [io.file]::WriteAllBytes($folder + '\masks2.key',$masks2.'masks2.key')
        [io.file]::WriteAllBytes($folder + '\name.key',$name.'name.key')
        [io.file]::WriteAllBytes($folder + '\primary.key',$primary.'primary.key')
        [io.file]::WriteAllBytes($folder + '\primary2.key',$primary2.'primary2.key')
        New-Item -ItemType Directory -Force -Path $remotefolder
        [io.file]::WriteAllBytes($remotefolder + '\header.key',$header.'header.key')
        [io.file]::WriteAllBytes($remotefolder + '\masks.key',$masks.'masks.key')
        [io.file]::WriteAllBytes($remotefolder + '\masks2.key',$masks2.'masks2.key')
        [io.file]::WriteAllBytes($remotefolder + '\name.key',$name.'name.key')
        [io.file]::WriteAllBytes($remotefolder + '\primary.key',$primary.'primary.key')
        [io.file]::WriteAllBytes($remotefolder + '\primary2.key',$primary2.'primary2.key')

    }
    catch {
        continue
    }
    
}

