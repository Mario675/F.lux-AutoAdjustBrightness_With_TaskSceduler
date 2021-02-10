# Setup

## Configuring ADJ_Brightness

1. Launch script once to generate ini configoration file.
2. Under the section config, you can adjust these two settings:

    ```ini
    Delay_length_In_MiliSeconds=1000
    Strength_Amount=1
    ```

## What does these varibles in `config` mean?

- `Delay_length_In_MiliSeconds`, means the amount of time the program will gradually adjust your brightness. This means, you can have a subtle adjustment in brightness, or have it instantly change black. By default, `Delay_length_In_MiliSeconds` is set to 1000ms, or aka, 1 second.

- `Strength_Amount`, means it will mutply your current `Stage tracker` by `Strength_Amount`. If you want to have ADJ Brightness ramp down the brightness over time, increase this value, and try it out for youself.

## What does the variables in `Live_Variables` mean?

- `Stage_Tracker`, will track the amount of times it already adjusted your brightness by pressing ***Alt+PgDn***. Each time the program is run, it adds **1** to this amount.

- `Time_Tracker`, will track what date it last was when the ADJ_Brightness was run. This means, the next time ADJ_Brightness launches the next day, it will reset the `Stage_Tracker` value to **0**.

