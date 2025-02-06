@echo off
:menu
cls
color 4f
echo.
echo   .oOOOo.  `OooOOo.     Oo          o          `O                               
echo  .O     o   o     `o   o  O         O           o                               
echo  o          O      O  O    o        o           O                               
echo  O          o     .O oOooOoOo       O           O                               
echo  O   .oOOo  OOooOO'  o      O       o     o     o                               
echo  o.      O  o    o   O      o       O     O     O                               
echo  O.    oO   O     O  o      O       `o   O o   O'                               
echo   `OooO'    O      o O.     O        `OoO' `OoO'                               
echo.
echo OoooOOoO  .oOOOo.     Oo    o.OOOo.   o       O o          `O    Oo    o.     O ooOoOOo o.OOoOoo
echo       o  .O     o    o  O    O    `o  O       o O           o   o  O   Oo     o    O     O
echo      O   o          O    o   o      O `o     O' o           O  O    o  O O    O    o     o
echo     o    O         oOooOoOo  O      o   O   o   O           O oOooOoOo O  o   o    O     ooOOO
echo    O     O   .oOOo o      O  o      O    `O'    o     o     o o      O O   o  O    o     O
echo   o      o.      O O      o  O      o     o     O     O     O O      o o    O O    O     o
echo  O        O.    oO o      O  o    .O'     O     `o   O o   O' o      O o     Oo    O     O
echo OOooOooO   `OooO'  O.     O  OooOO'       O      `OoO' `OoO'  O.     O O     `O ooOOoOo ooOooOoO                                                       
echo.
echo.


echo Wyierz poziom lub inne opcje:
echo.
echo      [1] latwy(1-10)      [t] tabela wynikow
echo      [2] sredni(1-25)     [p] podpowiedzi
echo      [3] trudny(1-50)     [w] wyjscie
echo.
set /p wybor=Twoj wybor: 


if "%wybor%"=="1" set minimum=1 & set maksimum=10 & goto start
if "%wybor%"=="2" set minimum=1 & set maksimum=25 & goto start
if "%wybor%"=="3" set minimum=1 & set maksimum=50 & goto start
if "%wybor%"=="p" (
    if "%podpowiedz%"=="true" (
        set podpowiedz=false
        echo Podpowiedzi zostaly wylaczone.
    ) else (
        set podpowiedz=true
        echo Podpowiedzi zostaly wlaczone.
    )
    pause
    goto menu
) else if "%wybor%"=="t" (
    goto wyswietl_rekordy
) else if "%wybor%"=="w" exit
else (
    set podpowiedz=false
    goto menu
)
echo niepoprawny wybor.
pause
goto menu


:start
cls
set /a liczba_do_zgadniecia=%random% %% %maksimum% + %minimum%
set proby=0

echo Zgadnij liczbe w zakresie %minimum%- %maksimum%.
echo.


:gra
set /a proby+=1
set /p zgadnij=Twoj wybor:

if %zgadnij% LSS %liczba_do_zgadniecia% (
    if "%podpowiedz%"=="true" echo liczba jest wieksza
    goto gra
)
if %zgadnij% GTR %liczba_do_zgadniecia% (
    if "%podpowiedz%"=="true" echo liczba jest mniejsza
    goto gra
)
if %zgadnij%==%liczba_do_zgadniecia% (
    goto :zapis
)


:zapis
cls
set /p nick="Podaj nick: "

if "%podpowiedz%"=="true" (
    set dobry_wieczor= 
) else (
    set dobry_wieczor= nie 
)
echo.
echo %nick%, zgadles w %proby% probach,%dobry_wieczor%uzywajac podpowiedzi.

set rekord=999999
:: pierwszy wynik jaki pan uzyska bedzie zawsze rekordem

for /f "tokens=1" %%a in (wyniki_posortowane.txt) do (
    if %%a lss %rekord% set rekord=%%a
) 

if %proby% lss %rekord% (
    echo BRAWO, pobiles rekord zgadujac w mniej niz %rekord% probach
)
echo.
echo a to cala sciana wynikow:
echo %proby% %nick% >> wyniki.txt

sort wyniki.txt /o wyniki_posortowane.txt
for /f "tokens=1,2" %%a in (wyniki_posortowane.txt) do (
    echo %%b - %%a
)
pause
goto menu


:wyswietl_rekordy
cls
color 5f
echo  .d8888b.   .d8888b. 8888888        d8888 888b    888        d8888      888       888 Y88b   d88P 888b    888 8888888 888    d8P   .d88888b.  888       888
echo d88P  Y88b d88P  Y88b  888         d88888 8888b   888       d88888      888   o   888  Y88b d88P  8888b   888   888   888   d8P   d88P" "Y88b 888   o   888 
echo Y88b.      888    888  888        d88P888 88888b  888      d88P888      888  d8b  888   Y88o88P   88888b  888   888   888  d8P    888     888 888  d8b  888 
echo  "Y888b.   888         888       d88P 888 888Y88b 888     d88P 888      888 d888b 888    Y888P    888Y88b 888   888   888d88K     888     888 888 d888b 888   
echo     "Y88b. 888         888      d88P  888 888 Y88b888    d88P  888      888d88888b888     888     888 Y88b888   888   8888888b    888     888 888d88888b888    
echo       "888 888    888  888     d88P   888 888  Y88888   d88P   888      88888P Y88888     888     888  Y88888   888   888  Y88b   888     888 88888P Y88888     
echo Y88b  d88P Y88b  d88P  888    d8888888888 888   Y8888  d8888888888      8888P   Y8888     888     888   Y8888   888   888   Y88b  Y88b. .d88P 8888P   Y8888        
echo  "Y8888P"   "Y8888P" 8888888 d88P     888 888    Y888 d88P     888      888P     Y888     888     888    Y888 8888888 888    Y88b  "Y88888P"  888P     Y888      
echo.
sort wyniki.txt /o wyniki_posortowane.txt
for /f "tokens=1,2" %%a in (wyniki_posortowane.txt) do (
    echo %%b - %%a
)
pause
goto menu
:: oto wysylam okazalo sie ze problemem byl komentarz za ifem w jednej linii ale przy okazji w miare 
:: zoptymalizowalem kod naprawiajac kilka bledow ktore sam sobie stworzylem probujac naprawic kod i 
:: przy okazji sortowanie dziala tak jakby sortowalo litery czyli patrzy na pierwsza cyfre
:: przepraszam za klopot milego dnia!
