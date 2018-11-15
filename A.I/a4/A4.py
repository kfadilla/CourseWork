from board import Board
from player import *
import requests
import cProfile

#To be updated when instructor server is live via "git pull"
instructorURL = "http://104.131.5.187:2222"
#working with lincanr (Canrong Lin)

class Game:


    def __init__(self, startBoard, player1, player2):
        self.startBoard = startBoard
        self.player1 = player1
        self.player2 = player2

    ########################################################################
    #                     Simulate a Local Game
    ########################################################################

    def simulateLocalGame(self):

        board = Board(orig=self.startBoard)
        isPlayer1 = True

        while(True):

            #finds the move to make
            if isPlayer1:
                move = self.player1.findMove(board)
            else:
                move = self.player2.findMove(board)

            #makes the move
            board.makeMove(move)
            board.print()

            #determines if the game is over or not
            isOver = board.isTerminal()
            if isOver == 0:
                print("It is a draw!")
                break
            elif isOver == 1:
                print("Player 1 wins!")
                break
            elif isOver == 2:
                print("Player 2 wins!")
                break
            else:
                isPlayer1 = not isPlayer1


    ########################################################################
    #               Simulate a Remote Game (against our server)
    #
    ########################################################################

    #Play against the instructor AI server

    #NOTE: This will not yet work as the combat server is not currently online. It will be open at least
    #one week before the assignment is due.
    
    def playAgainstInstructor(self, difficulty):

        if difficulty < 0 or difficulty > 5:
            print("Difficulty must be between 0 and 5")
            return

        board = Board(orig=self.startBoard)
        isPlayer1 = True

        session = requests.get(instructorURL + "/startgame/" + str(difficulty)).cookies

        while (True):

            # finds the move to make
            if isPlayer1:
                move = self.player1.findMove(board)
            else:
                r = requests.get(instructorURL + "/getresponse/" + str(board.lastMove[1]), cookies=session)
                session = r.cookies
                move = int(r.text)

            # makes the move
            board.makeMove(move)
            board.print()

            # determines if the game is over or not
            isOver = board.isTerminal()
            if isOver == 0:
                print("It is a draw!")
                break
            elif isOver == 1:
                print("Player 1 wins!")
                break
            elif isOver == 2:
                print("Player 2 wins!")
                break
            else:
                isPlayer1 = not isPlayer1


if __name__ == "__main__":
    sample = Game(Board(), PlayerAB(7, True), PlayerAB(7, False))
    # cProfile.run('sample.simulateLocalGame()')
    sample.simulateLocalGame()
    #create game and join lobby here
