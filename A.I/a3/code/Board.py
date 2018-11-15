    
###############
# Board Class #
###############

class Board:


    # The 8-puzzle board representation #
    def __init__(self, matrix):
        self.matrix = matrix
        for i in range(len(matrix)):
            if 0 in matrix[i]:
                self.blankPos = (i, matrix[i].index(0))
                return
        raise ValueError("Invalid Matrix!")

    
    # A function to provide a string description of the board #

    def __str__(self):
        s = ""
        for i in range(len(self.matrix)):
            s += str(self.matrix[i]) + "\n"
        return s + "\n"


    # Function to check if a given board is the desired goal #

    def __eq__(self, other):
        if type(other) is not Board:
            return False
        otherMatrix = other.matrix
        thisMatrix = self.matrix
        if len(thisMatrix) != len(otherMatrix):
            return False
        for i in range(len(thisMatrix)):
            if len(thisMatrix[i]) != len(otherMatrix[i]):
                return False
            for j in range(len(thisMatrix[i])):
                if thisMatrix[i][j] != otherMatrix[i][j]:
                    return False
        return True
    

    # A function to create a copy of the Board object itself #
    
    def duplicate(self):
        newMatrix = []
        for i in range(len(self.matrix)):
            newMatrix.append([])
            for j in range(len(self.matrix[i])):
                newMatrix[i].append(self.matrix[i][j])
        return Board(newMatrix)


    # A function that returns a tuple containing the (row, col) #
    # position of the value elem in the                         #

    def findElement(self, elem):
        for i in range(len(self.matrix)):
            for j in range(len(self.matrix[i])):
                if self.matrix[i][j] == elem:
                    return (i, j)
        return None


    # A function that puts the four sliding functions together, and #
    # takes a direction as  input                                   #

    def slideBlank(self, dir):
        # dir is a tuple (deltaY,deltaX)
        if dir not in [(0, 1), (0, -1), (-1, 0), (1, 0)]:
            raise ValueError("Invalid dir")
        newBlankPos = (self.blankPos[0] + dir[0], self.blankPos[1] + dir[1])
        if newBlankPos[0] < 0 or newBlankPos[0] > len(self.matrix) - 1:
            return None
        elif newBlankPos[1] < 0 or newBlankPos[1] > len(self.matrix[0]) - 1:
            return None
        else:
            newBoard = self.duplicate()
            saveVal = newBoard.matrix[self.blankPos[0] + dir[0]][self.blankPos[1] + dir[1]]
            newBoard.matrix[self.blankPos[0] + dir[0]][self.blankPos[1] + dir[1]] = 0
            newBoard.matrix[self.blankPos[0]][self.blankPos[1]] = saveVal
            newBoard.blankPos = (self.blankPos[0] + dir[0], self.blankPos[1] + dir[1])
            return newBoard

    def __hash__(self):
        s = 0
        for i in range(len(self.matrix)):
            for j in range(len(self.matrix[i])):
                s *= 10
                s += self.matrix[i][j]
        return s
