import Board
import Node
import time
import heapq


###############################
# Uninformed Search Functions #
###############################



# Parameter Explanation
# frontier - a list of board object that you can "see" but have not visited yet
# limit - the number of times left in this search
# goalBoard - the ultimate goal for your search
# mode - True if DFS
#        False if BFS


# Main Uninformed Search
# This function should return True or the solution Node object if it is the last step of a search,
# and return False if it wants the wrapper function to continue searching.

# This function should do the general job for one iteration of search,
# include but not limited to fetching a node from frontier,
# checking if it matches goalBoard and call uninformedExpansion sometime to add successors.
def uninformedSearch(frontier, limit, goalBoard, mode):
    if not frontier:
        return True
    else:
        if mode:
            currentNode = frontier.pop()
        else:
            currentNode = frontier.pop(0)
            # TODO:Get current Node from fromtier in BFS
        if currentNode.board == goalBoard:
            print("Found Goal!")
            return currentNode
        elif limit == 0:
            print("Limit Reached")
            return True
        else:
            uninformedExpansion(currentNode, frontier, goalBoard)
            return False


# Function to expand the frontier (frontier is a queue), adding
# children of the currentNode to the back of the frontier.
# This is the only expansion function for uninformed search.
# It is used for both BFS and DFS search
# It does not return anything

def uninformedExpansion(currentNode, frontier, goalBoard):
    if (currentNode.board.slideBlank((0,1))):
        frontier.append(Node.Node(currentNode.board.slideBlank((0,1)), currentNode, currentNode.fValue, currentNode.depth+1))
        
    if (currentNode.board.slideBlank((0,-1))):
        frontier.append(Node.Node(currentNode.board.slideBlank((0,-1)), currentNode, currentNode.fValue, currentNode.depth+1))
        
    if (currentNode.board.slideBlank((1,0))):
        frontier.append(Node.Node(currentNode.board.slideBlank((1,0)), currentNode, currentNode.fValue, currentNode.depth+1))
        
    if (currentNode.board.slideBlank((-1,0))):
        frontier.append(Node.Node(currentNode.board.slideBlank((-1,0)), currentNode, currentNode.fValue, currentNode.depth+1))
# Wrapper function                              #

# board - the original unsolved board
# limit - the limit number of nodes you want to search
# goalBoard - a board object that is your ultimate goal after moving around the blank spot


# This function starts a search process,
# initialize a frontier and call uninformedSearch in a loop
# It returns the result of search functions if there is a solution,
# and return None if it cannot find one.
def uninformedClient(board, limit, goalBoard, mode):
    frontier = [Node.Node(board, None, 0,0)]
    result = uninformedSearch(frontier,limit,goalBoard, mode)
    while not (isinstance(result, Node.Node)):
         if result:
             return None
         else:
             result = uninformedSearch(frontier,limit,goalBoard, mode)
    return result    


#####################################
# Heuristics and improved searching #
#####################################

# Parameter explanation
# frontier - a list of board object that you can "see" but have not visited yet
# limit - the number of times left in this search
# currentNode - the Node your are visiting
# goalBoard - the ultimate goal for your search
# explored - a set that is used to store all Nodes you have visited
# astar - True if it is an A* search
#         False if it is a uniform cost search (UCS)

# Main Informed Search Loop
# Just like the uninformedSearch function you just implemented,
# the fastSearch function should do the general search job for one iteration

def fastSearch(frontier, limit, goalBoard, explored, astar):
    if not frontier:
        return True
    else:
        curr = heapq.heappop(frontier)
        if astar:
            aStarExpansion(curr, frontier, goalBoard, explored)
        else:
            uniformCostExpansion(curr, frontier, goalBoard, explored)
        if curr.board == goalBoard:
            print("Found Goal!")
            return curr
        elif limit == 0:
            print("Limit Reached")
            return True


# Wrapper function
# This function starts a search process,
# initialize a frontier and an explored set and call uninformedSearch in a loop
# It returns the result of search functions if there is a solution,
# and return None if it cannot find one.
def fastSearchClient(board, limit, goalBoard, astar):
    frontier = [Node.Node(board, None, 0,0)]
    explored = set()
    result = fastSearch(frontier,limit,goalBoard, explored, astar)
    while not (isinstance(result,Node.Node)):
         if result:
             return None
         else:
             limit -= 1
             result = fastSearch(frontier,limit,goalBoard, explored, astar)
    return result

