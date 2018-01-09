% This is a video game in which you play as Link and kill zombies and ghosts and a boss.
% The Legend of Ripoff
% Coded by: Gabriel Gebril, on June 16, 2014

setscreen ("graphics:640;360,nobuttonbar,position:center;center,offscreenonly") % This creates a window. This window is graphics compatible and does not flicker (if used properly).

%Start Screen/Menu.%
var TitleScreen : int := Pic.FileNew ("Titlescreen.BMP") % Storing the Titlescreen in a variable.

var ControlScreen : int := Pic.FileNew ("controls.BMP") % Stores the ContorlScreen in a variable

var StartScreenON : boolean := true % This is later used to make sure that the startscreen music doesn't leak over to the main game.

var font1, font2 : int % Fonts.
font1 := Font.New ("Algerian:40") % If you do not have the correct font then you can download it here http://www.fontpalace.com/font-details/Algerian/
font2 := Font.New ("Algerian:30")

var Mousex, Mousey, b : int % Mousex stores the x position of your mouse cursor, Mousey stores the y position of your mouse cursor, b is to determine if the mouse is being clicked down or not.
var bpressed : int := 0 % Stores the button press so that the screen can stay on until the button is pressed again.

procedure ViewControls % This is will be used to display the controls to the user.
    Pic.Draw (ControlScreen, 0, 0, 0) % Displays the ContorlScreen to the user
    Font.Draw ("Attack", 80, 70, font2, white) % Label under the Z key
    Font.Draw ("Movement", 340, 70, font2, white) % Label under the movement keys
    Font.Draw ("Back", 10, 320, font2, white) % Will be able to click on this to go back the the start screen.

    if Mousex > 8 and Mousex < 116 and Mousey > 319 and Mousey < 351 then % This is the hit box for the Back button. This if statement is used to highlight the Back button.
	Font.Draw ("Back", 10, 320, font2, blue) % Turns the Back button blue.
    else
	Font.Draw ("Back", 10, 320, font2, white) % Turns the Back button white again.
    end if

    if Mousex > 8 and Mousex < 116 and Mousey > 319 and Mousey < 351 and b = 1 then % if the mouse is in the Back hitbox and the mouse button is press then
	bpressed := 0 % the b pressed will be 0 which will bring the user back to the startscreen. More info on this can be found above the main loop down below.
    end if
end ViewControls

% All music is from http://zelda25.ocremix.org/
process StartScreenMusic % Simply allows music to play in the background.
    loop
	exit when StartScreenON = false % The music can be stoped after this condition is met.
	Music.PlayFile ("StartScreenM.wav")
    end loop
end StartScreenMusic

var RoomNumber : int := 1 % This determines what map is rendered.
var mapMoveY : int := 0 % This determines where the map is rendered on the y axis.
var mapMoveX : int := 150 % This determines where the map is rendered on the x axis.
var Health : array 0 .. 10 of int % This is what will store the heart images.
var AmountOfHealth : int := 10 % This determines how much health the player has and also how many hearts are rendered on the screen.

for i : 1 .. 10 % This is what will store and scale the hearts for final rendering.

    Health (i) := Pic.FileNew ("Heart.bmp") % Stores the hearts.
    Health (i) := Pic.Scale (Health (i), 14, 14) % Scales the hearts up.

end for

% All Link sprites from http://i105.photobucket.com/albums/m214/secretofmanarules/mclinkcap4fe2.png

var LinkanRight : array 1 .. 33 of int % This array stores all the animations for movement in the right direction.
LinkanRight (1) := Pic.FileNew ("LinkRight1.bmp")
LinkanRight (2) := Pic.FileNew ("LinkRight1.bmp")
LinkanRight (3) := Pic.FileNew ("LinkRight1.bmp")
LinkanRight (4) := Pic.FileNew ("LinkRight2.bmp")
LinkanRight (5) := Pic.FileNew ("LinkRight2.bmp")
LinkanRight (6) := Pic.FileNew ("LinkRight2.bmp")
LinkanRight (7) := Pic.FileNew ("LinkRight3.bmp")
LinkanRight (8) := Pic.FileNew ("LinkRight3.bmp")
LinkanRight (9) := Pic.FileNew ("LinkRight3.bmp")
LinkanRight (10) := Pic.FileNew ("LinkRight4.bmp")
LinkanRight (11) := Pic.FileNew ("LinkRight4.bmp")
LinkanRight (12) := Pic.FileNew ("LinkRight4.bmp")
LinkanRight (13) := Pic.FileNew ("LinkRight5.bmp")
LinkanRight (14) := Pic.FileNew ("LinkRight5.bmp")
LinkanRight (15) := Pic.FileNew ("LinkRight5.bmp")
LinkanRight (16) := Pic.FileNew ("LinkRight6.bmp")
LinkanRight (17) := Pic.FileNew ("LinkRight6.bmp")
LinkanRight (18) := Pic.FileNew ("LinkRight6.bmp")
LinkanRight (19) := Pic.FileNew ("LinkRight7.bmp")
LinkanRight (20) := Pic.FileNew ("LinkRight7.bmp")
LinkanRight (21) := Pic.FileNew ("LinkRight7.bmp")
LinkanRight (22) := Pic.FileNew ("LinkRight8.bmp")
LinkanRight (23) := Pic.FileNew ("LinkRight8.bmp")
LinkanRight (24) := Pic.FileNew ("LinkRight8.bmp")
LinkanRight (25) := Pic.FileNew ("LinkRight9.bmp")
LinkanRight (26) := Pic.FileNew ("LinkRight9.bmp")
LinkanRight (27) := Pic.FileNew ("LinkRight9.bmp")
LinkanRight (28) := Pic.FileNew ("LinkRight10.bmp")
LinkanRight (29) := Pic.FileNew ("LinkRight10.bmp")
LinkanRight (30) := Pic.FileNew ("LinkRight10.bmp")
LinkanRight (31) := Pic.FileNew ("LinkRight11.bmp")
LinkanRight (32) := Pic.FileNew ("LinkRight11.bmp")
LinkanRight (33) := Pic.FileNew ("LinkRight11.bmp")

var LinkanLeft : array 1 .. 33 of int % This array stores all the animations for movement in the left direction.

for i : 1 .. 33
    LinkanLeft (i) := Pic.Mirror (LinkanRight (i))
end for

var LinkanUp : array 1 .. 30 of int % This array stores all the animations for movement in the Up direction.
LinkanUp (1) := Pic.FileNew ("LinkUp1.bmp")
LinkanUp (2) := Pic.FileNew ("LinkUp1.bmp")
LinkanUp (3) := Pic.FileNew ("LinkUp1.bmp")
LinkanUp (4) := Pic.FileNew ("LinkUp2.bmp")
LinkanUp (5) := Pic.FileNew ("LinkUp2.bmp")
LinkanUp (6) := Pic.FileNew ("LinkUp2.bmp")
LinkanUp (7) := Pic.FileNew ("LinkUp3.bmp")
LinkanUp (8) := Pic.FileNew ("LinkUp3.bmp")
LinkanUp (9) := Pic.FileNew ("LinkUp3.bmp")
LinkanUp (10) := Pic.FileNew ("LinkUp4.bmp")
LinkanUp (11) := Pic.FileNew ("LinkUp4.bmp")
LinkanUp (12) := Pic.FileNew ("LinkUp4.bmp")
LinkanUp (13) := Pic.FileNew ("LinkUp5.bmp")
LinkanUp (14) := Pic.FileNew ("LinkUp5.bmp")
LinkanUp (15) := Pic.FileNew ("LinkUp5.bmp")
LinkanUp (16) := Pic.FileNew ("LinkUp6.bmp")
LinkanUp (17) := Pic.FileNew ("LinkUp6.bmp")
LinkanUp (18) := Pic.FileNew ("LinkUp6.bmp")
LinkanUp (19) := Pic.FileNew ("LinkUp7.bmp")
LinkanUp (20) := Pic.FileNew ("LinkUp7.bmp")
LinkanUp (21) := Pic.FileNew ("LinkUp7.bmp")
LinkanUp (22) := Pic.FileNew ("LinkUp8.bmp")
LinkanUp (23) := Pic.FileNew ("LinkUp8.bmp")
LinkanUp (24) := Pic.FileNew ("LinkUp8.bmp")
LinkanUp (25) := Pic.FileNew ("LinkUp9.bmp")
LinkanUp (26) := Pic.FileNew ("LinkUp9.bmp")
LinkanUp (27) := Pic.FileNew ("LinkUp9.bmp")
LinkanUp (28) := Pic.FileNew ("LinkUp10.bmp")
LinkanUp (29) := Pic.FileNew ("LinkUp10.bmp")
LinkanUp (30) := Pic.FileNew ("LinkUp10.bmp")

var LinkanDown : array 1 .. 30 of int % This array stores all the animations for movement in the down direction.
LinkanDown (1) := Pic.FileNew ("LinkDown1.bmp")
LinkanDown (2) := Pic.FileNew ("LinkDown1.bmp")
LinkanDown (3) := Pic.FileNew ("LinkDown1.bmp")
LinkanDown (4) := Pic.FileNew ("LinkDown2.bmp")
LinkanDown (5) := Pic.FileNew ("LinkDown2.bmp")
LinkanDown (6) := Pic.FileNew ("LinkDown2.bmp")
LinkanDown (7) := Pic.FileNew ("LinkDown3.bmp")
LinkanDown (8) := Pic.FileNew ("LinkDown3.bmp")
LinkanDown (9) := Pic.FileNew ("LinkDown3.bmp")
LinkanDown (10) := Pic.FileNew ("LinkDown4.bmp")
LinkanDown (11) := Pic.FileNew ("LinkDown4.bmp")
LinkanDown (12) := Pic.FileNew ("LinkDown4.bmp")
LinkanDown (13) := Pic.FileNew ("LinkDown5.bmp")
LinkanDown (14) := Pic.FileNew ("LinkDown5.bmp")
LinkanDown (15) := Pic.FileNew ("LinkDown5.bmp")
LinkanDown (16) := Pic.FileNew ("LinkDown6.bmp")
LinkanDown (17) := Pic.FileNew ("LinkDown6.bmp")
LinkanDown (18) := Pic.FileNew ("LinkDown6.bmp")
LinkanDown (19) := Pic.FileNew ("LinkDown7.bmp")
LinkanDown (20) := Pic.FileNew ("LinkDown7.bmp")
LinkanDown (21) := Pic.FileNew ("LinkDown7.bmp")
LinkanDown (22) := Pic.FileNew ("LinkDown8.bmp")
LinkanDown (23) := Pic.FileNew ("LinkDown8.bmp")
LinkanDown (24) := Pic.FileNew ("LinkDown8.bmp")
LinkanDown (25) := Pic.FileNew ("LinkDown9.bmp")
LinkanDown (26) := Pic.FileNew ("LinkDown9.bmp")
LinkanDown (27) := Pic.FileNew ("LinkDown9.bmp")
LinkanDown (28) := Pic.FileNew ("LinkDown10.bmp")
LinkanDown (29) := Pic.FileNew ("LinkDown10.bmp")
LinkanDown (30) := Pic.FileNew ("LinkDown10.bmp")

var LinkanAttack : array 1 .. 4 of int % This array stores the attack animation frames.
LinkanAttack (1) := Pic.FileNew ("LinkAttackLeft1.bmp")
LinkanAttack (2) := Pic.FileNew ("LinkAttackRight1.bmp")
LinkanAttack (3) := Pic.FileNew ("LinkAttackUp1.bmp")
LinkanAttack (4) := Pic.FileNew ("LinkAttackDown1.bmp")

