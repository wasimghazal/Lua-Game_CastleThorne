

local composer = require "composer"
local scene = composer.newScene()






-- include Corona's "widget" library
local widget = require "widget"


local physics = require "physics"
physics.start()
physics.setGravity( 0, 9.8 )



local shootSnd = audio.loadSound('shoot.wav')
local jumpSnd = audio.loadSound('jump.wav') -- jump sound
--local movingSnd = audio.loadSound('moving.wav') -- moving sound
local G_OSnd = audio.loadSound('loser.wav') -- Game Over sound


local lives = 3
local score = 0

function winGame()

composer.gotoScene( "menu", { time=800, effect="crossFade" } )

end


function endGame()
	composer.gotoScene( "menu", { time=800, effect="crossFade" } )
end

local function updateText()
    livesText.text = "Lives: " .. lives
    scoreText.text = "Score: " .. score
end


local _platform = display.newImageRect ( "images/platformBase4.png",250,40)  -- the roof)
_platform.x = display.contentCenterX - 120
_platform.y = display.contentCenterY  -140
physics.addBody( _platform, "static", { friction=0.3 } )
_platform.alpha=0

	local background0 = display.newImageRect( "images/background1.jpg" , 580 ,350)
background0.x = display.contentCenterX - 580
background0.y = display.contentCenterY

local background = display.newImageRect( "images/secondBackgroundImage.jpg" , 580 ,350)
background.x = display.contentCenterX
background.y = display.contentCenterY

local background1 = display.newImageRect( "images/firstBackgroundImage.jpg" , 580 ,350)
background1.x = display.contentCenterX + 580
background1.y = display.contentCenterY

local background2 = display.newImageRect("images/secondBackgroundImage.jpg" , 580 ,350)
background2.x = display.contentCenterX + 1160
background2.y = display.contentCenterY

local background3 = display.newImageRect("images/firstBackgroundImage.jpg" , 580 ,350)
background3.x = display.contentCenterX + 1740
background3.y = display.contentCenterY

local background4 = display.newImageRect("images/background1.jpg" , 580 ,350)
background4.x = display.contentCenterX + 2320
background4.y = display.contentCenterY

local life1 = display.newImage( "images/man.png" ) -- first life
life1.x = display.contentCenterX - 270
life1.y = display.contentCenterY  -140
life1.width = life1.width/4
life1.height = life1.height/4
life1.gravityScale = 0
life1.alpha=1

local life2 = display.newImage( "images/man.png" ) -- second life
life2.x = display.contentCenterX - 250
life2.y = display.contentCenterY  -140
life2.width = life1.width
life2.height = life1.height
life2.gravityScale = 0
life2.alpha=1

local life3 = display.newImage( "images/man.png" ) -- third life
life3.x = display.contentCenterX - 230
life3.y = display.contentCenterY  -140
life3.width = life1.width
life3.height = life1.height
life3.gravityScale = 0
life3.alpha=1

local wall = display.newImageRect ( "images/platformBase4.png",250,40) -- the wall
wall.x = display.contentCenterX  - 300
wall.y = display.contentCenterY  + 5
wall.rotation = 90
physics.addBody( wall, "static")

local platform2 = display.newImageRect ( "images/platformBase4.png",250,40) -- first platform
platform2.x = display.contentCenterX - 160
platform2.y = display.contentCenterY + 150
physics.addBody( platform2, "static", { friction=0.3 } )

local platform3 = display.newImageRect ( "images/platformBase4.png",250,40)  -- sec platform
platform3.x = display.contentCenterX  + 86
platform3.y = display.contentCenterY + 150
physics.addBody( platform3, "static", { friction=0.3 } )

local platform4 = display.newImageRect ( "images/platformBase4.png",250,40) -- third platform
platform4.x = display.contentCenterX  + 333
platform4.y = display.contentCenterY + 150
physics.addBody( platform4, "static", { friction=0.3 } )

local platform5 = display.newImageRect ( "images/platformBase3.png",250,40)  -- fourth platform (top)
platform5.x = display.contentCenterX + 633
platform5.y = display.contentCenterY
physics.addBody( platform5, "static", { friction=0.3 } )

local platform6 = display.newImageRect ( "images/platformBase4.png",250,40)  -- fourth platform (after top)
platform6.x = display.contentCenterX + 933
platform6.y = display.contentCenterY + 150
physics.addBody( platform6, "static", { friction=0.3 } )

local platform7 = display.newImageRect ( "images/platformBase4.png",250,40)  -- the platform after hall (after top)
platform7.x = display.contentCenterX + 1305
platform7.y = display.contentCenterY + 150
physics.addBody( platform7, "static", { friction=0.3 } )

