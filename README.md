# SkiSanta

#### Video Demo:  https://youtu.be/OSJ9fUjUVh0

#### Description:

**SKISANTA** is a 2D game developed using Lua and the LÖVE2D framework. In this game, players control a Santa Claus who skis through a snowy landscape while avoiding obstacles. The objective is to achieve the highest possible score by surviving as long as possible.

## Game Features

- **Menu Screen**: Upon starting the game, players are greeted with a main menu from where they can either start playing or quit the game.
- **Player Control**: Players control Santa's movement with left and right arrow keys. The player must navigate Santa to avoid various obstacles.
- **Dynamic Difficulty**: As the game progresses and your score gets higher, the difficulty increases as well. Obstacles move faster and more obstacles appear over time (Your little hat moves faster too).
- **Scoring System**: The score increases as time goes by, reflecting the length of time the player survives. When you start the game, you will be able to see your current score, as well as the highest achieved score in the top left corner of the game window.
- **Ending Screen**: Upon hitting an obstacle, the ending screen will appear showing the score you managed to get and notify you if it is your new high score. From this screen players can chose to either replay or exit the game.

## Gameplay Mechanics

- **Controls**:
  - Use the **Arrow Keys** to move Santa left and right.
  - **Escape** to pause the game.
  - Use **Mouse Left Button Click** to navigate through menu screens.

- **Obstacles**:
  - Different types of obstacles appear on the skiing path. The program randomly generates if the obstacle will look like a Snowman or a Christmas Three
  - Obstacles increase in number and speed as the game progresses, making it more and more challenging to keep avoind them.

- **Scoring**:
  - The score increases based on the duration of gameplay.
  - No additional points are awarded for avoiding obstacles; the score purely reflects survival time, so just stay alive, how hard can it be? 
  - The current high score is shown in the top left corner of the game screen, right bellow your current score, and it will update accordingly if you manage to beat it.

## Development Details

- **Engine**: LÖVE2D 11.3 (Myseterious Mysteries)
- **Programming Language**: Lua
- **Assets**: Custom sprites designed for the game to represent moving santa and different obstacles. The sprites are created and edited using **Piskel** - online sprite editor.
- **Code Repository**: [https://github.com/Inizio12/luaLove2d]
