for ($i=1; $i -le 20; $i++) {
    Copy-Item -Path ".\$i.jpg" -Destination ".\$($i+40).jpg"
	
}