local platform8 = display.newImageRect ( "images/platformBase4.png",250,40)  -- fourth platform (after top)
platform8.x = display.contentCenterX + 1550
platform8.y = display.contentCenterY + 150
physics.addBody( platform8, "static", { friction=0.3 } )

local platform_ = display.newImageRect ( "images/platformBase4.png",250,40)  -- fourth platform (after top)
platform_.x = display.contentCenterX + 1795
platform_.y = display.contentCenterY + 150
physics.addBody( platform_, "static", { friction=0.3 } )

local platform9 = display.newImageRect ( "images/platformBase4.png",250,40)  -- the last platform (after top)
platform9.x = display.contentCenterX + 2040
platform9.y = display.contentCenterY + 150
physics.addBody( platform9, "static", { friction=0.3 } )

local wall_ = display.newImageRect ( "images/platformBase4.png",250,40) -- the last wall
wall_.x = display.contentCenterX  + 2145
wall_.y = display.contentCenterY  + 5
wall_.rotation = 90
physics.addBody( wall_, "static")
wall_.alpha=1

local door = display.newImageRect ( "images/door.png",100 ,100) -- the last door
door.x = display.contentCenterX  + 2005
door.y = display.contentCenterY  + 80
door.alpha=1

local door_ = display.newImageRect ( "images/door.png",100 ,100 ) -- the first door
door_.x = display.contentCenterX  -90
door_.y = display.contentCenterY

local enemy = display.newImageRect ( "images/enemy.png",60,60)  -- enemy
enemy.x = display.contentCenterX + 2005
enemy.y = display.contentCenterY + 100
enemy.myName = "enemy"
enemy.name = "life"
physics.addBody( enemy)
enemy.isFixedRotation = true
enemy.alpha=1

local box = display.newRect(150 , 264.46252441406 ,10 ,10)
box.alpha=0

local box_ = display.newRect(206 ,270 ,10 ,10)
box_.alpha=0

local _box = display.newRect(94 ,270 ,10 ,10)
_box.alpha=0


local player = display.newImage( "images/man.png", display.contentHeight - 170, display.contentHeight-150)
player.width = player.width/2
player.height = player.height/2
player.myName = "player"
player.name ="life"
physics.addBody( player, { density=1.0, friction=0.3, bounce=0.2 } )
player.isFixedRotation = true
player.alpha=1

local gameOver = display.newImage( "images/game_over.png" )
	gameOver.x = display.contentCenterX-- - 270
	gameOver.y = display.contentCenterY--  -140
	gameOver.width = gameOver.width/3
	gameOver.height = gameOver.height/3
	gameOver.rotation = -35
	gameOver.alpha=0
	
local winner = 	display.newImage( "images/winner.png" )
	winner.x = display.contentCenterX-- - 270
	winner.y = display.contentCenterY--  -140
	winner.width = winner.width/3
	winner.height = winner.height/3
	--gameOver.rotation = -35
	winner.alpha=0

-- Controllers
-- action buttons
-- Jump button
local swordButton = display.newImage( "images/swordButton.png", 450,  display.contentHeight-80 )
swordButton.width = swordButton.width/5
swordButton.height = swordButton.height/5
function shoot( event )
    audio.play(shootSnd)
    local bullet = display.newImage( "images/bullet.png" )
	physics.addBody( bullet, "dynamic" )
	bullet.width = bullet.width/2
	bullet.height = bullet.height/2
	bullet.myName = "bullet"
	bullet.x = player.x
	bullet.y = player.y
	bullet.gravityScale = 0
	bullet.isBullet = true
	bullet.isSensor = true
	bullet.alpha=1
if (enemy.name == "life" and player.name == "life") then
	if (player.x <= enemy.x) then
		transition.to( bullet, { x=400, time=500,
        onComplete = function() display.remove( bullet ) end
    } )
	elseif (player.x >= enemy.x) then
			transition.to( bullet, { x=-400, time=900,
        onComplete = function() display.remove( bullet ) end
    } )
	end
elseif(enemy.name == "dead" and player.name == "life")then
	transition.to( bullet, { x=400, time=500,
        onComplete = function() display.remove( bullet ) end
    } )
	end
end


local jumpButton = display.newImage( "images/jumpButton.png", 490, display.contentHeight-120 )
jumpButton.width = jumpButton.width/5
jumpButton.height = jumpButton.height/5
jumpButton.alpha=1
function jump( event )
	if(player.name == "life") then
	audio.play(jumpSnd)
	player:applyForce( 0, -1000, player.x, player.y )
		return true
	end
end
jumpButton:addEventListener("touch", jump)


-- Right button
local rightButton = display.newImage("images/rightButton.png", 60, display.contentHeight-80 )
rightButton.width = rightButton.width/5
rightButton.height = rightButton.height/5
function moveRight( event )
	if (event.phase == "began") then
	
		player.action = "right"
		
	else
		player.action = "stop"
	end

	return true
