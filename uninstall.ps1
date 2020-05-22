# Based on @nerdio01's version in https://github.com/microsoft/terminal/issues/1060

$localCache = "$Env:LOCALAPPDATA\Microsoft\WindowsApps\Cache"
if (Test-Path $localCache) {
    Remove-Item $localCache -Recurse
}

if ($args.Count -eq 1) {
    $layout = $args[0]
} else {
    $layout = "default"
}

Write-Host "Use" $layout "layout."

if ($layout -eq "default") {
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\shell\AddMenuTerminal' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\AddMenuTerminal' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\ContextMenus\AddMenuTerminal\shell' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\shell\AddMenuTerminalAdmin' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\AddMenuTerminalAdmin' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\ContextMenus\AddMenuTerminalAdmin\shell' -Recurse -ErrorAction Ignore | Out-Null
} elseif ($layout -eq "flat") {
    $rootKey = 'HKEY_CLASSES_ROOT\Directory\shell'
    foreach ($key in Get-ChildItem -Path "Registry::$rootKey") {
       if (($key.Name -like "$rootKey\AddMenuTerminal_*") -or ($key.Name -like "$rootKey\AddMenuTerminalAdmin_*")) {
          Remove-Item "Registry::$key" -Recurse -ErrorAction Ignore | Out-Null
       }
    }

    $rootKey = 'HKEY_CLASSES_ROOT\Directory\Background\shell'
    foreach ($key in Get-ChildItem -Path "Registry::$rootKey") {
       if (($key.Name -like "$rootKey\AddMenuTerminal_*") -or ($key.Name -like "$rootKey\AddMenuTerminalAdmin_*")) {
          Remove-Item "Registry::$key" -Recurse -ErrorAction Ignore | Out-Null
       }
    }
} elseif ($layout -eq "mini") {
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\shell\AddMenuTerminalMini' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\shell\AddMenuTerminalAdminMini' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\AddMenuTerminalMini' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\AddMenuTerminalAdminMini' -Recurse -ErrorAction Ignore | Out-Null
}

Write-Host "Windows Terminal uninstalled from Windows Explorer context menu."
