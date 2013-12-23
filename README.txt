Raindrop Game
The goal of the game is to catch as many raindrops as possible with the catcher at the bottom.
The more you catch, the higher the score.
Left and right arrow keys control acceleration in either direction.
Time Attack Mode: You have 2 minutes to catch as many raindrops as possible. Unlimited lives.
Survival: You have 10 lives to catch as many raindrops. Unlimitd time.
Story Mode: After ever game, you can upgrade your catcher using the raindrops you collect as currency.
Basic Algorithm:
- create catcher, raindrop, and lightning class
- create time (if time attack mode) variables and life (if survival mode) variables
- play music
- initialize a catcher, lightning, and array of raindrops
- raindrops fall
- catcher acceleration changes with left and right arrow keys
- if lightning appears, the catcher cannot move
- if the distance between the catcher and raindrop is smaller than the radii, the raindrop is caught
- if the raindrop is caught, it will move off the screen and increase scor
- if the raindrop falls under the screen, the raindrop is missed
- if the raindrop is missed, it will increase the number of lives lost (if in story or survival mode) and move off the screen 
- if the number of lives lost equals the maximum amount of lives or if time is up, game over is true
- if game over is true, display "Game Over, Press 'ENTER' to return to menu"
= if enter is pressed when game over is true, return to the menu
- if "R" is pressed while the game being played, the game over conditions will be met to end the game
Menu Algorithm:
- create catcher, raindrop, lightning and button class
- create location variable
- if the mouse is on the button, the text will turn white
- raindrops will fall as normal
- using kinematic equations, the catcher will automatically reach the raindrop the exact same time the raindrop will reach the height of the catcher
- give lightning a chance to appear
- if lighting appears, it will flash and the sound effect will play
- if a button is pressed, location variable will change
GLITCH
A glitch I haven't been able to fix is that sometimes when a button is clicked, the "Null Pointer Exception" error will pop up and the whole program will stop working.