end

local leftButton = display.newImage( "images/leftButton.png", 0, display.contentHeight-80 )
leftButton.width = leftButton.width/5
leftButton.height = leftButton.height/5
leftButton.alpha=1
function moveLeft( event )
	if (event.phase == "began")  then
	
		player.action = "left"
			
		else
		player.action = "stop"
	end
	return true
end
if(player.name == "life")then
rightButton:addEventListener("touch", moveRight)
leftButton:addEventListener("touch", moveLeft)
swordButton:addEventListener("tap", shoot)
end

function right()
player:applyLinearImpulse(0, 0, player.x, player.y)
		background2.x = background2.x - 5
		background0.x = background0.x - 5
		background.x = background.x - 5
		background1.x = background1.x - 5
		background3.x = background3.x - 5
		background4.x = background4.x -5
		wall.x = wall.x - 5
		wall_.x = wall_.x - 5
		platform2.x = platform2.x - 5
		platform3.x = platform3.x - 5
		platform4.x = platform4.x - 5
		platform5.x = platform5.x - 5
		platform6.x = platform6.x - 5
		platform7.x = platform7.x - 5
		platform8.x = platform8.x - 5
		platform9.x = platform9.x - 5
		platform_.x = platform_.x - 5
		door.x = door.x - 5
		door_.x = door_.x - 5
		if (enemy.name == "life") then
		enemy.x = enemy.x - 5
		end
end

function left()
player:applyLinearImpulse(0, 0, player.x, player.y)
background2.x = background2.x + 5
		background0.x = background0.x + 5
		background.x = background.x + 5
		background1.x = background1.x + 5
		background3.x = background3.x + 5
		background4.x = background4.x +5
		wall.x = wall.x + 5
		wall_.x = wall_.x + 5
		platform2.x = platform2.x + 5
		platform3.x = platform3.x + 5
		platform4.x = platform4.x + 5
		platform5.x = platform5.x + 5
		platform6.x = platform6.x + 5
		platform7.x = platform7.x + 5
		platform8.x = platform8.x + 5
		platform9.x = platform9.x + 5
		platform_.x = platform_.x + 5
		door.x = door.x + 5
		door_.x = door_.x + 5
		if (enemy.name == "life") then
		enemy.x = enemy.x + 5
		end
end

function restart()

audio.play(G_OSnd) -- play sound when the player dead
print("lives= " .. lives)

	if (lives == -1) then
	player.name= "dead"
	print("player is " .. player.name)
	swordButton.alpha = 0
leftButton.alpha = 0
rightButton.alpha = 0
jumpButton.alpha = 0
	gameOver.alpha=1
	
		timer.performWithDelay( 2000, endGame )
	end
	if (lives == 2 ) then
	life3.alpha=0.5
	elseif (lives == 1 ) then
	life2.alpha=0.5
	elseif (lives == 0 ) then
	life1.alpha=0.5
	end


	_platform.x = display.contentCenterX - 120
	_platform.alpha = 0
	background0.x = display.contentCenterX - 580
	background0.alpha = 1
	background.x = display.contentCenterX
	background.alpha = 1
	background1.x = display.contentCenterX + 580
	background1.alpha = 1
	background2.x = display.contentCenterX + 1160
	background2.alpha = 1
	background3.x = display.contentCenterX + 1740
	background3.alpha = 1
	background4.x = display.contentCenterX + 2320
	background4.alpha = 1
	wall.x = display.contentCenterX  - 300
	wall.alpha = 1
	platform2.x = display.contentCenterX - 160
	platform2.alpha = 1
	platform3.x = display.contentCenterX  + 86
	platform3.alpha = 1
	platform4.x = display.contentCenterX  + 333
	platform4.alpha = 1
	platform5.x = display.contentCenterX + 633
	platform5.alpha = 1
	platform6.x = display.contentCenterX + 933
	platform6.alpha = 1
	platform7.x = display.contentCenterX + 1305
	platform7.alpha = 1
	platform8.x = display.contentCenterX + 1550
	platform8.alpha = 1
	platform_.x = display.contentCenterX + 1795
	platform_.alpha = 1
	platform9.x = display.contentCenterX + 2040
	platform9.alpha = 1
	wall_.x = display.contentCenterX  + 2145
	wall_.alpha = 1
	door.x = display.contentCenterX  + 2005
	door.alpha = 1
	door_.x = display.contentCenterX  -90
	door_.alpha = 1
	enemy.x = display.contentCenterX  + 2005
	enemy.alpha = 1
	if (lives >= 0) then
	player.x = display.contentCenterX - 90
	player.y = display.contentCenterY
	player.alpha = 1
	--player.name = "life"
	end

	
	
	
end