# Function to expand the frontier using uniform cost search #
def uniformCostExpansion(currentNode, frontier, goalBoard, explored):
    if (currentNode.board.slideBlank((0,1)) and (Node.Node(currentNode.board.slideBlank((0,1)), currentNode, currentNode.depth + 1, currentNode.depth+1) not in explored)):
        heapq.heappush(frontier,Node.Node(currentNode.board.slideBlank((0,1)), currentNode, currentNode.depth + 1, currentNode.depth+1))
        explored.add(Node.Node(currentNode.board.slideBlank((0,1)), currentNode, currentNode.depth + 1, currentNode.depth+1))
        
    if (currentNode.board.slideBlank((0,-1)) and (Node.Node(currentNode.board.slideBlank((0,-1)), currentNode,currentNode.depth + 1, currentNode.depth+1) not in explored)):
        heapq.heappush(frontier,Node.Node(currentNode.board.slideBlank((0,-1)), currentNode, currentNode.depth + 1, currentNode.depth+1))
        explored.add(Node.Node(currentNode.board.slideBlank((0,-1)), currentNode, currentNode.depth + 1, currentNode.depth+1))
        
    if (currentNode.board.slideBlank((1,0)) and (Node.Node(currentNode.board.slideBlank((1,0)), currentNode, currentNode.depth + 1, currentNode.depth+1) not in explored)):
        heapq.heappush(frontier,Node.Node(currentNode.board.slideBlank((1,0)), currentNode, currentNode.depth + 1, currentNode.depth+1))
        explored.add(Node.Node(currentNode.board.slideBlank((1,0)), currentNode, currentNode.depth + 1, currentNode.depth+1))
        
    if (currentNode.board.slideBlank((-1,0)) and (Node.Node(currentNode.board.slideBlank((-1,0)), currentNode, currentNode.depth + 1, currentNode.depth+1) not in explored)):
        heapq.heappush(frontier,Node.Node(currentNode.board.slideBlank((-1,0)), currentNode, currentNode.depth + 1, currentNode.depth+1))
        explored.add(Node.Node(currentNode.board.slideBlank((-1,0)), currentNode, currentNode.depth + 1, currentNode.depth+1))
    
    

# Function to expand the frontier using aStar #
def aStarExpansion(currentNode, frontier, goalBoard, explored):
    for item in currentNode.children():
        if item not in explored:
            item.fValue = heuristic(item.board,goalBoard) + item.depth
            heapq.heappush(frontier, item)
    explored.add(currentNode)



# Function to calculate a heuristic value for the currentBoard

# The numberOfMisplacedTiles is a workable heuristic function,
# but it is not a good one.
# You need to create your own heuristic function and put it here.
# It must be a consistent and admissible heuristic function,
# otherwise our Node class will occupy too much memory and
# your code's efficiency will not meet our requirements.
def heuristic(currentBoard, goalBoard):
    return numberOfMisplacedTiles(currentBoard, goalBoard)


# Function to find the number of misplaced tiles.
# We provide this just as a workable heuristic function
# and this is just for your own practise
def numberOfMisplacedTiles(currentBoard, goalBoard):
    goalMatrix = goalBoard.matrix
    sum = 0
    for i in range(len(goalMatrix)):
        for j in range(len(goalMatrix[i])):
            if goalMatrix[i][j] == 0:
                continue
            if (i,j) != currentBoard.findElement(goalMatrix[i][j]):
                (k,l) = currentBoard.findElement(goalMatrix[i][j])
                sum += (abs(i-k) + abs(j-l))
    return sum

###########################
# Main method for testing #
###########################

def main():

    goalBoard = Board.Board([[1, 2, 3], [4, 5, 6], [7, 8, 0]])

    # test case for uninformed expansion

    board1 = Board.Board([[1, 3, 5], [4, 2, 6], [7, 8, 0]])
    frontier = []
    Node1 = Node.Node(board1, None, 0, 0)
    uninformedExpansion(Node1, frontier, goalBoard)
    assert Node.Node(board1.slideBlank((-1, 0)), Node1, 0, 0) in frontier
    assert Node.Node(board1.slideBlank((0, -1)), Node1, 0, 0) in frontier
    assert Node.Node(board1.slideBlank((1, 0)), Node1, 0, 0) not in frontier
    assert Node.Node(board1.slideBlank((0, 1)), Node1, 0, 0) not in frontier


    # test case for informed expansion
    Node1 = Node.Node(board1, None, 0, 0)
    board1_1 = board1.slideBlank((-1, 0))
    Node2 = Node.Node(board1_1, Node1, 0, 1)
    frontier = [Node2]
    explored = set([Node1])
    uniformCostExpansion(Node2, frontier, goalBoard, explored)
    assert Node.Node(board1_1.slideBlank((-1, 0)), Node2, 0, 0) in frontier
    assert Node.Node(board1_1.slideBlank((1, 0)), Node2, 0, 0) not in frontier

    # test case for BFS
    start_time1 = time.time()
    board1 = Board.Board([[1, 3, 5], [4, 2, 6], [7, 8, 0]])
    board1_result = uninformedClient(board1, 5000, goalBoard, False)
    assert board1_result is not None
    assert type(board1_result) is Node.Node
    assert board1_result.depth == 6

    # test case for UCS
    board2 = Board.Board([[1, 3, 6], [5, 7, 2], [0, 4, 8]])
    board2_result = fastSearchClient(board2, 1000, Board.Board([[1, 2, 3], [4, 5, 6], [7, 8, 0]]), False)
    assert board2_result is not None
    assert type(board2_result) is Node.Node
    assert board2_result.depth == 10

    # test case for A*
    board3 = Board.Board([[7, 3, 0], [1, 2, 6], [8, 4, 5]])
    board3_result = fastSearchClient(board3, 1000, Board.Board([[1, 2, 3], [4, 5, 6], [7, 8, 0]]), True)
    assert board3_result is not None
    assert type(board3_result) is Node.Node
    assert board3_result.depth == 20

    print("\n--- %s seconds ---\n\n" % (time.time() - start_time1))

if __name__ == "__main__":
    main()
