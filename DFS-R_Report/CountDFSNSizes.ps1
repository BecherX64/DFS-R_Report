<######################################################
#
# Author: Ivan Batis - ivan.bati@dxc.com
# Usage: [Script].ps1
# Version: 0.1 [Script Description]
# Info: Additional script to get size of each DFS-R group from DFS-R report.
#
#######################################################>

$item = ls .\Logs\DFSR_Report_*.txt | Select-Object -Last 1
$dfsrreport = Import-Csv $item.FullName -Delimiter ";"

$InfraServers = @("KAEDEDFS003","KAEDEDFS005","KAEDEDFS004","KAEDEDFS002")

foreach ($server in $dfsrreport)
{
	#Write-Host "Working on:" $server.ComputerName

	foreach ($InfraServer in $InfraServers)
	{
		if ($InfraServer -eq $server.computerName)
		{
			#$server.ComputerName
			#$server.DfsnPath
			Write-Host "Computer Name:" $Server.ComputerName "- Counting size of:" $server.DfsnPath
			$Item = "{0:N2} GB" -f ((gci $server.DfsnPath -Recurse | measure Length -s).Sum /1GB)
		}

	}
	Write-host $item

	

}