function actionList( event )
if( player.alpha == 1 and player.x ~= door.x ) then
	if (player.x > box_.x or player.x < _box.x ) then
		player.x = display.contentHeight - 170
	end
end
if(enemy.name == "life") then
if ( enemy.x < box_.x and enemy.x >_box.x )then
if ( player.y >= box.y ) then --or player.y - 50 == box.y ))then
lives = lives -1
restart()
end 
end
end


if (box_.x ~= wall_.x) then
if(player.action == "right" and player.name == "life") then
if(wall_.x - 40 >= box_.x and player.name == "life") then
right()
end
elseif (player.action == "left" and player.name == "life") then
if(wall.x + 50 <= player.x and player.name == "life") then
left()
end
end
end

if (player.name == "life" and enemy.name == "life") then
	if(box.x ~= door.x) then
		if(enemy.x <= player.x) then
		enemy.x = enemy.x + 0.5
		elseif(enemy.x + 100 <= platform7.x) then
		enemy.x = enemy.x
		elseif(enemy.x + 10 >= player.x) then
		enemy.x = enemy.x + -0.5
		end
	end
	

	if (player.y > display.contentCenterY + 150 and lives ~= -1)then-- and enemy.name == "life") then
	lives = lives -1
	print("player is " .. player.name .. " and enemy is " .. enemy.name)
	restart()
	elseif (enemy.name == "dead" and player.y > display.contentCenterY + 150 and life ~= -1) then
	lives = lives -1
	print("player is " .. player.name .. " and enemy is " .. enemy.name)
	restart()
	end
	
	end
	
	

if(box.x >= door.x) then
swordButton.alpha = 0
leftButton.alpha = 0
rightButton.alpha = 0
jumpButton.alpha = 0
player.name= "dead"
winner.alpha = 1
timer.performWithDelay( 2000, winGame )
end

end

Runtime:addEventListener( "enterFrame", actionList )


local function onCollision( event )

    if ( event.phase == "began" ) then

        local obj1 = event.object1
        local obj2 = event.object2

        if ( ( obj1.myName == "bullet" and obj2.myName == "enemy" ) or
             ( obj1.myName == "enemy" and obj2.myName == "bullet" ) )
        then
            -- Remove both the bullet and enemy
            enemy.name = "dead"
			print("enemy is " .. enemy.name)
			display.remove( obj1 )
            display.remove( obj2 )
			



             -- Increase score
            score = score + 100
            scoreText.text = "Score: " .. score
		-- print("your score is " .. score)

        elseif ( ( obj1.myName == "player" and obj2.myName == "enemy" ) or
                 ( obj1.myName == "enemy" and obj2.myName == "player" ) )
        then
            if ( died == true ) then
                died = true

                -- Update lives
                lives = lives - 1
				print ("lives: " .. lives )
              --  livesText.text = "Lives: " .. lives

                if ( lives == 0 ) then
                    display.remove( player )
										timer.performWithDelay( 2000, endGame )
                else
                    player.alpha = 0
                    timer.performWithDelay( 1000, restorePlayer )
                end
            end
        end
    end
end



---------------------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view


	scoreText = display.newText( "Score: " .. score, 450, 30, native.systemFont, 20 )
	
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
if(player.name == "life") then		 
		 Runtime:addEventListener( "collision", onCollision )
		 end
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if event.phase == "will" then
	--	Runtime:removeEventListener( "enterFrame", actionList )
		composer.removeScene( "level1" )
		-- Called when the scene is on screen and is about to move off screen
		--physics.start()
		
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		Runtime:removeEventListener( "collision", onCollision )
		--
		physics.start()
		physics.pause()
		composer.removeScene( "level1" )
		
		
		
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
		restart()
		
		player.alpha=0
	
		enemy.alpha=0
		
		
		door.alpha=0
		door_.alpha=0
		
		leftButton.alpha = 0
	
		rightButton.alpha = 0
	
		swordButton.alpha = 0
	
		jumpButton.alpha = 0
	
		platform_.alpha = 0
		
		platform2.alpha = 0
	
		platform3.alpha = 0
	
		platform4.alpha = 0
		
		platform5.alpha = 0
	
		platform6.alpha = 0
	
		platform7.alpha = 0
		
		platform8.alpha = 0
		
		platform9.alpha = 0
		
		background.alpha = 0
		
		background0.alpha = 0		
		
		background1.alpha = 0
		
		background2.alpha = 0
		
		background3.alpha = 0
		
		background4.alpha = 0
		wall.alpha=0
		wall_.alpha=0
		box_.alpha=0
		_box.alpha=0
		life1:removeSelf()
		life2:removeSelf()
		life3:removeSelf()
		gameOver:removeSelf()
		winner:removeSelf()
		scoreText:removeSelf()
		Runtime:removeEventListener( "enterFrame", actionList )
		
end









-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
