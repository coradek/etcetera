import numpy as np

'''
Given Matrix M of random numers, find the maximum possible sum attainable by walking M adding the values of each location visited. A walk starts at any point in the left most column and moves only right, up, or down never visiting any location more than once. It ends as soon as it enters the right-most column.
'''

def maxwalk(arr):
    arr = np.array(arr)
    rows = arr.shape[0]
    cols = arr.shape[1]
    old_max = [0]*rows
    new_max = [0]*rows

    for j in xrange(cols-1):
        col = arr[:,j]
        # print "column: ", col
        for k in xrange(rows):
            # old_max[i] : max path to point of entry, col[i]
            # sum(col[min(i,k):max(i,k)+1]) : total accumulated in col
            #                     entering at col[i] leaving at col[k]
            # max( . . .) : best path that leaves at col[k]
            new_max[k] = max(sum(col[min(i,k):max(i,k)+1])+old_max[i] for i in xrange(rows))
        # print "new max: ", new_max
        old_max = new_max[:]

    # add final col value to max path entering at that value --> return max
    return max([new_max[i]+arr[:,-1][i] for i in xrange(rows)])


# WARNING: the code below is not pep-8 compliant!!!
# (to annoy matt [who provided this problem],
# I am curious to see how gross of a list comprehension I can make)
def so_so_gross(arr):
    arr = np.array(arr)
    old_max = [0]*arr.shape[0]
    new_max = [None]*arr.shape[0]
    for j in xrange(arr.shape[1]-1):
        new_max = [max(sum(arr[:,j][min(i,k):max(i,k)+1])+old_max[i] for i in xrange(arr.shape[0])) for k in xrange(arr.shape[0])]
        old_max = new_max[:]
    return max([new_max[i]+arr[:,-1][i] for i in xrange(arr.shape[0])])


# max(sum(L[min(i,j):max(i,j)+1])+old_max[i] for i in xrange(len(L)))
# arr = np.random.randint(-10,10, size=(6,6))


if __name__ == '__main__':
    # should be 527
    A = [[-1000, -1000, -1000, 30, 73],
         [-1000, -1000, -1000, 62, -1000],
         [-1000, 25, 72, 82, -1000],
         [57, -18, 92, 52, -1000]]

    # should be 527
    B = [[-9, -93, -7, 30, 73],
         [-77, -49, 1, 62, 79],
         [-27, 25, 72, 82, 0],
         [57, -18, 92, 52, -63]]

    # should be 1848
    C = [[-10, -97, -67, 42, -12, -49, 96, 79, -66, -8],
         [-15, 83, 58, 4, -40, -64, -83, 49, -50, 1],
         [59, 51, 76, -48, 90, 56, -35, -22, -96, -60],
         [-100, 61, 56, -35, 3, 26, 83, 64, 83, 4],
         [-44, 11, 82, -67, -46, 66, 94, -51, -100, 42],
         [99, 53, 82, 58, 18, 62, -32, -90, 63, -64],
         [44, -3, -48, -61, 59, 88, -36, 6, -55, 18],
         [68, -31, -18, 22, -94, 4, 55, -96, 47, 20],
         [47, 70, 70, 61, 58, -11, 7, -88, -71, -80],
         [4, -81, 6, -1, 73, -71, 54, 3, -13, -14]]

    print maxwalk(A), ' (527)'
    print maxwalk(B), ' (527)'
    print maxwalk(C), ' (1848)'

    # print so_so_gross(A)