var LinkanAttackSword : array 0 .. 4 of int % This array stores the sword animation frames. The reason this is zero indexed is because State1 isn't really attacking. Actually State1 is not attacking.
LinkanAttackSword (0) := Pic.FileNew ("LinkAttackState1.bmp") % I'm doing that so link doesn't just always have a sword floating around him.
LinkanAttackSword (1) := Pic.FileNew ("LinkAttackLeftSword1.bmp")
LinkanAttackSword (2) := Pic.FileNew ("LinkAttackRightSword1.bmp")
LinkanAttackSword (3) := Pic.FileNew ("LinkAttackUpSword1.bmp")
LinkanAttackSword (4) := Pic.FileNew ("LinkAttackDownSword1.bmp")

var map : array 1 .. 6 of int % Stores all the maps
map (1) := Pic.FileNew ("Room1.bmp")
map (2) := Pic.FileNew ("Room2.bmp")
map (3) := Pic.FileNew ("Room3.bmp")
map (4) := Pic.FileNew ("Room4.bmp")
map (5) := Pic.FileNew ("Room5.bmp")
map (6) := Pic.FileNew ("Room6.bmp")

var mapCol : array 1 .. 6 of int % Stores all the whatdotcolor information.
mapCol (1) := Pic.FileNew ("Room1CCCC.bmp")
mapCol (2) := Pic.FileNew ("Room2CCCC.bmp")
mapCol (3) := Pic.FileNew ("Room3CCCC.bmp")
mapCol (4) := Pic.FileNew ("Room4CCCC.bmp")
mapCol (5) := Pic.FileNew ("Room5CCCC.bmp")
mapCol (6) := Pic.FileNew ("Room6CCCC.bmp")


var Link : int := LinkanRight (1) % This is how I will later animate the player.
var LinkAttackState : int := LinkanAttackSword (0) % This is the default attack state.
var x, y : int := 250 % The starting position of the player.
%This is simply a hitbox around the player.%
var LinkHitx1 : int := x + 10
var LinkHitx2 : int := x - 10
var LinkHity1 : int := y
var LinkHity2 : int := y + 19
%These 4 are what give me control over the animation.%
var xr, xl, yu, yd : int := 1
%This is how keys are registered. Char of boolean is an odd type of array for many reasons. For one thing the not= statement does not work with them. ~ has the same effect and actually works
%so that is what I use.%
var key : array char of boolean
%These two are changed depending on where the player is attacking. Before attacking these two do nothing.%
var AttackPosX : int := x
var AttackPosY : int := y
%This is the hitbox for the attack. By default it is set to zero (i.e. the hitbox does not exist). These are changed later making a real hitbox.%
var LinkAttackx1 : int := 0
var LinkAttackx2 : int := 0
var LinkAttacky1 : int := 0
var LinkAttacky2 : int := 0

% All Ghost sprites http://img78.photobucket.com/albums/v250/Talman25/Zelda%20Sprites/BigPoeSheet_v2.bmp
var GhostlyAn : array 1 .. 4 of int % The animation frames for Ghost type monsters.
GhostlyAn (1) := Pic.FileNew ("Ghost1.bmp")
GhostlyAn (2) := Pic.FileNew ("Ghost2.bmp")
GhostlyAn (3) := Pic.FileNew ("Ghost3.bmp")
GhostlyAn (4) := Pic.FileNew ("Ghost4.bmp")

% All Zombie sprites http://s118.photobucket.com/user/kdb424/media/Redead2.png.html
var ZombieAn : array 1 .. 4 of int % The animation frames for Zombie monsters.
ZombieAn (1) := Pic.FileNew ("Zombie1.bmp")
ZombieAn (2) := Pic.FileNew ("Zombie2.bmp")
ZombieAn (3) := Pic.FileNew ("Zombie3.bmp")
ZombieAn (4) := Pic.FileNew ("Zombie4.bmp")

%Enemy 1%
var Enemy1 : boolean := true % Alive or dead
var Enemy1x : int := 250 % Starting x position of the enemy.
var Enemy1y : int := 50 % Starting y position of the enemy.

var Ghost1 : int := GhostlyAn (1) % The animation controler

%Hitbox.%
var EnemyOneHitx1 : int := 250
var EnemyOneHitx2 : int := 274
var EnemyOneHity1 : int := 50
var EnemyOneHity2 : int := 80
%Enemy 1%

%Enemy 2%
var Enemy2 : boolean := true
var Enemy2x : int := 300
var Enemy2y : int := 50

var Ghost2 : int := GhostlyAn (1)

var EnemyTwoHitx1 : int := 250 + 50
var EnemyTwoHitx2 : int := 274 + 50
var EnemyTwoHity1 : int := 50
var EnemyTwoHity2 : int := 80
%Enemy 2%

%Enemy 3%
var Enemy3 : boolean := true
var Enemy3x : int := 350
var Enemy3y : int := 50

var Ghost3 : int := GhostlyAn (1)

var EnemyThreeHitx1 : int := 250 + 100
var EnemyThreeHitx2 : int := 274 + 100
var EnemyThreeHity1 : int := 50
var EnemyThreeHity2 : int := 80
%Enemy 3%

%Enemy 4%
var Enemy4 : boolean := true
var Enemy4x : int := 400
var Enemy4y : int := 50

var Ghost4 : int := GhostlyAn (1)

var EnemyFourHitx1 : int := 250 + 150
var EnemyFourHitx2 : int := 274 + 150
var EnemyFourHity1 : int := 50
var EnemyFourHity2 : int := 80
%Enemy 4%

%Enemy 5%
var Enemy5 : boolean := true
var Enemy5x : int := 250 - 40
var Enemy5y : int := 50

var Zombie1 : int := ZombieAn (1)

var EnemyFiveHitx1 : int := 250 - 40
var EnemyFiveHitx2 : int := 274 - 40
var EnemyFiveHity1 : int := 50
var EnemyFiveHity2 : int := 80
%Enemy 5%

%Enemy 6%
var Enemy6 : boolean := true
var Enemy6x : int := 250 - 40
var Enemy6y : int := 50

var Zombie2 : int := ZombieAn (1)

var EnemySixHitx1 : int := 250 - 40
var EnemySixHitx2 : int := 274 - 40
var EnemySixHity1 : int := 50
var EnemySixHity2 : int := 80
%Enemy 6%

%Enemy 7%
var Enemy7 : boolean := true
var Enemy7x : int := 250 + 40
var Enemy7y : int := 50 + 100

var Zombie3 : int := ZombieAn (1)

var EnemySevenHitx1 : int := 250 + 40
var EnemySevenHitx2 : int := 274 + 40
var EnemySevenHity1 : int := 50 + 100
var EnemySevenHity2 : int := 80 + 100
%Enemy 7%

%Enemy 8%
var Enemy8 : boolean := true
var Enemy8x : int := 250 - 60
var Enemy8y : int := 50

var Zombie4 : int := ZombieAn (1)

var EnemyEightHitx1 : int := 250 - 60
var EnemyEightHitx2 : int := 274 - 60
var EnemyEightHity1 : int := 50
var EnemyEightHity2 : int := 80
%Enemy 8%

%Enemy 9%
var Enemy9 : boolean := true
var Enemy9x : int := 250 + 40
var Enemy9y : int := 50 + 200

var Ghost9 : int := GhostlyAn (1)

var EnemyNineHitx1 : int := 250 + 40
var EnemyNineHitx2 : int := 274 + 40
var EnemyNineHity1 : int := 50 + 200
var EnemyNineHity2 : int := 80 + 200
%Enemy 9%

%Enemy Boss%
var BossHealth : int := 3 % Boss has actual health.
var BossEN : boolean := true % Alive or dead
var Bossx : int := 250 + 40
var Bossy : int := 50 + 200

% All boss sprites http://smg.photobucket.com/user/aabants/media/DarkNut.png.html
var BossAn : array 1 .. 3 of int % The boss has unique animations therefore I am keeping them compartmentalized.
BossAn (1) := Pic.FileNew ("Boss1.bmp")
BossAn (2) := Pic.FileNew ("BossAttack.bmp")
BossAn (3) := Pic.FileNew ("BossAttackSword.bmp")

var Boss : int := BossAn (1)

var BossHitx1 : int := 250 + 60
var BossHitx2 : int := 274 + 70
var BossHity1 : int := 50 + 173
var BossHity2 : int := 80 + 205

%Other than what I highlighted everything for the boss is mostly the same as all the other monsters.
%Enemy Boss%

% All music is from http://zelda25.ocremix.org/
process MainTheme % Process to play the main theme or the Boss music depending. It had to be decalred later on because Boss had to be declared first.

    loop
	exit when RoomNumber = 5 % In room 5 the music will be stopable.
	Music.PlayFile ("MainLevelMusic.wav")
    end loop

    Music.PlayFileStop % Stops the music.

    loop
	exit when BossEN = false % Music can change when the boss dies.
	Music.PlayFile ("BossMusic.wav")
    end loop

    Music.PlayFileStop

end MainTheme


process RestoreRight % After the the player attacks and then let goes of the attack button I will fork this process which will restore the animation state and attack hitbox to default.

    delay (500)
    Link := LinkanRight (1)
    LinkAttackState := LinkanAttackSword (0)

    LinkAttackx1 := 0
    LinkAttackx2 := 0
    LinkAttacky1 := 0
    LinkAttacky2 := 0

end RestoreRight

process RestoreLeft % Refer it RestoreRight.

    delay (500)
    Link := LinkanLeft (1)
    LinkAttackState := LinkanAttackSword (0)

    LinkAttackx1 := 0
    LinkAttackx2 := 0
    LinkAttacky1 := 0
    LinkAttacky2 := 0

end RestoreLeft

process RestoreUp % Refer it RestoreLeft.

    delay (500)
    Link := LinkanUp (1)
    LinkAttackState := LinkanAttackSword (0)

    LinkAttackx1 := 0
    LinkAttackx2 := 0
    LinkAttacky1 := 0
    LinkAttacky2 := 0

end RestoreUp

process RestoreDown % Refer it RestoreUp.

    delay (500)
    Link := LinkanDown (1)
    LinkAttackState := LinkanAttackSword (0)

    LinkAttackx1 := 0
    LinkAttackx2 := 0
    LinkAttacky1 := 0
    LinkAttacky2 := 0

end RestoreDown

