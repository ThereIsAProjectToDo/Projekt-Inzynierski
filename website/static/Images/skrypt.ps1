for ($i=1; $i -le 40; $i++) {
    Copy-Item -Path ".\$i.jpg" -Destination ".\$($i+100).jpg"
}