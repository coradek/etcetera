'''
Given a starting value and set of coins
determine how many ways there are to make change for this value
'''


def count_the_ways(value, coin_set):
    c = _make_change(value, coin_set, 0)
    return c


def _make_change(val, coins, c):

    if val == 0:
        c += 1

    elif (len(coins) == 1) and (val % coins[0] == 0):
        c += 1

    else:
        for x in xrange(0, (val // coins[0])+1):
            nu_val = val - (x * coins[0])
            c = _make_change(nu_val, coins[1:], c)

    return c


if __name__ == '__main__':
    usa = [100, 50, 25, 10, 5, 1]

    print 'value: 10,   ways to make change: ', count_the_ways(10, usa)
    print 'value: 20,   ways to make change: ', count_the_ways(20, usa)
    print 'value: 158,  ways to make change: ', count_the_ways(158, usa)
    print 'value: 1001, ways to make change: ', count_the_ways(1001, usa)