proc AiEN1 % This stands for artificial intelligence enemy 1. This type of AI is inherited between all Ghost type enemies.

    % All posisions are from the point of veiw of the enemy.

    if EnemyTwoHitx2 > EnemyOneHitx1 and EnemyTwoHitx1 < EnemyOneHitx2 and EnemyTwoHity2 > EnemyOneHity1 and EnemyTwoHity1 < EnemyOneHity2 and Enemy2 = true then
	% The gist of this if statement is the if the enemies colided in anyway enemy1. More info about collision will be provided in the dedicated damage procedure.

	EnemyOneHitx1 -= 15 % The enemy's hitbox moves 15 pixels.
	EnemyOneHitx2 -= 15

	Enemy1x -= 15 % The enemy moves 15 pixels.

    elsif LinkHitx1 < EnemyOneHitx1 and LinkHity1 > EnemyOneHity2 then % If the player is in the top left corner.

	EnemyOneHitx1 -= 1
	EnemyOneHitx2 -= 1 % The enemy's hitbox moves 1 pixel on both the x and y axis. To the left on the x and up on the y.
	EnemyOneHity1 += 1
	EnemyOneHity2 += 1

	Enemy1x -= 1 % The enemy moves 1 pixel on both the x and y axis.
	Enemy1y += 1

    elsif LinkHitx1 < EnemyOneHitx1 and LinkHity2 < EnemyOneHity2 then % If the player is in the bottom left corner.

	EnemyOneHitx1 -= 1
	EnemyOneHitx2 -= 1 % The enemy's hitbox moves 1 pixel on both the x and y axis. To the left on the x and down on the y.
	EnemyOneHity1 -= 1
	EnemyOneHity2 -= 1

	Enemy1x -= 1 % The enemy moves 1 pixel on both the x and y axis. To the left on the x and down on the y.
	Enemy1y -= 1

    elsif LinkHitx1 not= EnemyOneHitx1 and LinkHitx1 < EnemyOneHitx1 then % If the player is to the left.

	EnemyOneHitx1 -= 1 % The enemy's hitbox moves 1 pixel the x. To the left on the x.
	EnemyOneHitx2 -= 1

	Enemy1x -= 1 % The enemy moves 1 pixel on the x. To the left on the x.

	Ghost1 := GhostlyAn (4) % Changes the animation for the enemy.

    elsif LinkHitx2 > EnemyOneHitx1 and LinkHity1 > EnemyOneHity2 then % If the player is in the top right corner.

	EnemyOneHitx1 += 1
	EnemyOneHitx2 += 1 % The enemy's hitbox moves 1 pixel on both the x and y axis. To the right on the x and up on the y.
	EnemyOneHity1 += 1
	EnemyOneHity2 += 1

	Enemy1x += 1 % The enemy moves 1 pixel on both the x and y axis. To the right on the x and up on the y.
	Enemy1y += 1

    elsif LinkHitx2 > EnemyOneHitx2 and LinkHity2 < EnemyOneHity1 then % If the player is in the bottom right corner.

	EnemyOneHitx1 += 1
	EnemyOneHitx2 += 1 % The enemy's hitbox moves 1 pixel on both the x and y axis. To the right on the x and down on the y.
	EnemyOneHity1 -= 1
	EnemyOneHity2 -= 1

	Enemy1x += 1
	Enemy1y -= 1 % The enemy moves 1 pixel on both the x and y axis. To the right on the x and down on the y.

    elsif LinkHitx2 > EnemyOneHitx2 and LinkHity1 > EnemyOneHity2 then
	% If the player is in the top right corner. (I'm comparing it twice as sometimes if you moved inbetween two places the enemy would spaz out).

	EnemyOneHitx1 += 1
	EnemyOneHitx2 += 1 % The enemy's hitbox moves 1 pixel on both the x and y axis. To the right on the x and up on the y.
	EnemyOneHity1 += 1
	EnemyOneHity2 += 1

	Enemy1x += 1 % The enemy moves 1 pixel on both the x and y axis. To the right on the x and up on the y.
	Enemy1y += 1

    elsif LinkHitx2 not= EnemyOneHitx2 and LinkHitx2 > EnemyOneHitx2 then % If the palyer is to the above of the enemy.

	EnemyOneHitx1 += 1 % The enemy's hitbox moves 1 pixel the x. To the right on the x.
	EnemyOneHitx2 += 1

	Enemy1x += 1 % The enemy moves 1 pixel on the x. To the right on the x.

	Ghost1 := GhostlyAn (2) % Changes the animation of the Enemy.

    elsif LinkHity1 not= EnemyOneHity2 and LinkHity1 < EnemyOneHity2 then  % If the palyer is to the below of the enemy.

	EnemyOneHity1 -= 1 % The enemy's hitbox moves 1 pixel the y. Downward on the y.
	EnemyOneHity2 -= 1

	Enemy1y -= 1 % The enemy moves 1 pixel on the y. Downward on the y.

	Ghost1 := GhostlyAn (1) % Changes the animation of the Enemy.

    elsif LinkHity2 not= EnemyOneHity2 and LinkHity2 > EnemyOneHity2 then
	% If the palyer is to the above of the enemy. Again this is being compared twice because of an odd stutted bug that would sometimes happen.

	EnemyOneHity1 += 1 % The enemy's hitbox moves 1 pixel the y. Upwardward on the y.
	EnemyOneHity2 += 1

	Enemy1y += 1 % The enemy moves 1 pixel on the y. Upward on the y.

	Ghost1 := GhostlyAn (3) % Changes the animation of the Enemy.

    end if

end AiEN1

proc AiEN2 % Ghost type AI. See AiEN1.

    if EnemyOneHitx2 > EnemyTwoHitx1 and EnemyOneHitx1 < EnemyTwoHitx2 and EnemyOneHity2 > EnemyTwoHity1 and EnemyOneHity1 < EnemyTwoHity2 and Enemy1 = true then

	EnemyTwoHitx1 += 15
	EnemyTwoHitx2 += 15

	Enemy2x += 15

    elsif LinkHitx1 < EnemyTwoHitx1 and LinkHity1 > EnemyTwoHity2 then

	EnemyTwoHitx1 -= 1
	EnemyTwoHitx2 -= 1
	EnemyTwoHity1 += 1
	EnemyTwoHity2 += 1

	Enemy2x -= 1
	Enemy2y += 1

    elsif LinkHitx1 < EnemyTwoHitx1 and LinkHity2 < EnemyTwoHity2 then

	EnemyTwoHitx1 -= 1
	EnemyTwoHitx2 -= 1
	EnemyTwoHity1 -= 1
	EnemyTwoHity2 -= 1

	Enemy2x -= 1
	Enemy2y -= 1

    elsif LinkHitx1 not= EnemyTwoHitx1 and LinkHitx1 < EnemyTwoHitx1 then

	EnemyTwoHitx1 -= 1
	EnemyTwoHitx2 -= 1

	Enemy2x -= 1

	Ghost2 := GhostlyAn (4)

    elsif LinkHitx2 > EnemyTwoHitx1 and LinkHity1 > EnemyTwoHity2 then

	EnemyTwoHitx1 += 1
	EnemyTwoHitx2 += 1
	EnemyTwoHity1 += 1
	EnemyTwoHity2 += 1

	Enemy2x += 1
	Enemy2y += 1

    elsif LinkHitx2 > EnemyTwoHitx2 and LinkHity2 < EnemyTwoHity1 then

	EnemyTwoHitx1 += 1
	EnemyTwoHitx2 += 1
	EnemyTwoHity1 -= 1
	EnemyTwoHity2 -= 1

	Enemy2x += 1
	Enemy2y -= 1

    elsif LinkHitx2 > EnemyTwoHitx2 and LinkHity1 > EnemyTwoHity2 then

	EnemyTwoHitx1 += 1
	EnemyTwoHitx2 += 1
	EnemyTwoHity1 += 1
	EnemyTwoHity2 += 1

	Enemy2x += 1
	Enemy2y += 1

    elsif LinkHitx2 not= EnemyTwoHitx2 and LinkHitx2 > EnemyTwoHitx2 then

	EnemyTwoHitx1 += 1
	EnemyTwoHitx2 += 1

	Enemy2x += 1

	Ghost2 := GhostlyAn (2)

    elsif LinkHity1 not= EnemyTwoHity2 and LinkHity1 < EnemyTwoHity2 then

	EnemyTwoHity1 -= 1
	EnemyTwoHity2 -= 1

	Enemy2y -= 1

	Ghost2 := GhostlyAn (1)

    elsif LinkHity2 not= EnemyTwoHity2 and LinkHity2 > EnemyTwoHity2 then

	EnemyTwoHity1 += 1
	EnemyTwoHity2 += 1

	Enemy2y += 1

	Ghost2 := GhostlyAn (3)

    end if

end AiEN2

proc AiEN3 % Ghost type AI. See AiEN2.

    if EnemyOneHitx2 > EnemyThreeHitx1 and EnemyOneHitx1 < EnemyThreeHitx2 and EnemyOneHity2 > EnemyThreeHity1 and EnemyOneHity1 < EnemyThreeHity2 and Enemy1 = true then

	EnemyThreeHitx1 += 15
	EnemyThreeHitx2 += 15

	Enemy3x += 15

    elsif EnemyTwoHitx2 > EnemyThreeHitx1 and EnemyTwoHitx1 < EnemyThreeHitx2 and EnemyTwoHity2 > EnemyThreeHity1 and EnemyTwoHity1 < EnemyThreeHity2 and Enemy1 = true then

	EnemyThreeHitx1 += 15
	EnemyThreeHitx2 += 15

	Enemy3x += 15

    elsif LinkHitx1 < EnemyThreeHitx1 and LinkHity1 > EnemyThreeHity2 then

	EnemyThreeHitx1 -= 1
	EnemyThreeHitx2 -= 1
	EnemyThreeHity1 += 1
	EnemyThreeHity2 += 1

	Enemy3x -= 1
	Enemy3y += 1

    elsif LinkHitx1 < EnemyThreeHitx1 and LinkHity2 < EnemyThreeHity2 then

	EnemyThreeHitx1 -= 1
	EnemyThreeHitx2 -= 1
	EnemyThreeHity1 -= 1
	EnemyThreeHity2 -= 1

	Enemy3x -= 1
	Enemy3y -= 1

    elsif LinkHitx1 not= EnemyThreeHitx1 and LinkHitx1 < EnemyThreeHitx1 then

	EnemyThreeHitx1 -= 1
	EnemyThreeHitx2 -= 1

	Enemy3x -= 1

	Ghost3 := GhostlyAn (4)

    elsif LinkHitx2 > EnemyThreeHitx1 and LinkHity1 > EnemyThreeHity2 then

	EnemyThreeHitx1 += 1
	EnemyThreeHitx2 += 1
	EnemyThreeHity1 += 1
	EnemyThreeHity2 += 1

	Enemy3x += 1
	Enemy3y += 1

    elsif LinkHitx2 > EnemyThreeHitx2 and LinkHity2 < EnemyThreeHity1 then

	EnemyThreeHitx1 += 1
	EnemyThreeHitx2 += 1
	EnemyThreeHity1 -= 1
	EnemyThreeHity2 -= 1

	Enemy3x += 1
	Enemy3y -= 1

    elsif LinkHitx2 > EnemyThreeHitx2 and LinkHity1 > EnemyThreeHity2 then

	EnemyThreeHitx1 += 1
	EnemyThreeHitx2 += 1
	EnemyThreeHity1 += 1
	EnemyThreeHity2 += 1

	Enemy3x += 1
	Enemy3y += 1

    elsif LinkHitx2 not= EnemyThreeHitx2 and LinkHitx2 > EnemyThreeHitx2 then

	EnemyThreeHitx1 += 1
	EnemyThreeHitx2 += 1

	Enemy3x += 1

	Ghost3 := GhostlyAn (2)

    elsif LinkHity1 not= EnemyThreeHity2 and LinkHity1 < EnemyThreeHity2 then

	EnemyThreeHity1 -= 1
	EnemyThreeHity2 -= 1

	Enemy3y -= 1

	Ghost3 := GhostlyAn (1)

    elsif LinkHity2 not= EnemyThreeHity2 and LinkHity2 > EnemyThreeHity2 then

	EnemyThreeHity1 += 1
	EnemyThreeHity2 += 1

	Enemy3y += 1

	Ghost3 := GhostlyAn (3)

    end if

end AiEN3

proc AiEN4 % Ghost type AI. See AiEN3.

    if EnemyOneHitx2 > EnemyFourHitx1 and EnemyOneHitx1 < EnemyFourHitx2 and EnemyOneHity2 > EnemyFourHity1 and EnemyOneHity1 < EnemyFourHity2 and Enemy1 = true then

	EnemyFourHitx1 += 15
	EnemyFourHitx2 += 15

	Enemy4x += 15

    elsif EnemyThreeHitx2 > EnemyFourHitx1 and EnemyThreeHitx1 < EnemyFourHitx2 and EnemyThreeHity2 > EnemyFourHity1 and EnemyThreeHity1 < EnemyFourHity2 and Enemy3 = true then

	EnemyFourHitx1 += 15
	EnemyFourHitx2 += 15

	Enemy4x += 15

    elsif LinkHitx1 < EnemyFourHitx1 and LinkHity1 > EnemyFourHity2 then

	EnemyFourHitx1 -= 1
	EnemyFourHitx2 -= 1
	EnemyFourHity1 += 1
	EnemyFourHity2 += 1

	Enemy4x -= 1
	Enemy4y += 1

    elsif LinkHitx1 < EnemyFourHitx1 and LinkHity2 < EnemyFourHity2 then

	EnemyFourHitx1 -= 1
	EnemyFourHitx2 -= 1
	EnemyFourHity1 -= 1
	EnemyFourHity2 -= 1

	Enemy4x -= 1
	Enemy4y -= 1

    elsif LinkHitx1 not= EnemyFourHitx1 and LinkHitx1 < EnemyFourHitx1 then

	EnemyFourHitx1 -= 1
	EnemyFourHitx2 -= 1

	Enemy4x -= 1

	Ghost4 := GhostlyAn (4)

    elsif LinkHitx2 > EnemyFourHitx1 and LinkHity1 > EnemyFourHity2 then

	EnemyFourHitx1 += 1
	EnemyFourHitx2 += 1
	EnemyFourHity1 += 1
	EnemyFourHity2 += 1

	Enemy4x += 1
	Enemy4y += 1

    elsif LinkHitx2 > EnemyFourHitx2 and LinkHity2 < EnemyFourHity1 then

	EnemyFourHitx1 += 1
	EnemyFourHitx2 += 1
	EnemyFourHity1 -= 1
	EnemyFourHity2 -= 1

	Enemy4x += 1
	Enemy4y -= 1

    elsif LinkHitx2 > EnemyFourHitx2 and LinkHity1 > EnemyFourHity2 then

	EnemyFourHitx1 += 1
	EnemyFourHitx2 += 1
	EnemyFourHity1 += 1
	EnemyFourHity2 += 1

	Enemy4x += 1
	Enemy4y += 1

    elsif LinkHitx2 not= EnemyFourHitx2 and LinkHitx2 > EnemyFourHitx2 then

	EnemyFourHitx1 += 1
	EnemyFourHitx2 += 1

	Enemy4x += 1

	Ghost4 := GhostlyAn (2)

    elsif LinkHity1 not= EnemyFourHity2 and LinkHity1 < EnemyFourHity2 then

	EnemyFourHity1 -= 1
	EnemyFourHity2 -= 1

	Enemy4y -= 1

	Ghost4 := GhostlyAn (1)

    elsif LinkHity2 not= EnemyFourHity2 and LinkHity2 > EnemyFourHity2 then

	EnemyFourHity1 += 1
	EnemyFourHity2 += 1

	Enemy4y += 1

	Ghost4 := GhostlyAn (3)

    end if

end AiEN4

proc AiEN5 % Ghost type AI. See AiEN4.

    if LinkHitx1 < EnemyNineHitx1 and LinkHity1 > EnemyNineHity2 then

	EnemyNineHitx1 -= 1
	EnemyNineHitx2 -= 1
	EnemyNineHity1 += 1
	EnemyNineHity2 += 1

	Enemy9x -= 1
	Enemy9y += 1

    elsif LinkHitx1 < EnemyNineHitx1 and LinkHity2 < EnemyNineHity2 then

	EnemyNineHitx1 -= 1
	EnemyNineHitx2 -= 1
	EnemyNineHity1 -= 1
	EnemyNineHity2 -= 1

	Enemy9x -= 1
	Enemy9y -= 1

    elsif LinkHitx1 not= EnemyNineHitx1 and LinkHitx1 < EnemyNineHitx1 then

	EnemyNineHitx1 -= 1
	EnemyNineHitx2 -= 1

	Enemy9x -= 1

	Ghost9 := GhostlyAn (4)

    elsif LinkHitx2 > EnemyNineHitx1 and LinkHity1 > EnemyNineHity2 then

	EnemyNineHitx1 += 1
	EnemyNineHitx2 += 1
	EnemyNineHity1 += 1
	EnemyNineHity2 += 1

	Enemy9x += 1
	Enemy9y += 1

    elsif LinkHitx2 > EnemyNineHitx2 and LinkHity2 < EnemyNineHity1 then

	EnemyNineHitx1 += 1
	EnemyNineHitx2 += 1
	EnemyNineHity1 -= 1
	EnemyNineHity2 -= 1

	Enemy9x += 1
	Enemy9y -= 1

    elsif LinkHitx2 > EnemyNineHitx2 and LinkHity1 > EnemyNineHity2 then

	EnemyNineHitx1 += 1
	EnemyNineHitx2 += 1
	EnemyNineHity1 += 1
	EnemyNineHity2 += 1

	Enemy9x += 1
	Enemy9y += 1

    elsif LinkHitx2 not= EnemyNineHitx2 and LinkHitx2 > EnemyNineHitx2 then

	EnemyNineHitx1 += 1
	EnemyNineHitx2 += 1

	Enemy9x += 1

	Ghost9 := GhostlyAn (2)

    elsif LinkHity1 not= EnemyNineHity2 and LinkHity1 < EnemyNineHity2 then

	EnemyNineHity1 -= 1
	EnemyNineHity2 -= 1

	Enemy9y -= 1

	Ghost9 := GhostlyAn (1)

    elsif LinkHity2 not= EnemyNineHity2 and LinkHity2 > EnemyNineHity2 then

	EnemyNineHity1 += 1
	EnemyNineHity2 += 1

	Enemy9y += 1

	Ghost9 := GhostlyAn (3)

    end if

end AiEN5


proc AiZEN1 % This stands for artificial intelligence zombie enemy 1. This type of AI is inherited between all Zombie type enemies.

    % All posisions are from the point of veiw of the enemy.

    % The Ghost type ai took the most efficient way towards you. Zombies will only go up, down, left or right and cannot of diagonally.

    if LinkHitx1 not= EnemyFiveHitx1 and LinkHitx1 < EnemyFiveHitx1 then % If the palyer is to the above of the enemy.

	EnemyFiveHitx1 -= 1 % The enemy's hitbox moves 1 pixel the x. Left on the x.
	EnemyFiveHitx2 -= 1

	Enemy5x -= 1 % The enemy moves 1 pixel on the x. Left on the x.

	Zombie1 := ZombieAn (1) % Changes the animation of the Enemy.

    elsif LinkHitx2 not= EnemyFiveHitx2 and LinkHitx2 > EnemyFiveHitx2 then

	EnemyFiveHitx1 += 1 % The enemy's hitbox moves 1 pixel the x. right on the x.
	EnemyFiveHitx2 += 1

	Enemy5x += 1 % The enemy moves 1 pixel on the x. right on the x.

	Zombie1 := ZombieAn (2) % Changes the animation of the Enemy.

    elsif LinkHity1 not= EnemyFiveHity2 and LinkHity1 < EnemyFiveHity2 then

	EnemyFiveHity1 -= 1 % The enemy's hitbox moves 1 pixel the y. Downward on the y.
	EnemyFiveHity2 -= 1

	Enemy5y -= 1 % The enemy moves 1 pixel on the y. Downward on the y.

	Zombie1 := ZombieAn (4) % Changes the animation of the Enemy.

    elsif LinkHity2 not= EnemyFiveHity2 and LinkHity2 > EnemyFiveHity2 then

	EnemyFiveHity1 += 1 % The enemy's hitbox moves 1 pixel the y. Upward on the y.
	EnemyFiveHity2 += 1

	Enemy5y += 1 % The enemy moves 1 pixel on the y. Upward on the y.

	Zombie1 := ZombieAn (3) % Changes the animation of the Enemy.

    end if

end AiZEN1

proc AiZEN2 % Zombie type AI. See AiZEN1.

    if LinkHitx1 not= EnemySixHitx1 and LinkHitx1 < EnemySixHitx1 then

	EnemySixHitx1 -= 1
	EnemySixHitx2 -= 1

	Enemy6x -= 1

	Zombie2 := ZombieAn (1)

    elsif LinkHitx2 not= EnemySixHitx2 and LinkHitx2 > EnemySixHitx2 then

	EnemySixHitx1 += 1
	EnemySixHitx2 += 1

	Enemy6x += 1

	Zombie2 := ZombieAn (2)

    elsif LinkHity1 not= EnemySixHity2 and LinkHity1 < EnemySixHity2 then

	EnemySixHity1 -= 1
	EnemySixHity2 -= 1

	Enemy6y -= 1

	Zombie2 := ZombieAn (4)

    elsif LinkHity2 not= EnemySixHity2 and LinkHity2 > EnemySixHity2 then

	EnemySixHity1 += 1
	EnemySixHity2 += 1

	Enemy6y += 1

	Zombie2 := ZombieAn (3)

    end if

end AiZEN2

proc AiZEN3 % Zombie type AI. See AiZEN2.

    if LinkHitx1 not= EnemySevenHitx1 and LinkHitx1 < EnemySevenHitx1 then

	EnemySevenHitx1 -= 1
	EnemySevenHitx2 -= 1

	Enemy7x -= 1

	Zombie3 := ZombieAn (1)

    elsif LinkHitx2 not= EnemySevenHitx2 and LinkHitx2 > EnemySevenHitx2 then

	EnemySevenHitx1 += 1
	EnemySevenHitx2 += 1

	Enemy7x += 1

	Zombie3 := ZombieAn (2)

    elsif LinkHity1 not= EnemySevenHity2 and LinkHity1 < EnemySevenHity2 then

	EnemySevenHity1 -= 1
	EnemySevenHity2 -= 1

	Enemy7y -= 1

	Zombie3 := ZombieAn (4)

    elsif LinkHity2 not= EnemySevenHity2 and LinkHity2 > EnemySevenHity2 then

	EnemySevenHity1 += 1
	EnemySevenHity2 += 1

	Enemy7y += 1

	Zombie3 := ZombieAn (3)

    end if

end AiZEN3

proc AiZEN4 % Zombie type AI. See AiZEN4.

    if LinkHitx1 not= EnemyEightHitx1 and LinkHitx1 < EnemyEightHitx1 then

	EnemyEightHitx1 -= 1
	EnemyEightHitx2 -= 1

	Enemy8x -= 1

	Zombie4 := ZombieAn (1)

    elsif LinkHitx2 not= EnemyEightHitx2 and LinkHitx2 > EnemyEightHitx2 then

	EnemyEightHitx1 += 1
	EnemyEightHitx2 += 1

	Enemy8x += 1

	Zombie4 := ZombieAn (2)

    elsif LinkHity1 not= EnemyEightHity2 and LinkHity1 < EnemyEightHity2 then

	EnemyEightHity1 -= 1
	EnemyEightHity2 -= 1

	Enemy8y -= 1

	Zombie4 := ZombieAn (4)

    elsif LinkHity2 not= EnemyEightHity2 and LinkHity2 > EnemyEightHity2 then

	EnemyEightHity1 += 1
	EnemyEightHity2 += 1

	Enemy8y += 1

	Zombie4 := ZombieAn (3)

    end if

end AiZEN4

proc AiBoss

    if LinkHitx1 not= BossHitx1 and LinkHitx1 < BossHitx1 then % if the player is further left than the boss.

	BossHitx1 -= 6 % The boss' hitbox moves left at the same speed of the player.
	BossHitx2 -= 6

	Bossx -= 6 % The boss moves left at the same speed of the player.

	Boss := BossAn (1) % Default stance of the boss

    elsif LinkHitx2 not= BossHitx2 and LinkHitx2 > BossHitx2 then % if the palyer is further right than the boss.

	BossHitx1 += 6 % The boss' hitbox moves right at the same speed of the player.
	BossHitx2 += 6

	Bossx += 6 % The boss moves right at the same speed of the player.

	Boss := BossAn (1) % Default stance of the boss

    elsif LinkHity2 >= 180 and LinkHity1 >= EnemyEightHity2 then % Makes the boss attack if you are within a certain vicinity.

	Boss := BossAn (2)

    elsif LinkHity2 <= 180 and LinkHity1 >= EnemyEightHity2 then % Makes the boss not attack if you are within a certain vicinity.

	Boss := BossAn (1)

    end if



end AiBoss

proc KnockBack % When an enemy hits a player this determines which way the player is flung.

    if (Link = LinkanRight (1) or Link = LinkanRight (2) or Link = LinkanRight (3) or Link = LinkanRight (4) or Link = LinkanRight (5)
	    or Link = LinkanRight (6) or Link = LinkanRight (7) or Link = LinkanRight (8) or Link = LinkanRight (9) or Link = LinkanRight (10)
	    or Link = LinkanRight (11) or Link = LinkanRight (12) or Link = LinkanRight (13) or Link = LinkanRight (14) or Link = LinkanRight (15)
	    or Link = LinkanRight (16) or Link = LinkanRight (17) or Link = LinkanRight (18) or Link = LinkanRight (19) or Link = LinkanRight (20)
	    or Link = LinkanRight (21) or Link = LinkanRight (22) or Link = LinkanRight (23) or Link = LinkanRight (24) or Link = LinkanRight (25)
	    or Link = LinkanRight (26) or Link = LinkanRight (27) or Link = LinkanRight (28) or Link = LinkanRight (29) or Link = LinkanRight (30)
	    or Link = LinkanRight (31) or Link = LinkanRight (32) or Link = LinkanRight (33)) then % If the player is facing right.

	LinkHitx1 -= 25 % The hitbox moves 25 pixels to the left.
	LinkHitx2 -= 25

	x -= 25 % The player moves 25 pixels to the left.
	AttackPosX -= 25 % The position of the attack sword moves 25 pixels to the left.

    elsif (Link = LinkanLeft (1) or Link = LinkanLeft (2) or Link = LinkanLeft (3) or Link = LinkanLeft (4) or Link = LinkanLeft (5)
	    or Link = LinkanLeft (6) or Link = LinkanLeft (7) or Link = LinkanLeft (8) or Link = LinkanLeft (9) or Link = LinkanLeft (10)
	    or Link = LinkanLeft (11) or Link = LinkanLeft (12) or Link = LinkanLeft (13) or Link = LinkanLeft (14) or Link = LinkanLeft (15)
	    or Link = LinkanLeft (16) or Link = LinkanLeft (17) or Link = LinkanLeft (18) or Link = LinkanLeft (19) or Link = LinkanLeft (20)
	    or Link = LinkanLeft (21) or Link = LinkanLeft (22) or Link = LinkanLeft (23) or Link = LinkanLeft (24) or Link = LinkanLeft (25)
	    or Link = LinkanLeft (26) or Link = LinkanLeft (27) or Link = LinkanLeft (28) or Link = LinkanLeft (29) or Link = LinkanLeft (30)
	    or Link = LinkanLeft (31) or Link = LinkanLeft (32) or Link = LinkanLeft (33)) then % If the player is facing left.

	LinkHitx1 += 25 % The hitbox moves 25 pixels to the right.
	LinkHitx2 += 25

	x += 25 % The player moves 25 pixels to the right.
	AttackPosX += 25 % The position of the attack sword moves 25 pixels to the right.

    elsif (Link = LinkanUp (1) or Link = LinkanUp (2) or Link = LinkanUp (3) or Link = LinkanUp (4) or Link = LinkanUp (5)
	    or Link = LinkanUp (6) or Link = LinkanUp (7) or Link = LinkanUp (8) or Link = LinkanUp (9) or Link = LinkanUp (10)
	    or Link = LinkanUp (11) or Link = LinkanUp (12) or Link = LinkanUp (13) or Link = LinkanUp (14) or Link = LinkanUp (15)
	    or Link = LinkanUp (16) or Link = LinkanUp (17) or Link = LinkanUp (18) or Link = LinkanUp (19) or Link = LinkanUp (20)
	    or Link = LinkanUp (21) or Link = LinkanUp (22) or Link = LinkanUp (23) or Link = LinkanUp (24) or Link = LinkanUp (25)
	    or Link = LinkanUp (26) or Link = LinkanUp (27) or Link = LinkanUp (28) or Link = LinkanUp (29) or Link = LinkanUp (30)) then % If the player is facing up.

	LinkHity1 -= 25 % The hitbox moves 25 pixels downward.
	LinkHity2 -= 25

	y -= 25 % The player moves 25 pixels downward.
	AttackPosY -= 25 % The position of the attack sword moves 25 pixels downward.

    elsif (Link = LinkanDown (1) or Link = LinkanDown (2) or Link = LinkanDown (3) or Link = LinkanDown (4) or Link = LinkanDown (5)
	    or Link = LinkanDown (6) or Link = LinkanDown (7) or Link = LinkanDown (8) or Link = LinkanDown (9) or Link = LinkanDown (10)
	    or Link = LinkanDown (11) or Link = LinkanDown (12) or Link = LinkanDown (13) or Link = LinkanDown (14) or Link = LinkanDown (15)
	    or Link = LinkanDown (16) or Link = LinkanDown (17) or Link = LinkanDown (18) or Link = LinkanDown (19) or Link = LinkanDown (20)
	    or Link = LinkanDown (21) or Link = LinkanDown (22) or Link = LinkanDown (23) or Link = LinkanDown (24) or Link = LinkanDown (25)
	    or Link = LinkanDown (26) or Link = LinkanDown (27) or Link = LinkanDown (28) or Link = LinkanDown (29) or Link = LinkanDown (30))
	    then % If the player is facing down.

	LinkHity1 += 25 % The hitbox moves 25 pixels upward.
	LinkHity2 += 25

	y += 25 % The player moves 25 pixels upward.
	AttackPosY += 25 % The position of the attack sword moves 25 pixels upward.

    end if

end KnockBack

proc Damage

    if RoomNumber = 1 then % Makes sure the enemy's only collide with you in the room they are actually in.
	%Damage towards the player from Enemy 1%
	if (LinkHitx1 >= EnemyOneHitx1 and LinkHitx2 <= EnemyOneHitx2) and (LinkHity2 >= EnemyOneHity1 and LinkHity1 <= EnemyOneHity2) and Enemy1 = true and mapMoveY = 0 then
	    % This is a hitbox. This if statement is in the most basic sense drawing a box using 2 sets or coordinates and saying "If any point on between those have the same value they have collided."
	    %Enemy1 = ture is there to make sure that the player interacts with only living enemies.

	    delay (40) % This delay is in place so the enemy can't just drain the players health in one milisecond before the knockback can kick in.
	    AmountOfHealth -= 1 % The amount of health is decreased by one everytime an enemy hits the player.
	    KnockBack % See the knockback Procedure for more infromation.

	end if

	%Damage towards Enemy 1%
	if (LinkAttackx1 >= EnemyOneHitx1 and LinkAttackx2 <= EnemyOneHitx2) and (LinkAttacky2 >= EnemyOneHity1 and LinkAttacky1 <= EnemyOneHity2) then 
	    % Same concept as above except reversed and using the hitbox for links sword.

	    delay (40)
	    Enemy1 := false % This makes the enemy dead.

	end if
	% All code below is the exact same thing as what is above this comment, the only differance is that it is with other enemies.

	%Damage towards the player from Enemy 2%
	if (LinkHitx1 >= EnemyTwoHitx1 and LinkHitx2 <= EnemyTwoHitx2) and (LinkHity2 >= EnemyTwoHity1 and LinkHity1 <= EnemyTwoHity2) and Enemy2 = true and mapMoveY = 0 then

	    delay (40)
	    AmountOfHealth -= 1
	    KnockBack

	end if

	%Damage towards Enemy2%
	if (LinkAttackx1 >= EnemyTwoHitx1 and LinkAttackx2 <= EnemyTwoHitx2) and (LinkAttacky2 >= EnemyTwoHity1 and LinkAttacky1 <= EnemyTwoHity2) then

	    delay (40)
	    Enemy2 := false

	end if

	%Damage towards the player from Enemy 3%
	if (LinkHitx1 >= EnemyThreeHitx1 and LinkHitx2 <= EnemyThreeHitx2) and (LinkHity2 >= EnemyThreeHity1 and LinkHity1 <= EnemyThreeHity2) and Enemy3 = true and mapMoveY = 0 then

	    delay (40)
	    AmountOfHealth -= 1
	    KnockBack

	end if

	%Damage towards Enemy3%
	if (LinkAttackx1 >= EnemyThreeHitx1 and LinkAttackx2 <= EnemyThreeHitx2) and (LinkAttacky2 >= EnemyThreeHity1 and LinkAttacky1 <= EnemyThreeHity2) then

	    delay (40)
	    Enemy3 := false

	end if

	%Damage towards the player from Enemy 4%
	if (LinkHitx1 >= EnemyFourHitx1 and LinkHitx2 <= EnemyFourHitx2) and (LinkHity2 >= EnemyFourHity1 and LinkHity1 <= EnemyFourHity2) and Enemy4 = true and mapMoveY = 0 then

	    delay (40)
	    AmountOfHealth -= 1
	    KnockBack

	end if

	%Damage towards Enemy4%
	if (LinkAttackx1 >= EnemyFourHitx1 and LinkAttackx2 <= EnemyFourHitx2) and (LinkAttacky2 >= EnemyFourHity1 and LinkAttacky1 <= EnemyFourHity2) then

	    delay (40)
	    Enemy4 := false

	end if

    end if

    if RoomNumber = 3 then

	%Damage towards the player from Enemy 5%
	if (LinkHitx1 >= EnemyFiveHitx1 and LinkHitx2 <= EnemyFiveHitx2) and (LinkHity2 >= EnemyFiveHity1 and LinkHity1 <= EnemyFiveHity2) and Enemy5 = true and mapMoveY = 0 then

	    delay (40)
	    AmountOfHealth -= 1
	    KnockBack

	end if

	%Damage towards Enemy5%
	if (LinkAttackx1 >= EnemyFiveHitx1 and LinkAttackx2 <= EnemyFiveHitx2) and (LinkAttacky2 >= EnemyFiveHity1 and LinkAttacky1 <= EnemyFiveHity2) then

	    delay (40)
	    Enemy5 := false

	end if

    end if

    if RoomNumber = 4 then

	%Damage towards the player from Enemy 6%
	if (LinkHitx1 >= EnemySixHitx1 and LinkHitx2 <= EnemySixHitx2) and (LinkHity2 >= EnemySixHity1 and LinkHity1 <= EnemySixHity2) and Enemy6 = true and mapMoveY = 0 then

	    delay (40)
	    AmountOfHealth -= 1
	    KnockBack

	end if

	%Damage towards Enemy6%
	if (LinkAttackx1 >= EnemySixHitx1 and LinkAttackx2 <= EnemySixHitx2) and (LinkAttacky2 >= EnemySixHity1 and LinkAttacky1 <= EnemySixHity2) then

	    delay (40)
	    Enemy6 := false

	end if

	%Damage towards the player from Enemy 7%
	if (LinkHitx1 >= EnemySevenHitx1 and LinkHitx2 <= EnemySevenHitx2) and (LinkHity2 >= EnemySevenHity1 and LinkHity1 <= EnemySevenHity2) and Enemy7 = true and mapMoveY = 0 then

	    delay (40)
	    AmountOfHealth -= 1
	    KnockBack

	end if

	%Damage towards Enemy7%
	if (LinkAttackx1 >= EnemySevenHitx1 and LinkAttackx2 <= EnemySevenHitx2) and (LinkAttacky2 >= EnemySevenHity1 and LinkAttacky1 <= EnemySevenHity2) then

	    delay (40)
	    Enemy7 := false

	end if
    end if

    if RoomNumber = 6 then

	%Damage towards the player from Enemy 8%
	if (LinkHitx1 >= EnemyEightHitx1 and LinkHitx2 <= EnemyEightHitx2) and (LinkHity2 >= EnemyEightHity1 and LinkHity1 <= EnemyEightHity2) and Enemy8 = true and mapMoveY = 0 then

	    delay (40)
	    AmountOfHealth -= 1
	    KnockBack

	end if

	%Damage towards Enemy8%
	if (LinkAttackx1 >= EnemyEightHitx1 and LinkAttackx2 <= EnemyEightHitx2) and (LinkAttacky2 >= EnemyEightHity1 and LinkAttacky1 <= EnemyEightHity2) then

	    delay (40)
	    Enemy8 := false

	end if

	%Damage towards the player from Enemy 9%
	if (LinkHitx1 >= EnemyNineHitx1 and LinkHitx2 <= EnemyNineHitx2) and (LinkHity2 >= EnemyNineHity1 and LinkHity1 <= EnemyNineHity2) and Enemy9 = true and mapMoveY = 0 then

	    delay (40)
	    AmountOfHealth -= 1
	    delay (50)
	    KnockBack

	end if

	%Damage towards Enemy9%
	if (LinkAttackx1 >= EnemyNineHitx1 and LinkAttackx2 <= EnemyNineHitx2) and (LinkAttacky2 >= EnemyNineHity1 and LinkAttacky1 <= EnemyNineHity2) then

	    delay (40)
	    Enemy9 := false

	end if

    end if


    if RoomNumber = 5 then

	%Damage towards the Boss%
	if LinkAttackx1 >= BossHitx1 and LinkAttackx2 <= BossHitx2 and LinkAttacky2 >= BossHity1 - 25 and LinkAttacky1 <= BossHity2 then

	    delay (40)
	    BossHealth -= 1

	    % Knock back for this is done like this because the knockback procedure is a bit to general.
	    % This is boss specific. If link hits the boss he is knocked downward 25 pixels. This includes his and his swords hit boxes.
	    LinkHity1 -= 25
	    LinkHity2 -= 25

	    y -= 25
	    AttackPosY -= 25

	    LinkAttacky1 -= 25
	    LinkAttacky2 -= 25

	    if BossHealth = 0 then
		BossEN := false % Boss is now dead.
	    end if

	end if

	%Damage towards the player from the Boss%

	if LinkHitx1 >= BossHitx1 and LinkHitx2 <= BossHitx2 and LinkHity2 >= BossHity1 - 25 and LinkHity1 <= BossHity2 and BossEN = true and mapMoveY = 0 then

	    delay (40)
	    AmountOfHealth -= 1
	    delay (50)
	    KnockBack
	end if

    end if


end Damage

proc RoomSwitching

    %Room 1%
    if key (KEY_LEFT_ARROW) and x > 15 and whatdotcolor (x - 10, y) = 9 then % if the player touches the color blue
	x += 250
	AttackPosX += 250
	LinkHitx1 += 250 % These numbers are fine tuned and set by me.
	LinkHitx2 += 250
	xl += 1 % Animation still changes
	Link := LinkanLeft (xl) % Changes the animation frame.
	if xl >= 33 then
	    xl := 0
	end if
	cls
	RoomNumber := 1 % Changes what room is rendered
	mapMoveY := -390 % Changes where the room is rendered

	% All other code in this procedure is exactly like this except with differnt colors that lead to differant rooms.

	%Room 2%
    elsif key (KEY_LEFT_ARROW) and whatdotcolor (x - 10, y) = 12 then
	x -= 250
	AttackPosX -= 250
	LinkHitx1 -= 250
	LinkHitx2 -= 250
	xl += 1
	Link := LinkanLeft (xl)
	if xr >= 33 then
	    xr := 0
	end if
	cls
	RoomNumber := 2
	mapMoveY := -390

	%Room 3%
    elsif key (KEY_LEFT_ARROW) and whatdotcolor (x - 10, y) = 41 then
	x += 250
	AttackPosX += 250
	LinkHitx1 += 250
	LinkHitx2 += 250
	xl += 1
	Link := LinkanLeft (xl)
	if xr >= 33 then
	    xr := 0
	end if
	cls
	RoomNumber := 3
	mapMoveY := 0

	%Room 5%
    elsif key (KEY_LEFT_ARROW) and whatdotcolor (x - 10, y) = 13 then
	x += 250
	AttackPosX += 250
	LinkHitx1 += 250
	LinkHitx2 += 250
	xl += 1
	Link := LinkanLeft (xl)
	if xr >= 33 then
	    xr := 0
	end if
	cls
	RoomNumber := 5
	mapMoveY := 0
	Music.PlayFileStop
    end if

    %Room 1%
    if key (KEY_RIGHT_ARROW) and whatdotcolor (x + 15, y) = 9 then
	x += 6
	AttackPosX += 6
	LinkHitx1 += 6
	LinkHitx2 += 6
	xr += 1
	Link := LinkanRight (xr)
	if xr >= 33 then
	    xr := 0
	end if
	cls
	RoomNumber := 1
	mapMoveY := -390

	%Room 2%
    elsif key (KEY_RIGHT_ARROW) and whatdotcolor (x + 20, y) = 12 then
	x -= 250
	AttackPosX -= 250
	LinkHitx1 -= 250
	LinkHitx2 -= 250
	xr += 1
	Link := LinkanRight (xr)
	if xr >= 33 then
	    xr := 0
	end if
	cls
	RoomNumber := 2
	mapMoveY := -390

	%Room 4%
    elsif key (KEY_RIGHT_ARROW) and x < maxx - 10 and whatdotcolor (x + 15, y) = 2 then
	x -= 250
	AttackPosX -= 250
	LinkHitx1 -= 250
	LinkHitx2 -= 250
	xr += 1
	Link := LinkanRight (xr)
	if xr >= 33 then
	    xr := 0
	end if
	cls
	RoomNumber := 4
	mapMoveY := 0

	%Room 6%
    elsif key (KEY_RIGHT_ARROW) and x < maxx - 10 and whatdotcolor (x + 15, y) = white then
	x -= 250
	AttackPosX -= 250
	LinkHitx1 -= 250
	LinkHitx2 -= 250
	xr += 1
	Link := LinkanRight (xr)
	if xr >= 33 then
	    xr := 0
	end if
	cls
	RoomNumber := 6
	mapMoveY := 0
    end if

    %Room 1%
    if key (KEY_UP_ARROW) and     /*y < maxy - 30 and*/ whatdotcolor (x, y + 8) = 9 then
	y += 6
	AttackPosY += 6
	LinkHity1 += 6
	LinkHity2 += 6
	yu += 1
	Link := LinkanUp (yu)
	if yu >= 30 then
	    yu := 0
	end if

	%Room 2%
    elsif key (KEY_UP_ARROW) and whatdotcolor (x, y + 8) = 12 then
	y -= 250
	AttackPosY -= 250
	LinkHity1 -= 250
	LinkHity2 -= 250
	x -= 80
	AttackPosX -= 80
	LinkHitx1 -= 80
	LinkHitx2 -= 80
	yu += 1
	Link := LinkanUp (yu)
	if yu >= 33 then
	    yu := 0
	end if
	cls
	RoomNumber := 2
	mapMoveY := 0

	%Room 3%
    elsif key (KEY_UP_ARROW) and whatdotcolor (x, y + 8) = 41 then
	y -= 60
	AttackPosY -= 60
	LinkHity1 -= 60
	LinkHity2 -= 60
	x -= 20
	AttackPosX -= 20
	LinkHitx1 -= 20
	LinkHitx2 -= 20
	yu += 1
	Link := LinkanUp (yu)
	if yu >= 33 then
	    yu := 0
	end if
	cls
	RoomNumber := 3
	mapMoveY := 0

	%Room 4%
    elsif key (KEY_UP_ARROW) and whatdotcolor (x, y + 15) = 2 then
	y -= 60
	AttackPosY -= 60
	LinkHity1 -= 60
	LinkHity2 -= 60
	x += 15
	AttackPosX += 15
	LinkHitx1 += 15
	LinkHitx2 += 15
	yu += 1
	Link := LinkanUp (yu)
	if yu >= 33 then
	    yu := 0
	end if
	cls
	RoomNumber := 4
	mapMoveY := 0
    end if

    %Room 1%
    if key (KEY_DOWN_ARROW)     /*and y > 3*/ and whatdotcolor (x, y - 8) = 9 then
	y += 60
	AttackPosY += 60
	LinkHity1 += 60
	LinkHity2 += 60
	x += 20
	AttackPosX += 20
	LinkHitx1 += 20
	LinkHitx2 += 20
	yd += 1
	Link := LinkanDown (yd)
	if yd >= 30 then
	    yd := 0
	end if
	cls
	RoomNumber := 1
	mapMoveY := -390

	%Room 2%
    elsif key (KEY_DOWN_ARROW) and whatdotcolor (x, y - 8) = 12 then
	y += 60
	AttackPosY += 60
	LinkHity1 += 60
	LinkHity2 += 60
	x -= 15
	AttackPosX -= 15
	LinkHitx1 -= 15
	LinkHitx2 -= 15
	yd += 1
	Link := LinkanDown (yd)
	if yd >= 30 then
	    yd := 0
	end if
	cls
	RoomNumber := 2
	mapMoveY := -390

	%Room 6%
    elsif key (KEY_DOWN_ARROW) and whatdotcolor (x, y - 8) = white then
	y += 250
	AttackPosY += 250
	LinkHity1 += 250
	LinkHity2 += 250
	x += 80
	AttackPosX += 80
	LinkHitx1 += 80
	LinkHitx2 += 80
	yd += 1
	Link := LinkanDown (yd)
	if yd >= 30 then
	    yd := 0
	end if
	cls
	RoomNumber := 6
	mapMoveY := 0
    end if

end RoomSwitching

proc ReDraw

    cls
    if RoomNumber = 1 and mapMoveY = 0 and Enemy1 = true then 
	% All of these if statements are here to make sure the AI is only active if the enemy is alive and the player is in the same room as the enemy.
	AiEN1
    end if

    if RoomNumber = 1 and mapMoveY = 0 and Enemy2 = true then
	AiEN2
    end if

    if RoomNumber = 1 and mapMoveY = 0 and Enemy3 = true then
	AiEN3
    end if

    if RoomNumber = 1 and mapMoveY = 0 and Enemy4 = true then
	AiEN4
    end if

    if RoomNumber = 3 and Enemy5 = true then
	AiZEN1
    end if

    if RoomNumber = 4 and Enemy6 = true then
	AiZEN2
    end if

    if RoomNumber = 4 and Enemy7 = true then
	AiZEN3
    end if

    if RoomNumber = 6 and Enemy8 = true then
	AiZEN4
    end if

    if RoomNumber = 6 and Enemy9 = true then
	AiEN5
    end if

    if RoomNumber = 5 and BossEN = true then
	AiBoss
    end if

    Damage % Call the damage procedure to detect whether or not the player got hit or hit something this frame.

    if y + 8 > 360 - 20 then % if the player hits the absolute top of the screen.

	mapMoveY := -390 % The screen renders a bit of screen to show the doors.
	y := 3 % Teleports the player to y 3.
	AttackPosY := 3 % The sword comes with the player.
	LinkHity1 -= 335 % The hitbox fallows along also.
	LinkHity2 -= 335
    end if

    Pic.Draw (mapCol (RoomNumber), mapMoveX, mapMoveY, picCopy) % Renders the whatdotcolor information

    if key ('z') and (Link = LinkanLeft (1) or Link = LinkanLeft (2) or Link = LinkanLeft (3) or Link = LinkanLeft (4) or Link = LinkanLeft (5)
	    or Link = LinkanLeft (6) or Link = LinkanLeft (7) or Link = LinkanLeft (8) or Link = LinkanLeft (9) or Link = LinkanLeft (10)
	    or Link = LinkanLeft (11) or Link = LinkanLeft (12) or Link = LinkanLeft (13) or Link = LinkanLeft (14) or Link = LinkanLeft (15)
	    or Link = LinkanLeft (16) or Link = LinkanLeft (17) or Link = LinkanLeft (18) or Link = LinkanLeft (19) or Link = LinkanLeft (20)
	    or Link = LinkanLeft (21) or Link = LinkanLeft (22) or Link = LinkanLeft (23) or Link = LinkanLeft (24) or Link = LinkanLeft (25)
	    or Link = LinkanLeft (26) or Link = LinkanLeft (27) or Link = LinkanLeft (28) or Link = LinkanLeft (29) or Link = LinkanLeft (30)
	    or Link = LinkanLeft (31) or Link = LinkanLeft (32) or Link = LinkanLeft (33)) then % This is huge but it is just saying: if the player presses 'z' and is facing left.

	Link := LinkanAttack (1) % Changes the player animation
	LinkAttackState := LinkanAttackSword (1) % Changes the attack state.

	LinkAttackx1 := LinkHitx1 - 20 % This hit box takes on the same size of links hitbox but is 20 pixels infront of him. The properties are different.
	LinkAttackx2 := LinkHitx2 - 20
	LinkAttacky1 := LinkHity1
	LinkAttacky2 := LinkHity2

	fork RestoreLeft % This fork restores the player to the default left animation after half a second. It also takes away the hitbox for the sword until the player hits 'z' again.

    elsif key (KEY_LEFT_ARROW) and x > 15 and ~key ('z') and whatdotcolor (x - 10, y) = yellow then % If the player hits the left arrow and doesn't have z pressed then
	% All of links properties are shifted to the left 6 pixels
	x -= 6
	AttackPosX -= 6
	LinkHitx1 -= 6
	LinkHitx2 -= 6
	xl += 1 % Contorls the animation
	Link := LinkanLeft (xl) % Changes the animation
	if xl >= 33 then % Resets the animatio
	    xl := 0
	end if

	% Forces the attack state to 0 and takes away the swords hitbox.
	LinkAttackState := LinkanAttackSword (0)

	LinkAttackx1 := 0
	LinkAttackx2 := 0
	LinkAttacky1 := 0
	LinkAttacky2 := 0

    end if

    % All code up until the %Movement ended% comment takes the same format as above but with different animations and directions.

    if key ('z') and (Link = LinkanRight (1) or Link = LinkanRight (2) or Link = LinkanRight (3) or Link = LinkanRight (4) or Link = LinkanRight (5)
	    or Link = LinkanRight (6) or Link = LinkanRight (7) or Link = LinkanRight (8) or Link = LinkanRight (9) or Link = LinkanRight (10)
	    or Link = LinkanRight (11) or Link = LinkanRight (12) or Link = LinkanRight (13) or Link = LinkanRight (14) or Link = LinkanRight (15)
	    or Link = LinkanRight (16) or Link = LinkanRight (17) or Link = LinkanRight (18) or Link = LinkanRight (19) or Link = LinkanRight (20)
	    or Link = LinkanRight (21) or Link = LinkanRight (22) or Link = LinkanRight (23) or Link = LinkanRight (24) or Link = LinkanRight (25)
	    or Link = LinkanRight (26) or Link = LinkanRight (27) or Link = LinkanRight (28) or Link = LinkanRight (29) or Link = LinkanRight (30)
	    or Link = LinkanRight (31) or Link = LinkanRight (32) or Link = LinkanRight (33)) then

	Link := LinkanAttack (2)
	LinkAttackState := LinkanAttackSword (2)

	LinkAttackx1 := LinkHitx1 + 20
	LinkAttackx2 := LinkHitx2 + 20
	LinkAttacky1 := LinkHity1
	LinkAttacky2 := LinkHity2

	fork RestoreRight


    elsif key (KEY_RIGHT_ARROW) and x < maxx - 10 and ~key ('z') and whatdotcolor (x + 15, y) = yellow then
	x += 6
	AttackPosX += 6
	LinkHitx1 += 6
	LinkHitx2 += 6
	xr += 1
	Link := LinkanRight (xr)
	if xr >= 33 then
	    xr := 0
	end if

	LinkAttackState := LinkanAttackSword (0)

	LinkAttackx1 := 0
	LinkAttackx2 := 0
	LinkAttacky1 := 0
	LinkAttacky2 := 0

    end if

    if key ('z') and (Link = LinkanUp (1) or Link = LinkanUp (2) or Link = LinkanUp (3) or Link = LinkanUp (4) or Link = LinkanUp (5)
	    or Link = LinkanUp (6) or Link = LinkanUp (7) or Link = LinkanUp (8) or Link = LinkanUp (9) or Link = LinkanUp (10)
	    or Link = LinkanUp (11) or Link = LinkanUp (12) or Link = LinkanUp (13) or Link = LinkanUp (14) or Link = LinkanUp (15)
	    or Link = LinkanUp (16) or Link = LinkanUp (17) or Link = LinkanUp (18) or Link = LinkanUp (19) or Link = LinkanUp (20)
	    or Link = LinkanUp (21) or Link = LinkanUp (22) or Link = LinkanUp (23) or Link = LinkanUp (24) or Link = LinkanUp (25)
	    or Link = LinkanUp (26) or Link = LinkanUp (27) or Link = LinkanUp (28) or Link = LinkanUp (29) or Link = LinkanUp (30)) then

	Link := LinkanAttack (3)
	LinkAttackState := LinkanAttackSword (3)

	LinkAttackx1 := LinkHitx1
	LinkAttackx2 := LinkHitx2
	LinkAttacky1 := LinkHity1 + 19
	LinkAttacky2 := LinkHity2 + 19


	fork RestoreUp

    elsif key (KEY_UP_ARROW) and ~key ('z') and (whatdotcolor (x, y + 8) = yellow) then
	y += 6
	AttackPosY += 6
	LinkHity1 += 6
	LinkHity2 += 6
	yu += 1
	Link := LinkanUp (yu)
	if yu >= 30 then
	    yu := 0
	end if
	LinkAttackState := LinkanAttackSword (0)

	LinkAttackx1 := 0
	LinkAttackx2 := 0
	LinkAttacky1 := 0
	LinkAttacky2 := 0

    end if

    if key ('z') and (Link = LinkanDown (1) or Link = LinkanDown (2) or Link = LinkanDown (3) or Link = LinkanDown (4) or Link = LinkanDown (5)
	    or Link = LinkanDown (6) or Link = LinkanDown (7) or Link = LinkanDown (8) or Link = LinkanDown (9) or Link = LinkanDown (10)
	    or Link = LinkanDown (11) or Link = LinkanDown (12) or Link = LinkanDown (13) or Link = LinkanDown (14) or Link = LinkanDown (15)
	    or Link = LinkanDown (16) or Link = LinkanDown (17) or Link = LinkanDown (18) or Link = LinkanDown (19) or Link = LinkanDown (20)
	    or Link = LinkanDown (21) or Link = LinkanDown (22) or Link = LinkanDown (23) or Link = LinkanDown (24) or Link = LinkanDown (25)
	    or Link = LinkanDown (26) or Link = LinkanDown (27) or Link = LinkanDown (28) or Link = LinkanDown (29) or Link = LinkanDown (30)) then

	Link := LinkanAttack (4)
	LinkAttackState := LinkanAttackSword (4)

	LinkAttackx1 := LinkHitx1
	LinkAttackx2 := LinkHitx2
	LinkAttacky1 := LinkHity1 - 19
	LinkAttacky2 := LinkHity2 - 19

	fork RestoreDown

    elsif key (KEY_DOWN_ARROW) and ~key ('z') and whatdotcolor (x, y - 8) = yellow then
	y -= 6
	AttackPosY -= 6
	LinkHity1 -= 6
	LinkHity2 -= 6
	yd += 1
	Link := LinkanDown (yd)
	if yd >= 30 then
	    yd := 0
	end if
	LinkAttackState := LinkanAttackSword (0)

	LinkAttackx1 := 0
	LinkAttackx2 := 0
	LinkAttacky1 := 0
	LinkAttacky2 := 0

    end if
    %Movement Ended%
    RoomSwitching % Checks if the player has touched a door and then takes the to their new room.

    if y - 8 < 3 and (Link = LinkanDown (1) or Link = LinkanDown (2) or Link = LinkanDown (3) or Link = LinkanDown (4) or Link = LinkanDown (5)
	    or Link = LinkanDown (6) or Link = LinkanDown (7) or Link = LinkanDown (8) or Link = LinkanDown (9) or Link = LinkanDown (10)
	    or Link = LinkanDown (11) or Link = LinkanDown (12) or Link = LinkanDown (13) or Link = LinkanDown (14) or Link = LinkanDown (15)
	    or Link = LinkanDown (16) or Link = LinkanDown (17) or Link = LinkanDown (18) or Link = LinkanDown (19) or Link = LinkanDown (20)
	    or Link = LinkanDown (21) or Link = LinkanDown (22) or Link = LinkanDown (23) or Link = LinkanDown (24) or Link = LinkanDown (25)
	    or Link = LinkanDown (26) or Link = LinkanDown (27) or Link = LinkanDown (28) or Link = LinkanDown (29) or Link = LinkanDown (30)) then 
		% If the player goes to the absolute bottom of the map.

	mapMoveY := 0 % Render the map at origin.
	%Link is teleported to near top of the screen.
	y := 330
	AttackPosY := 330
	LinkHity1 := 350
	LinkHity2 := 330

    end if

    Pic.Draw (map (RoomNumber), mapMoveX, mapMoveY, picCopy) % Renders the pretty map that the player gets to look at

    for i : 1 .. AmountOfHealth % Renders the health at the top of the screen
	Pic.Draw (Health (i), i * 15 - 15, maxy - 15, picMerge)
    end for

    Pic.Draw (Link, x - 8, y, picMerge)     % Renders the player
    %drawbox (LinkHitx1, LinkHity1, LinkHitx2, LinkHity2, brightred) %This is used for testing purposes
    %drawbox (LinkAttackx1, LinkAttacky1, LinkAttackx2, LinkAttacky2, brightred) %This is used for testing purposes

    if LinkAttackState = LinkanAttackSword (2) then     % This whole if statement renders the sword if need be.
	Pic.Draw (LinkAttackState, AttackPosX + 14, AttackPosY, picMerge)
    elsif LinkAttackState = LinkanAttackSword (1) then
	Pic.Draw (LinkAttackState, AttackPosX - 22, AttackPosY, picMerge)
    elsif LinkAttackState = LinkanAttackSword (3) then
	Pic.Draw (LinkAttackState, AttackPosX - 8, AttackPosY + 19, picMerge)
    elsif LinkAttackState = LinkanAttackSword (4) then
	Pic.Draw (LinkAttackState, AttackPosX - 6, AttackPosY - 15, picMerge)
    end if

    if RoomNumber = 1 and mapMoveY = 0 and Enemy1 = true then     % Renders the enemies depending on what room it is and if they are alive or not.
	Pic.Draw (Ghost1, Enemy1x, Enemy1y, picMerge)
	% drawbox (EnemyOneHitx1, EnemyOneHity1, EnemyOneHitx2, EnemyOneHity2, brightred) %This is used for testing purposes.
    end if

    if RoomNumber = 1 and mapMoveY = 0 and Enemy2 = true then
	Pic.Draw (Ghost2, Enemy2x, Enemy2y, picMerge)
	% drawbox (EnemyTwoHitx1, EnemyTwoHity1, EnemyTwoHitx2, EnemyTwoHity2, brightred) %This is used for testing purposes.
    end if

    if RoomNumber = 1 and mapMoveY = 0 and Enemy3 = true then
	Pic.Draw (Ghost3, Enemy3x, Enemy3y, picMerge)
	% drawbox (EnemyThreeHitx1, EnemyThreeHity1, EnemyThreeHitx2, EnemyThreeHity2, brightred) %This is used for testing purposes.
    end if

    if RoomNumber = 1 and mapMoveY = 0 and Enemy4 = true then
	Pic.Draw (Ghost4, Enemy4x, Enemy4y, picMerge)
	% drawbox (EnemyFourHitx1, EnemyFourHity1, EnemyFourHitx2, EnemyFourHity2, brightred) %This is used for testing purposes.
    end if

    if RoomNumber = 3 and mapMoveY = 0 and Enemy5 = true then
	Pic.Draw (Zombie1, Enemy5x, Enemy5y, picMerge)
	% drawbox (EnemyFiveHitx1, EnemyFiveHity1, EnemyFiveHitx2, EnemyFiveHity2, brightred) %This is used for testing purposes.
    end if

    if RoomNumber = 4 and mapMoveY = 0 and Enemy6 = true then
	Pic.Draw (Zombie2, Enemy6x, Enemy6y, picMerge)
	% drawbox (EnemySixHitx1, EnemySixHity1, EnemySixHitx2, EnemySixHity2, brightred) %This is used for testing purposes.
    end if

    if RoomNumber = 4 and mapMoveY = 0 and Enemy7 = true then
	Pic.Draw (Zombie3, Enemy7x, Enemy7y, picMerge)
	% drawbox (EnemySevenHitx1, EnemySevenHity1, EnemySevenHitx2, EnemySevenHity2, brightred) %This is used for testing purposes.
    end if

    if RoomNumber = 6 and mapMoveY = 0 and Enemy8 = true then
	Pic.Draw (Zombie4, Enemy8x, Enemy8y, picMerge)
	% drawbox (EnemyEightHitx1, EnemyEightHity1, EnemyEightHitx2, EnemyEightHity2, brightred) %This is used for testing purposes.
    end if

    if RoomNumber = 6 and mapMoveY = 0 and Enemy9 = true then
	Pic.Draw (Ghost9, Enemy9x, Enemy9y, picMerge)
	% drawbox (EnemyNineHitx1, EnemyNineHity1, EnemyNineHitx2, EnemyNineHity2, brightred) %This is used for testing purposes.
    end if

    if RoomNumber = 5 and mapMoveY = 0 and BossEN = true and Boss not= BossAn (2) then
	Pic.Draw (Boss, Bossx, Bossy, picMerge)
	% drawbox (BossHitx1, BossHity1, BossHitx2, BossHity2, brightred) %This is used for testing purposes.

    elsif RoomNumber = 5 and mapMoveY = 0 and BossEN = true and Boss = BossAn (2) then
	Pic.Draw (Boss, Bossx + 20, Bossy, picMerge)
	Pic.Draw (BossAn (3), Bossx + 20, Bossy - 27, picMerge)
	% drawbox (BossHitx1, BossHity1, BossHitx2, BossHity2, brightred) %This is used for testing purposes.
    end if

    if BossEN = false then % When the boss dies it displays a win screen and you can exit the program now.
	Pic.Draw (TitleScreen, 0, 0, 0)
	Font.Draw ("YOU WIN!", 40, 290, font1, 72)
    end if


    View.Update % Finally redraws the frame.
end ReDraw

loop % this is the main loop the game takes place in.

    fork StartScreenMusic % Plays the start screen's music.

    loop

	Pic.Draw (TitleScreen, 0, 0, 0) % The title screen.
	Font.Draw ("The Legend Of Ripoff", 40, 290, font1, 72) % The title.
	Font.Draw ("Start", 257, 230, font2, white) % The start button.
	Font.Draw ("Controls", 226, 180, font2, white) % The controls button.

	Mouse.Where (Mousex, Mousey, b) % Detects where the mouse is placed.
	if Mousex > 250 and Mousex < 383 and Mousey > 229 and Mousey < 260 then % if the mouse is within a certain x and y then
	    Font.Draw ("Start", 257, 230, font2, 72) % Start is highlighted
	elsif Mousex > 222 and Mousex < 417 and Mousey > 184 and Mousey < 211 then
	    Font.Draw ("Controls", 226, 180, font2, blue) % Contorls are highlighted
	else
	    Font.Draw ("Start", 257, 230, font2, white) % If the mouse is not in that place then the buttons are no longer highlighted.
	    Font.Draw ("Controls", 226, 180, font2, white)
	end if

	if Mousex > 250 and Mousex < 383 and Mousey > 229 and Mousey < 260 and b = 1 then % If start is pressed then
	    StartScreenON := false % Used for music.
	    exit % Exits out of this loop to go into the game loop
	elsif Mousex > 222 and Mousex < 417 and Mousey > 184 and Mousey < 211 and b = 1 or bpressed = 1 then % If controls have been pressed then
	    bpressed := 1 % keeps the screen up
	    ViewControls % Changes to the control screen.
	end if
	View.Update
    end loop

    Music.PlayFileStop % Ends the start screen music.
    colorback (black)
    cls % Make the back behind all the rendering black.
    View.Update % Redraw for the start screen.

    fork MainTheme

    loop

	Input.KeyDown (key) % This is what detects the button presses.
	ReDraw % Redraws the frame
	delay (40) % This is so everything doesn't happen too fast.

	if AmountOfHealth = 0 then % If the player dies then

	    Pic.Draw (TitleScreen, 0, 0, 0) % The title screen background is reused
	    Font.Draw ("YOU LOSE!", 40, 290, font1, 72)
	    View.Update % Draw everything

	    delay (2000)

	    exit % This exits out of the game loop to go into the bigger loop that will restart everything.

	end if

    end loop

    % This just resets all the variables to what they were before the game started.

    AmountOfHealth := 10
    RoomNumber := 1

    x := 250
    y := 250
    AttackPosX := x
    AttackPosY := y
    LinkHitx1 := x + 10
    LinkHitx2 := x - 10
    LinkHity1 := y
    LinkHity2 := y + 19


    LinkAttackx1 := 0
    LinkAttackx2 := 0
    LinkAttacky1 := 0
    LinkAttacky2 := 0

    %Enemy 1%
    Enemy1 := true
    Enemy1x := 250
    Enemy1y := 50

    Ghost1 := GhostlyAn (1)

    EnemyOneHitx1 := 250
    EnemyOneHitx2 := 274
    EnemyOneHity1 := 50
    EnemyOneHity2 := 80

    %Enemy 2%
    Enemy2 := true
    Enemy2x := 300
    Enemy2y := 50

    Ghost2 := GhostlyAn (1)

    EnemyTwoHitx1 := 250 + 50
    EnemyTwoHitx2 := 274 + 50
    EnemyTwoHity1 := 50
    EnemyTwoHity2 := 80

    %Enemy 3%
    Enemy3 := true
    Enemy3x := 350
    Enemy3y := 50

    Ghost3 := GhostlyAn (1)

    EnemyThreeHitx1 := 250 + 100
    EnemyThreeHitx2 := 274 + 100
    EnemyThreeHity1 := 50
    EnemyThreeHity2 := 80

    %Enemy 4%
    Enemy4 := true
    Enemy4x := 400
    Enemy4y := 50

    Ghost4 := GhostlyAn (1)

    EnemyFourHitx1 := 250 + 150
    EnemyFourHitx2 := 274 + 150
    EnemyFourHity1 := 50
    EnemyFourHity2 := 80

    %Enemy 5%
    Enemy5 := true
    Enemy5x := 250 - 40
    Enemy5y := 50

    Zombie1 := ZombieAn (1)

    EnemyFiveHitx1 := 250 - 40
    EnemyFiveHitx2 := 274 - 40
    EnemyFiveHity1 := 50
    EnemyFiveHity2 := 80

    %Enemy 6%
    Enemy6 := true
    Enemy6x := 250 - 40
    Enemy6y := 50

    Zombie2 := ZombieAn (1)

    EnemySixHitx1 := 250 - 40
    EnemySixHitx2 := 274 - 40
    EnemySixHity1 := 50
    EnemySixHity2 := 80

    %Enemy 7%
    Enemy7 := true
    Enemy7x := 250 + 40
    Enemy7y := 50 + 100

    Zombie3 := ZombieAn (1)

    EnemySevenHitx1 := 250 + 40
    EnemySevenHitx2 := 274 + 40
    EnemySevenHity1 := 50 + 100
    EnemySevenHity2 := 80 + 100

    %Enemy 8%
    Enemy8 := true
    Enemy8x := 250 - 60
    Enemy8y := 50

    Zombie4 := ZombieAn (1)

    EnemyEightHitx1 := 250 - 60
    EnemyEightHitx2 := 274 - 60
    EnemyEightHity1 := 50
    EnemyEightHity2 := 80

    %Enemy 9%
    Enemy9 := true
    Enemy9x := 250 + 40
    Enemy9y := 50 + 200

    Ghost9 := GhostlyAn (1)

    EnemyNineHitx1 := 250 + 40
    EnemyNineHitx2 := 274 + 40
    EnemyNineHity1 := 50 + 200
    EnemyNineHity2 := 80 + 200

    %Enemy Boss%
    BossHealth := 3
    BossEN := true
    Bossx := 250 + 40
    Bossy := 50 + 200


    Boss := BossAn (1)

    BossHitx1 := 250 + 60
    BossHitx2 := 274 + 70
    BossHity1 := 50 + 173
    BossHity2 := 80 + 205

end loop

