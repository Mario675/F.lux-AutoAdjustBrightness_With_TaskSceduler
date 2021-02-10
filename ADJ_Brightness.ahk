#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;FirstsetUP is a notification for the end user. 

;Create file
if !FileExist("BrightnessLevel.ini")
{  

    ;Config
    IniWrite, 1, BrightnessLevel.ini, config, FirstSetup
    IniWrite, 1000, BrightnessLevel.ini, config, Delay_length_In_MiliSeconds
    IniWrite, 1, BrightnessLevel.ini, config, Strength_Amount

    ;Live Variables section
    IniWrite, 0, BrightnessLevel.ini, Live_Variables, Stage_Tracker
    IniWrite, 0, BrightnessLevel.ini, Live_Variables, Time_Tracker

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


Time_Tracker_Value := 0
Time_Now := 0
Check_If_Next_Day_Had_Passed()
{
    IniRead, Time_Tracker_Value, BrightnessLevel.ini, Live_Variables, Time_Tracker

    FormatTime, Time_Now, ,d
    msgbox % Time_Now "and" Time_Tracker_Value

    if Time_Now not= Time_Tracker_Value
    {
        IniWrite, 0, BrightnessLevel.ini, Live_Variables, Stage_Tracker
        IniWrite, %Time_Now%, BrightnessLevel.ini, Live_Variables, Time_Tracker
    }
    return
}


Strength_Amount_Value := 0
Stage_Tracker_Value := 0
Delay_length_In_MiliSeconds_Value := null
Changing_Brightness_Upon_Running_App()
{
    IniRead, Stage_Tracker_Value, BrightnessLevel.ini, Live_Variables, Stage_Tracker
    IniRead, Delay_length_In_MiliSeconds_Value, BrightnessLevel.ini, config, Delay_length_In_MiliSeconds
    IniRead, Strength_Amount_Value, BrightnessLevel.ini, config, Strength_Amount

    {
        Stage_Tracker_Value += 1
        msgbox % Stage_Tracker_Value
        Stage_Tracker_Value *= Strength_Amount_Value
        msgbox % Stage_Tracker_Value

        if Stage_Tracker_Value >= 18
        {
            Stage_Tracker_Value = 18
        }
        

        IniWrite, %Stage_Tracker_Value%, BrightnessLevel.ini, Live_Variables, Stage_Tracker
        loop %Stage_Tracker_Value%
        {
            send !{PgDn}
            sleep Delay_length_In_MiliSeconds_Value
        }

    }
    
    TrayTip, %Stage_Tracker_Value%, ADJ_Brightness
}


{ ;Usual Main Running Procedure
    First_Setup_Check_Notification()
    Check_If_Next_Day_Had_Passed()
    Changing_Brightness_Upon_Running_App()
    exitapp
}


!x::
ExitApp



return