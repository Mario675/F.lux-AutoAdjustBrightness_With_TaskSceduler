#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;FirstsetUP is a notification for the end user. 

;Create file
if !FileExist("BrightnessLevel.ini")
{  

    IniWrite, 1, BrightnessLevel.ini, config, FirstSetup
    IniWrite, 0, BrightnessLevel.ini, config, Delay_length


    TrayTip, Added BrightnessLevel.ini Config File!, ADJ_Brightness, 3
}



First_set_up_Value := 0
First_Setup_Check_Notification()
{
    IniRead, First_set_up_Value, BrightnessLevel.ini, config, FirstSetup
    if First_set_up_Value = 1
    {
        msgbox It appears that you have first launched the program for the first time.`n Please configure this program in task scheduler.
        IniWrite, 0, BrightnessLevel.ini, config, FirstSetup
        TrayTip, FirstSetup Value Changed to 0, ADJ_Brightness, 3
    }

    return
}

First_Setup_Check_Notification()





return