 <#

.SYNOPSIS
Creating a log of every Powershell session using Powershell Start-Transcript cmdlet.

.DESCRIPTION
Many times, you want to keep a record of what you type into Powershell to look back or to check for any error later or output.
The Start-Transcript cmdlet allows to create a transcript of your current Powershell session.

.EXAMPLE

Invoke-Command -ScriptBlock {Start-Transcript C:\PSHistory\PSTranscript.log}

or

$PSTranscriptLogName = 'Transcript_' + [string](get-date -Format MMddyyyy) + '.log'
Invoke-Command -ScriptBlock {Start-Transcript C:\PSHistory\$PSTranscriptLogName}

.NOTES
You can either use:
[string](get-date -Format MMddyyyy) 
or 
[string](get-date).Month + [string](get-date).day + [string](get-date).Year

In addition, if you do not wish to copy and paste the above script every time you have to open a new Powershell session, you can edit the default $profile file with Notepad and copy and paste the code there; and every time powershell.exe or powershell_ise.exe opens, the transcript will be saved.
The are different $profile files for Powershell ISE and Powershell.
The transcript will end when powershell is closed.

New-Item –Path $Profile –Type File –Force

notepad $Profile

To remove the $profile file:

Remove-Item -Path $profile

Author: Omar Rosa

#>


$setTranscriptSB = {

Set-StrictMode -Version Latest

# Setting the value for this variable with MonthDayYear-PowershellProcessID.log to be name of the log:

$PSTranscriptLogName = 'Transcript_' + [string](get-date).Month + [string](get-date).day + [string](get-date).Year + '_' + [string](Get-Process -Name powershell*).Id + '.log'

if (!(Test-Path C:\PSHistory)) # Check whether or not the PSHistory folder exists
{
    New-Item -Path C:\PSHistory -ItemType Directory
    Start-Transcript -path C:\PSHistory\$PSTranscriptLogName -Append
}

else
{
    Start-Transcript -path C:\PSHistory\$PSTranscriptLogName -Append 
}

}

Invoke-Command -ScriptBlock $setTranscriptSB

