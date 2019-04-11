<######################################################
#
# Author: Ivan Batis - ivan.bati@dxc.com
# Usage: [Script].ps1
# Version: 0.1 [Script Description]
# Info: Simple script with no input file used to generate report of current DFS-R groups
#
#######################################################>

#Setup date and time for log output
$error.clear()

$Date = get-date -format yyyy-MM-dd
$Time = get-date -format HH-mm

Import-Module ActiveDirectory

<# Custom Variables #>

<#End of Custom Variables #>

<# Define Output Log File #>
$Output = ".\Logs\DFSR_Report_" + $date + ".txt"
If (Test-Path $Output) 
{
	Remove-Item $Output
}
<# End of Define Output Log File #>

#"Started: on " + $Date + " at " + $Time  | Add-Content $Output

<# Script itself #>

#OutPut Header
"ReplicationGroupName;ComputerName;FolderName;ContentPath;DfsnPath;DfsrGroupDfsnPath;PrimaryMember;"`
+"ReadOnly;Enabled;DfsrGroupFileNameToExclude;DfsrGroupDirectoryNameToExclude" | Add-Content $Output

$ReplicationGroupsAll = Get-DfsReplicationGroup

Foreach ($ReplicationGroup in $ReplicationGroupsAll)
{

	$GroupName = $ReplicationGroup.GroupName
	
	<#
	$ObjDfsrMembers = Get-DfsrMember -GroupName $ReplicationGroup.GroupName
	foreach ($DfsrMember in $ObjDfsrMembers)
	{
		#ComputerName
		#Site
		#Description
	}
	#>
	

	$ObjDfsrReplicatedFolders = Get-DfsReplicatedFolder -GroupName $ReplicationGroup.GroupName
	#FolderName
	$DfsrGroupFileNameToExclude = $ObjDfsrReplicatedFolders.FileNameToExclude
	$DfsrGroupDirectoryNameToExclude = $ObjDfsrReplicatedFolders.DirectoryNameToExclude
	$DfsrGroupDfsnPath = $ObjDfsrReplicatedFolders.DfsnPath
	

	$ObjDfsrMembership = Get-DfsrMembership -GroupName $ReplicationGroup.GroupName
	foreach ($DfsrMembership in $ObjDfsrMembership )
	{
		$ComputerName = $DfsrMembership.ComputerName
		$FolderName = $DfsrMembership.FolderName
		$ContentPath = $DfsrMembership.ContentPath
		$PrimaryMember = $DfsrMembership.PrimaryMember
		$ReadOnly = $DfsrMembership.ReadOnly
		$DfsnPath = $DfsrMembership.DfsnPath
		$Enabled = $DfsrMembership.Enabled

		$ReportLine = $GroupName +";"+ $ComputerName +";"+ $FolderName +";"+ $ContentPath +";"+  $DfsnPath +";"+ $DfsrGroupDfsnPath +";"+ $PrimaryMember `
						+";"+ $ReadOnly +";"+ $Enabled +";"+ $DfsrGroupFileNameToExclude +";"+ $DfsrGroupDirectoryNameToExclude
		$ReportLine | Add-Content $Output
	}



}

<# End of Script itself #>

$Date = get-date -format yyyy-MM-dd
$Time = get-date -format HH-mm
#"Finished: on " + $Date + " at " + $Time  | Add-Content $Output




