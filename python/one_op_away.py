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
    ins_rem = check_one_shift(str1, str2)
    # check for one replacement
    repl = check_replace(str1, str2)

    return any([ins_rem, repl])

def check_one_shift(str1, str2):
    strA = min(str1, str2)
    strB = max(str1, str2)
    if len(strB) - len(strA) != 1:
        return False
    shift_yet = False
    i = 0
    for c in strA:
        if c != strB[i]:
            if shift_yet == False:
                shift_yet = True
                i += 1
                if c != strB[i]:
                    return False
            if shift_yet == True:
                return False
            i += 1
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

    for test in [A, B, C, D, E, F]:
        print test[2], one_op_away(test[0], test[1])
