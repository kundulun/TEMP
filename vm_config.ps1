Connect-VIServer -Server 10.0.1.103
Get-VM | Select-Object Name,numcpu,MemoryGB,@{n="HardDiskSizeGB"; e={(Get-HardDisk -VM $_ | Measure-Object -Sum CapacityGB).Sum}}

# Name NumCpu MemoryGB HardDiskSizeGB
# ---- ------ -------- --------------
# d11       2        1              5
# d22       1        4              9
