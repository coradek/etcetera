'''
Given a list, L return the indecies (m,n) such that
sorting L[m,n] results in a fully sorted list

L= [1,2,3,7,8,9,6,10,11] --> (3,6)
L= [1,2,4,7,10,11,7,12,6,7,16,18,19] --> (4,9)
'''

# not optimized, but it works

def subsort(the_list):
    start = find_start(the_list)
    if start == "List is already sorted":
        return start
    else:
        end = find_end(the_list)
        return (start, end)

def find_start(the_list):
    max_seen = None
    start_dict = {}
    for i, ele in enumerate(the_list):
        if (max_seen is None) or (ele > max_seen):
            max_seen = ele
            start_dict[ele] = i
        if ele < max_seen:
            start = get_smallest_above(ele, start_dict)
            return start

def find_end(the_list):
    min_seen = None
    end_dict = {}
    the_list.reverse()
    for i, ele in enumerate(the_list):
        if (min_seen is None) or (ele < min_seen):
            min_seen = ele
            end_dict[ele] = i
        if ele > min_seen:
            end = get_largest_below(ele, end_dict)
            return len(the_list) - end - 1

def get_smallest_above(num,a_dict):
    min_so_far = None
    for k in a_dict.iterkeys():
        if k > num:
            if (min_so_far is None) or (k < min_so_far):
                min_so_far = k
    return a_dict[min_so_far]

def get_largest_below(num, a_dict):
    max_so_far = None
    for k in a_dict.iterkeys():
        if k < num:
            if (max_so_far is None) or (k > max_so_far):
                max_so_far = k
    return a_dict[max_so_far]

if __name__ == '__main__':
    L1 = [1,2,4,7,10,11,7,12,6,7,16,18,19]
    print 'expected: (4,9), got: ', subsort(L1)

    L2 = [1,2,3,7,8,9,6,10,11]
    print 'expected: (3,6), got: ', subsort(L2)
