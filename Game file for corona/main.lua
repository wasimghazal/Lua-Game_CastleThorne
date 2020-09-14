-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )
--local backgroundsnd = audio.loadSound('Background.wav') -- background sound
-- include the Corona "composer" module
local composer = require "composer"

-- load menu screen
--audio.play(backgroundsnd)
composer.gotoScene( "menu" ) 
