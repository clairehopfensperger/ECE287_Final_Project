# Tic_Tac_Toe
Check out the [wiki](https://github.com/clairehopfensperger/Tic_Tac_Toe/wiki) for information about the project!

<!--
<h1 align = "center">ECE287 Final Project</h1>

## About the project: 
- Completely open ended
- Could create anything we wanted using the skills we learned in this class and resources found outside of class
<br>

## Initial Proposal:
#### Our idea: Tic-Tac-Toe

We would like to make a fully functional single-player (against the “computer”) or two-player Tic-Tac-Toe game using graphics to display the game on a monitor and the FPGA board to control the moves.

#### Problems we’ll need to solve:
- Checking validity of moves (if box is already full)
- Addressing wins or ties
- Placing markers for moves
- Actually creating the graphics

#### Professor's Commentary:
"Game is a little on the simple side, but with an AI the problem becomes more interesting. The next question is there levels of AI?  Next version get more into the details as discussed in class. How long will each piece take?"
<br><br>

## Revised Proposal:
<table>
  <tr>
    <th>Project Component</th>
    <th>Explanation/Difficulties</th>
  </tr>
  <tr>
    <td>Graphics</td>
    <td>We need to figure out how the VGA output works and how we can use that to display something onto a monitor. After that we need to figure out how we can change that display when something is done on the FPGA. We got a VGA from a peer, but we don’t understand how to use it yet.</td>
  </tr>
  <tr>
    <td>Wins/Tie</td>
    <td>In order to have logic of winning or losing we need to figure out the difference between hardware and object oriented programming. Differentiating that will most likely be the hardest thing in this step. Once we do, we will have a check every time a move is done to see if there are three symbols from the same player in a row and declare a winner with an LED. If there is no winner and the board is full, then we will have another LED declaring a tie.</td>
  </tr>
  <tr>
    <td>Moves/Valid Moves</td>
    <td>Moves are going to be taken in by switches with each spot having a decimal value. We are going to need to have a button or switch that checks to see if a move can be placed in a spot on the tic tac toe table. If the move is valid then we need to use our knowledge of updating the pixels to show that a move was made. <br><br>Our initial idea is to have 9 registers, one for each square of the tic-tac-toe grid, and whenever a player moves, a different number is placed in the register. So perhaps all the registers could start with 2’b00 in them, and when player 1 makes a move, the register relating to the block they pick would then be given the value 2’b01. Same for player 2 but the value 2’b10 would be correlated with them. Then, for checking the validity of a move, the register correlating to the player’s square choice would be checked, and if it holds the value 2’b00, then the player can move to the block, thus being a valid move. If the register doesn’t hold the value 2’b00, then it’s an invalid move and the player has to choose a different square.</td>
  </tr>
  <tr>
    <td>Player Vs. Player and Player Vs. AI</td>
    <td>Changing between modes seems to be the simpler thing to tackle. We will need a switch that changes the game mode (Vs AI or Vs other player). In this game mode we can just have the first switch input be for player one and then the next valid input for a move will be for player two. If the user wants to play Vs an AI then we will have some sort of pseudo random number gen and if it lands on a certain number then we can have the computer make a “mistake” and not place a symbol in the right place to stop a win from the player. <br><br>The actual implementation of the AI seems like a super tricky part right now. We haven’t looked super deep into this aspect of our project as of now, but the two options for this problem seem to be either finding some sort of tic-tac-toe AI or creating one ourselves. If we are to create one ourselves, it would probably be some “AI” module with tons of cases for each possible move. There could potentially be a huge amount of possibilities for the AI’s move, so when we get closer to this issue we will reassess and find the most realistic approach to this issue.</td>
  </tr>
</table>

#### Modules plan as of now:
<ul class="disk">
<li>Tic-Tac-Toe</li>
	<ul class="circle">
    <li>Top level</li>
  </ul>
<li>Register</li>
  <ul class="circle">
    <li>Instantiate one for each tic-tac-toe grid sqaure</li>
  </ul>
<li>Outcome_Logic</li>
  <ul class="circle">
    <li>Determine if game is win/lose/tie</li>
    <li>Plan to use this module to check after each move</li>
  </ul>
<li>VGA stuff</li>
  <ul class="circle">
    <li>Not sure what all needs to be done for this quite yet, but we know we need it</li>
  </ul>
<li>AI</li>
  <ul class="circle">
    <li>Controls the "computer"'s moves</li>
    <li>Figure out where we'll differenciate between setting of player vs. player or player vs. AI</li>
  </ul>
</li>
</ul>

#### Other notes:
- Could possibly keep score on 7-seg displays

#### Professor's Commentary:
"Looks better...now you need to do it. The data for the game could be a single register with {A[1:0], B[1:0], C[1:0], D[1:0] ...} where A == 2'b00 is empty, A == 2'b01 is X and A == 2'b10 is O for the top left corner.  But your register per spot will also work."
<br>
-->
