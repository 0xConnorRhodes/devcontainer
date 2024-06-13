#!/usr/bin/env pwsh

$modules = @(
	"verkadaModule"
)

$modules | ForEach-Object { Install-Module -Force -Name $_ }

$psversiontable > /home/connor/pstest.txt
