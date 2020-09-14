-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()


-- include Corona's "widget" library
local widget = require "widget"



--------------------------------------------

local physics = require "physics" 
physics.start()

-- forward declarations and other locals
local playBtn
local bgMusic = audio.loadStream('Background.wav') -- do I need this music here??
local player
-- 'onRelease' event listener for playBtn
local function gotoGame()
	
	-- go to level1.lua scene
	--composer.gotoScene( "level1", "fade", 500 )
	composer.gotoScene( "level1", { time=800, effect="crossFade" } )
	return true	-- indicates successful touch
end

local function onCreditBtnRelease()
	
	-- go to level1.lua scene
	composer.gotoScene( "credit", "fade", 500 )
	
	return true	-- indicates successful touch
end


function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect( "images/background1.jpg", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	
	local tutorial = display.newImageRect( "images/tutorial.png", display.contentHeight + 65, display.contentHeight-205);
	tutorial.x = display.screenOriginX + 100
	tutorial.y = display.screenOriginY +50
	tutorial.width = tutorial.width/2
	tutorial.height = tutorial.height/2
	
	
	local door = display.newImage( "images/door.png", display.contentHeight + 65, display.contentHeight-255);
	door.width = door.width/20
	door.height = door.height/20	
	
	-- create/position logo/title image on upper-half of the screen
	local titleLogo = display.newImageRect(sceneGroup, "images/titleA.png", 300, 35 )
	titleLogo.x = display.contentCenterX
	titleLogo.y = 100
	--titleLogo.alpha=0
	physics.addBody( titleLogo, "static")

	
	player = display.newImage( "images/man.png", display.contentHeight - 225, display.contentHeight-250);
	player.width = player.width/3
	player.height = player.height/3
	physics.addBody( player, "static" ,{ density=1.0, friction=0.3, bounce=0.2 } )
	player.isFixedRotation = true


function actionList( event )

	if (player.x <= door.x ) then
	player.x = player.x + 0.25
	elseif (player.x >= door.x )then
	player.x = player.x
	end
end	
Runtime:addEventListener( "enterFrame", actionList )
	
player:applyLinearImpulse(0, 0, player.x, player.y)
	
	
	-- create a widget button (which will loads level1.lua on release)
	local playButton = display.newText( sceneGroup, "Play Now", display.contentCenterX, display.contentCenterY + 50, native.systemFont, 20 )
	playButton:setFillColor( 0.82, 0.86, 1 )

	local creditButton = display.newText( sceneGroup, "Credits", display.contentCenterX, display.contentCenterY + 90, native.systemFont, 20 )
	creditButton:setFillColor( 0.75, 0.78, 1 )

	
	playButton:addEventListener( "tap", gotoGame )
	creditButton:addEventListener( "tap", onCreditBtnRelease )
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( tutorial )
	sceneGroup:insert( playButton )
	sceneGroup:insert( creditButton )
	sceneGroup:insert( titleLogo )
	sceneGroup:insert( door ) ------ add door
	sceneGroup:insert( player ) ------ add player
	
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	
	player.x = display.contentHeight - 225
	-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		 
		audio.play(bgMusic,   { channel=1, loops=-1, fadein=90000 }) 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
	physics.start()
	physics.stop()				-- to remove the titleLogo
	
	audio.pause()
	
	
	
	
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
		 physics.start()
		
		
		end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	audio.pause()
	physics.stop()
	titleLogo:removeSelf()
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
	
	------------------------------------------
		
	------------------------------------------
	if creditBtn then
		creditBtn:removeSelf()	-- widgets must be manually removed
		creditBtn = nil
	end
	
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


-----------------------------------------------------------------------------------------

return scene