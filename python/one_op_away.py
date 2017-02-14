'''
There are 3 opperations.
Insert, Replace, Remove
check if 2 strings are exactly 1 opperation away from eachother
'''

def one_op_away(str1, str2):
    # check if identical
    if str1 == str2:
        return False
    # check for one insertion of removal
    insert_remove = check_one_shift(str1, str2)
    # check for one replacement
    replace = check_replace(str1, str2)

    return any([insert_remove, replace])

def check_one_shift(str1, str2):
    strA = min(str1, str2)
    strB = max(str1, str2)
    shift_yet = False
    i = 0
    if len(strB) - len(strA) != 1:
        return False
    for c in strA:
        if c == strB[i]:
            i +=1
        elif c != strB[i]:
            if (shift_yet == False) and c == strB[i+1]:
                shift_yet = True
                i += 2
            else:
                return False
    return True


def check_replace(str1, str2):
    if len(str1) != len(str2):
        return False
    replace_yet = False
    for i, c in enumerate(str1):
        if c != str2[i]:
            if replace_yet == False:
                replace_yet = True
            else:
                return False
    return True

if __name__ == '__main__':
    A = ('abcdefg', 'abzcdefg', True)
    B = ('abcdefg', 'abbzdefg', False)
    C = ('abcdefg', 'abzdefg', True)
    D = ('abcdefg', 'abzdefz', False)
    E = ('abcdefg', 'abbcdefg', True)
    F = ('abcdefg', 'abcdefg', False)

    for test in [A, E]:
        print test[2], one_op_away(test[0], test[1])
