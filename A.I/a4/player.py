import random
import math

class Player:

    def __init__(self, depthLimit, isPlayerOne):

        self.isPlayerOne = isPlayerOne
        self.depthLimit = depthLimit

        edge = [3, 4, 5, 5, 4, 3]
        second = [4, 6, 8, 8, 6, 4]
        third = [5, 8, 11, 11, 8, 5]
        middle = [7, 10, 13, 13, 10, 7]
        self.table = [edge, second, third, middle, third, second, edge]

    def heuristic(self, board):
        score = 0
        state = board.isTerminal()
        if state == 1:
            score = 1000
        elif state == 2:
            score = -1000
        elif state == -1:
            for i in range(0, 7):
                for j in range(0, len(board.board[i])):
                    if board.board[i][j] == 0:
                        score += self.table[i][j]
                    else:
                        score -= self.table[i][j]
        return score

    def getValidMoves(self, board):
        validColumns = []
        if board.lastMove is not None:
            score = self.heuristic(board)
            print("Score", score)
        for i in range(0, 7):
            if len(board.board[i]) < 6:
                validColumns.append(i)
        return validColumns


class PlayerMM(Player):
    def __init__(self, depthLimit, isPlayerOne):
        super().__init__(depthLimit, isPlayerOne)

    def findMove(self, board):
        score, move = self.minimax(board, self.depthLimit, self.isPlayerOne)
        return move

    def minimax(self, node, depth, isMax):
        state = node.isTerminal()
        if state is not -1:
            if state == 0:
                return 0, -1
            elif state == 1:
                return 1000, -1
            elif state == 2:
                return -1000, -1

        elif depth == 0:
            return self.heuristic(node), -1

        children = node.children()
        if isMax:
            finalScore = -math.inf
            shouldReplace = lambda x: x > finalScore
        else:
            finalScore = math.inf
            shouldReplace = lambda x: x < finalScore

        finalMove = -1

        for child in children:
            childmove, childBoard = child

            temp = self.minimax(childBoard, depth - 1, not isMax)[0]

            if shouldReplace(temp):
                finalScore = temp
                finalMove = childmove

        return finalScore, finalMove


class PlayerAB(Player):

    def __init__(self, depthLimit, isPlayerOne):
        super().__init__(depthLimit, isPlayerOne)

    def findMove(self, board):
        score, move = self.alphabeta(board, self.depthLimit, -math.inf, math.inf, self.isPlayerOne)
        return move

    def alphabeta(self, node, depth, alpha, beta, isMax):
        state = node.isTerminal()
        if state is not -1:
            if state == 0:
                return 0, -1
            elif state == 1:
                return 1000, -1
            elif state == 2:
                return -1000, -1

        elif depth == 0:
            return self.heuristic(node), -1

        children = node.children()

        if isMax:
            finalScore = -math.inf
            shouldReplace = lambda x: x > finalScore
        else:
            finalScore = math.inf
            shouldReplace = lambda x: x < finalScore

        finalMove = -1

        for child in children:
            childmove, childBoard = child

            temp = self.alphabeta(childBoard, depth - 1, alpha, beta, not isMax)[0]

            if shouldReplace(temp):
                finalScore = temp
                finalMove = childmove

            if isMax:
                alpha = max(alpha, temp)
            else:
                beta = min(beta, temp)

            if alpha >= beta:
                break
        return finalScore, finalMove

#######################################################
###########Example Subclass for Testing
#######################################################

#This will inherit your findMove from above, but will override the heuristic function with
#a new one; you can swap out the type of player by changing X in "class TestPlayer(X):"
