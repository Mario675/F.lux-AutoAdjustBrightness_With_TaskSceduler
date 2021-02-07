#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;FirstsetUP is a notification for the end user. 

;Create file
if !FileExist("BrightnessLevel.ini")
{  

    IniWrite, 1, BrightnessLevel.ini, config, FirstSetup
    IniWrite, 1, BrightnessLevel.ini, config, Delay_length_In_MiliSeconds
    IniWrite, 0, BrightnessLevel.ini, Live_Variables, Stage_Tracker

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

Stage_Tracker_Value := 0
Delay_length_In_MiliSeconds_Value := null
Changing_Brightness_Upon_Running_App()
{
    IniRead, Stage_Tracker_Value, BrightnessLevel.ini, Live_Variables, Stage_Tracker
    IniRead, Delay_length_In_MiliSeconds_Value, BrightnessLevel.ini, config, Delay_length_In_MiliSeconds

    switch Stage_Tracker_Value
    {
        Case 0:
        {
            Stage_Tracker_Value += 1
            loop 2
            {
                send !{PgDn}
                sleep Delay_length_In_MiliSeconds_Value
            }
            goto OutOfSwitch
        }

        case 1:
        {

            goto OutOfSwitch
        }

        case 2:
        {

            goto OutOfSwitch
        }

    }
    OutOfSwitch:

    TrayTip, %Stage_Tracker_Value%, ADJ_Brightness
}


{ ;Usual Main Running Procedure
    First_Setup_Check_Notification()
    Changing_Brightness_Upon_Running_App()
    return
}






return