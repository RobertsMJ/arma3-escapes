if (!isServer) exitWith {};
systemchat ("Initializing dynamic time multiplier");
while {true} do
{
    // From 8pm to 3am, go full speed
    if (daytime >= 18 || daytime <= 6) then
    {
        if ((daytime > 18 && daytime < 20) or (daytime > 5 && daytime < 6)) then
        {
            setTimeMultiplier 24
        }
        else
        {
            setTimeMultiplier 120
        }
    }
    else
    {
        setTimeMultiplier 36
    };
    uiSleep 10;
};
