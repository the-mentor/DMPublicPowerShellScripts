#!/usr/bin/env pwsh

############ CONFIG SECTION ############
$WallPaperFolders = @('~/MyWallpapers') # you can change this array to containe multiple folders with full or relative paths
$WallpaperDelayInMinutes = 1

############ CONFIG SECTION ############

$WallPaperImages  = Get-ChildItem -Path $WallPaperFolders | Where-Object {$_.Name -match 'png|jpg|jpeg'}

$gsettings = Get-Command -Name gsettings -ErrorAction stop
$WallpaperDelaySeconds = $WallpaperDelayInMinutes * 60


if($env:XDG_CURRENT_DESKTOP -match 'gnome' -and $IsLinux){
	Write-Host "yay you're running GNOME!"
	while ($true) {	
		$RandomWallPaper = $WallPaperImages[$(get-random -Minimum 0 -Maximum $WallPaperImages.count)]
		
		Write-Host "Changing Wallpaper to $($RandomWallPaper.FullName)"
		gsettings set org.gnome.desktop.background picture-uri "file://$($RandomWallPaper.FullName)"

		Write-Host "Starting Sleep for $WallpaperDelayInMinutes Minutes"
		Start-Sleep $WallpaperDelaySeconds
	}
}
else {
	if(!$IsLinux){Write-Host "You are not running Linux :("}
	if(!$IsLinux){Write-Host "You are not running GNOME :("}
}

Write-Host "THE END"
