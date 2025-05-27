$pcs=Import-Csv "C:\Users\dario.maldonado\Documents\WEBPAG\InstalarSap\pcs.csv"

foreach ($pc in $pcs) {
    echo ($pc.Nombre)
    $equipo=$pc.Nombre
    #Invoke-GPUpdate -Computer $pc -Force
    C:\PSTools\PsExec.exe \\$equipo -h -d powershell.exe "enable-psremoting -force"
    Start-Sleep -Seconds 3
    $pw = convertto-securestring -AsPlainText -Force -String R1805075817vp998
    $cred = new-object -typename System.Management.Automation.PSCredential -argumentlist "ETARM.LOCAL\dario.maldonado",$pw
 
    $Session = New-PSSession -ComputerName $equipo -Credential $cred
    Copy-Item "C:\Users\dario.maldonado\Documents\WEBPAG\InstalarSap\SAPGUI8.exe" -Destination "C:\" -ToSession $Session
    Start-Sleep -Seconds 2
    Copy-Item "C:\Users\dario.maldonado\Documents\WEBPAG\InstalarSap\SAPGUI8script.ps1" -Destination "C:\" -ToSession $Session
    Start-Sleep -Seconds 2
    C:\PSTools\PsExec.exe \\$equipo powershell.exe "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"
    C:\PSTools\PsExec.exe \\$equipo powershell.exe -File "C:\SAPGUI8script.ps1"

}