#Requires -Version 7
#Version 0.1 by DM | PowerShellOnLinux.com

param(
    [uri]$RssFeedURL,
    [switch]$ShowPodcastInfoOnly,
    [System.IO.FileInfo]$DownloadDir,
    [int]$SimultaneousDownload = 10
)
try{
    $r = Invoke-RestMethod -ErrorAction Stop -Uri $RssFeedURL
}
catch{
    throw "Unable to retrive RSS feed please check the URL and try again: $_"
}

if(!(Test-Path $DownloadDir)){throw "$DownloadDir doesn't exist"}else{$DownloadDirObj = Get-Item $DownloadDir}

$PodcastEpisodes = $r|Select-Object title,link,@{l='PubDate';e={Get-Date -Format 'yyyy-MM-dd' -Date $_.pubDate}},EpisodeType,@{l='mp3url';e={$_.enclosure.url}}
if($ShowPodcastInfoOnly){
    $PodcastEpisodes
}
else{
    $PodcastEpisodesToDownload = $PodcastEpisodes
    $PodcastEpisodesToDownload | ForEach-Object -ThrottleLimit $SimultaneousDownload -Verbose -Parallel {
        Invoke-WebRequest -Uri $_.mp3url -OutFile "$($using:DownloadDirObj.FullName)/$($_.PubDate + " - " + $([regex]::Replace($_.title, '[!/:,?]', ''))).mp3"
    }   
}