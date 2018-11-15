##############
# Node Class #
##############

# You may add more functions to this class
class Node:

    def __init__(self, board, parent, fValue, depth):
        self.board = board
        self.parent = parent
        self.fValue = fValue
        self.depth = depth

    def __eq__(self, other):
        return self.board == other.board

    def __lt__(self, other):
        return self.fValue < other.fValue

    def __str__(self):
        return str(self.board)+"\nf: " + str(self.fValue)+ "\nsteps: "+ str(self.depth)+"\n"

    def __bool__(self):
        return True

    def children(self):
        lst = []
        if self.board.slideBlank((0,1)) is not None:
            lst.append(Node(self.board.slideBlank((0,1)), self,self.fValue,self.depth+1))
        if self.board.slideBlank((0,-1)) is not None:
            lst.append(Node(self.board.slideBlank((0,-1)), self,self.fValue,self.depth+1))
        if self.board.slideBlank((1,0)) is not None:
            lst.append(Node(self.board.slideBlank((1,0)), self,self.fValue,self.depth+1))
        if self.board.slideBlank((-1,0)) is not None:
            lst.append(Node(self.board.slideBlank((-1,0)), self,self.fValue,self.depth+1))
        return lst
    # Function to print a completed path from #
    # the initial state to the solution state #
    def printPath(self):
        print(self.board)
        if self.parent is not None:
            self.parent.printPath()

    def __hash__(self):
        return hash(self.board)
