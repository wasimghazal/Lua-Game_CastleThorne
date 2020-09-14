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

-- forward declarations and other locals
local playBtn

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
	
	-- go to level1.lua scene
	composer.gotoScene( "menu", "fade", 500 )
	
	return true	-- indicates successful touch
end

--vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local creditText 
local uiGroup = display.newGroup()


--local title = display.newImageRect( "images/wasim.png", 160, 21 )
	--title.x =display.screenOriginX +300
	--title.y =display.screenOriginY +50
local wasim = display.newImageRect( uiGroup, "images/wasim.png", 160, 21 )
	wasim.x =display.screenOriginX +300
	wasim.y =display.screenOriginY +100
local jessica = display.newImageRect(uiGroup, "images/jessica.png", 160, 21 )
	jessica.x =display.screenOriginX +300
	jessica.y =display.screenOriginY +150	
local lucy = display.newImageRect(uiGroup, "images/lucy.png", 160, 21 )
	lucy.x =display.screenOriginX +300
	lucy.y =display.screenOriginY +200		
	
--creditText = display.newText( uiGroup, "Credit by: " , 250, 80, native.systemFont, 30 )
--creditText:setFillColor( 25, 0, 0 )
--creditText2 = display.newText( uiGroup, "1) Wasim G Aswad - 17193559" , 340, 120, native.systemFont, 24 )
--creditText2:setFillColor( 25, 0, 25 )
--creditText3 = display.newText( uiGroup, "2) Lucy Dolan Egan - 18222765" , 250, 160, native.systemFont, 24 )
--creditText3:setFillColor( 25, 25, 0 )
--creditText4 = display.newText( uiGroup, "3) Jessica O'Flynn - 18252435" , 250, 200, native.systemFont, 24 )
--creditText4:setFillColor( 0, 25, 25 )
--local function updateText()
  --creditText.text = "Lives: " .. lives
 
--end
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

function scene:create( event )
	local sceneGroup = self.view
	 
	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImageRect( "images/background1.jpg", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	
	-- create/position logo/title image on upper-half of the screen
	local titleLogo = display.newImageRect( "images/titleA.png", 250, 40 )
	titleLogo.x = display.contentCenterX - 200
	titleLogo.rotation = 270
	titleLogo.y = display.contentCenterY 

	--vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
	--local Text = display.newText( uiGroup, "Lives: " .. lives, 200, 80, native.systemFont, 36 )
	--label = "17193559  Wasim G Aswad",
	
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	-- create a widget button (which will loads level1.lua on release)
	playBtn = widget.newButton{
		label="Back",
		labelColor = { default={255}, over={128} },
		default="button.png",
		over="button-over.png",
		width=154, height=40,
		onRelease =  onPlayBtnRelease	-- event listener function
	}
	playBtn.x = display.contentCenterX
	playBtn.y = display.contentHeight - 50
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( titleLogo )
	sceneGroup:insert( playBtn )
	--sceneGroup:insert( title )
	sceneGroup:insert( wasim )
	sceneGroup:insert( lucy )
	sceneGroup:insert( jessica )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
			audio.resume()
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
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