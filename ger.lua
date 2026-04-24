-- F3F PRO BRIDGE - LUA DEFINITIF
local function run()
    -- 1. Capteurs GPS et Vario
    local gps = getValue('GPS')
    local lat, lon = 0, 0
    if type(gps) == "table" and gps.lat and gps.lon then
        lat, lon = gps.lat, gps.lon
    end

    local gSpd = getValue('GSpd') or 0   -- km/h
    local vSpd = getValue('VSpd') or 0   -- m/s
    local alt  = getValue('Alt') or 0    -- m
    
    -- 2. Commandes (Sticks)
    local ele = getValue('ele') or 0
    local ail = getValue('ail') or 0
    local rud = getValue('rud') or 0
    local thr = getValue('thr') or 0
    
    -- 3. Interrupteur de Reset (SH)
    local rst = getValue('sh') > 0 and 1 or 0

    -- 4. Envoi USB (Format : LAT;LON;GSPD;VSPD;ALT;ELE;AIL;RUD;THR;RST)
    local data = string.format("%.6f;%.6f;%.1f;%.1f;%.1f;%d;%d;%d;%d;%d\n", 
        lat, lon, gSpd, vSpd, alt, ele, ail, rud, thr, rst)

    serialWrite(data)
    return 0
end

return { run=run }