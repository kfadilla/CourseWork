from board import Board
#working with Haoyang Hu
class Solver:

    ##########################################
    ####   Constructor
    ##########################################
    def __init__(self,filename):
        self.board = Board(filename)
        self.solve()

    ##########################################
    ####   Solver
    ##########################################

    #recursively selects the most constrained unsolved space and attempts
    #to assign a value to it
    #
    #upon completion, it will leave the board in the solved state (or original
    #state if a solution does not exist)
    def solve(self):
        if len(self.board.unSolved) == 0:
           return True
        space = self.board.getMostConstrainedUnsolvedSpace()
        for val in range(1, self.board.n2+1):
            if self.board.isValidMove(space, val):
               self.board.makeMove(space, val)
               if self.solve():
                  return True
               else:
                  self.board.removeMove(space,val)               
        return False
if __name__ == "__main__":

    #change this to the input file that you'd like to test
    s = Solver('testBoard_dastardly.csv')
