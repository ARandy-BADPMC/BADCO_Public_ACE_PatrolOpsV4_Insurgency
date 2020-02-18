class Clear {
    Overcast[] = {0.1,0.4};
    Fog[] = {0.45,0.08,25};
    Wind[] = {0,5};
    Lightning = 0;
    PPeffect = "";
    FilmGrain[] = {0,0,0,0,0};
    ColorCorrections[] = {
        1,1,0,
        { 0,0,0,0 },
        { 1,1,1,1 },
        { 0,0,0,0 }
    };
};
class Overcast_Light: Clear {
    Overcast[] = {0.4,0.6};
    Wind[] = {1,4};
};
class Overcast_Heavy: Clear {
    Overcast[] = {0.6,0.9};
    Wind[] = {3,9};
};
class Thunderstorm: Clear {
    Overcast = 1;
    Lightning = 1;
    Wind[] = {3,9};
};
class Sandstorm: Clear {
    colorCorrections[] = {
        0.5,0.8,0,
        { 1.01,-2.46,-1.23,0 },
        { 2.11,1.6,0.71,0.8 },
        { 1.43,0.56,3.69,0.31 }
    };
    PPeffect = "Sandstorm";
};
class Snowstorm: Clear {
    Fog[] = {0.3,0.001,90};
    colorCorrections[] = {
        0.5,0.2,0,
        { 0,0,0,0 },
        { 1,1,1,1 },
        { 0,0,0,0 }
    };
    PPeffect = "Snowstorm";
};
class Nuclear: Clear {
    colorCorrections[] = {
        0.5,0.2,0,
        { 0,0,0,0 },
        { 1,1,1,1 },
        { 0,0,0,0 }
    };
    PPeffect = "Nuclear";
};