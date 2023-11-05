if (!isServer) exitWith {};
systemchat ("Initializing dynamic time multiplier");
while {true} do
{
    // From 8pm to 3am, go full speed
    if (daytime >= 18 || daytime <= 6) then
    {
        if ((daytime > 18 && daytime < 20) or (daytime > 5 && daytime < 6)) then
        {
            systemchat ("Setting time multi to 24");
            setTimeMultiplier 24
        }
        else
        {
            systemchat ("Setting time multi to 120");
            setTimeMultiplier 120
        }
    }
    else
    {
        systemchat ("Setting time multi to 36");
        setTimeMultiplier 36
    };
    uiSleep 10;
};
