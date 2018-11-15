# Assignment 1
import math

#################################
# Problem 1
#################################
# Objectives:
# (1) Write a recursive function to compute the nth fibonacci number

def fib(n):
    if (n == 0):
        return 0
    if (n == 1):
        return 1
    else:
        return fib(n - 1) + fib(n - 2)


#################################
# Problem 2
#################################
# Objectives:
# (1) Write a function which uses a for loop to sum the numbers from 0 to n

def sum(n):
    while (n != 0):
        return n + sum(n-1)
    return 0    


#################################
# Problem 3
#################################
# Objectives:
# (1) Write a function which takes a matrix and returns the transpose of that matrix
# Note: A matrix is represented as a 2-d array: [[1,2,3],[4,5,6],[7,8,9]]


def transpose(matrix):
    row = len(matrix)
    col = len(matrix[0])
    ret = []
    nrow = []
    for i in range(col):
        for j in range(row):
            if i != j:
                nrow.append(matrix[j][i])
            else:
                nrow.append(matrix[i][j])
        ret.append(nrow)
        nrow = []
    return ret




#################################
# Problem 4
#################################
# Objectives:
# (1) Write a function which takes two points of the same dimension, and finds the euclidean distance between them
# Note: A point is represented as a tuple: (0,0)

def euclidean(p1,p2):
    innerSum = 0
    for i in range(len(p1)):
        innerSum += (p2[i] - p1[i]) ** 2
    return math.sqrt(innerSum)






#################################
# Problem 5
#################################

# A Node is an object
# - value : Number
# - children : List of Nodes
class Node:
    def __init__(self, value, children):
        self.value = value
        self.children = children


exampleTree = Node(1,[Node(2,[]),Node(3,[Node(4,[Node(5,[]),Node(6,[Node(7,[])])])])])



# Objectives:
# (1) Write a function to calculate the sum of every node in a tree (iteratively)

def sumNodes(root):
    lst = [root]
    ret = 0
    while len(lst) != 0:
        ret += lst[0].value
        lst = lst[1:] + lst[0].children
    return ret


            

# (2) Write a function to calculate the sum of every node in a tree (recursively)

def sumNodesRec(root):
    ret = 0
    if (root.children == []):
        return root.value
    else:
        for child in root.children:
            ret += sumNodes(child)
        ret += root.value
        return ret




#################################
# Problem 6
#################################
# Objectives:
# (1) Write a function compose, which takes an inner and outer function
# and returns a new function applying the inner then the outer function to a value

def compose(f_outer, f_inner):
    Result = lambda x: f_outer(f_inner(x))
    return Result




#################################
# Bonus
#################################
# Objectives:
# (1) Create a string which has each level of the tree on a new line

def treeToString(root):
    ret = ""
    if (root.children == []):
        return str(root.value) + "\n"
    else:
        ret += str(root.value)
        for child in root.children:
            ret += str(sumNodes(child))
        return ret
