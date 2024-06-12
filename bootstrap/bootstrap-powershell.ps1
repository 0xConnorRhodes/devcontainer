#!/usr/bin/env pwsh

$modules = @(
	"verkadaModule"
)

$modules | ForEach-Object { Install-Module -Force -Name $_ }
