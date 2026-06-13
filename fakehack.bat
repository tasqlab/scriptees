@echo off
title SYSTEM MAINBOARD ACTIVE
mode con: cols=80 lines=25
color 0a

echo =====================================================================
echo                     INITIALIZING OVERLORD PROTOCOL
echo =====================================================================
timeout /t 2 >nul

:: Phase 1: The Visual Sequence Countdown
for /L %%i in (5,-1,1) do (
    cls
    echo =====================================================================
    echo                     INITIALIZING OVERLORD PROTOCOL
    echo =====================================================================
    echo.
    echo               [!] WARNING: ESTABLISHING QUANTUM LINK...
    echo.
    echo                          SECURE INITIATION IN: %%i
    echo.
    echo =====================================================================
    timeout /t 1 >nul
)

:: Phase 2: The Main Animated Live Display Loop
:dashboard_loop
cls
color 0b
echo =====================================================================
echo [✓] OVERLORD PROTOCOL ACTIVE             STATUS: STEALTH / ENCRYPTED
echo =====================================================================
echo.
echo  [+] GATEWAY INSTANCE  : detnsw.network.node.01
echo  [+] TUNNEL ROUTING    : Cloudflare One Client [Traffic Only]
echo  [+] HANDSHAKE STATUS  : 1.1.1.1 (Encrypted DoH)
echo.
echo ---------------------------------------------------------------------
echo  SYSTEM TELEMETRY ENGINE                                 LIVE REFRESH
echo ---------------------------------------------------------------------
echo.

:: Randomly picking fake status signals to make it look alive and moving
set /a rand1=%random% %% 3
set /a rand2=%random% %% 90 + 10

if %rand1%==0 (
    color 0a
    echo  [NODE_01] STATUS: NOMINAL   ^| LOAD: %rand2%%%   ^| PROX_CONN: SECURE
)
if %rand1%==1 (
    color 0e
    echo  [NODE_02] STATUS: THROTTLE  ^| LOAD: %rand2%%%   ^| SHADOWSOCKS: BYPASS
)
if %rand1%==2 (
    color 0d
    echo  [NODE_03] STATUS: ROUTING   ^| LOAD: %rand2%%%   ^| VANGUARD: COEXIST
)

echo.
echo ---------------------------------------------------------------------
echo  ACTIVE SUB-ROUTINE INJECTION TRAFFIC:
echo ---------------------------------------------------------------------
:: Printing some random hexadecimal memory addresses
echo  0x%random%  --  [SYSTEM_SHIELD_ACTIVE]  --  PING: 12ms
echo  0x%random%  --  [ECH_HANDSHAKE_OK]      --  PORT: 443
echo  0x%random%  --  [ZENITH_APEX_STANDS]    --  TUNNEL: OPEN
echo.
echo =====================================================================
echo Press Ctrl + C to abort mainframe connection.
timeout /t 3 >nul
goto dashboard_loop
