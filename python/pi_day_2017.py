from __future__ import division
from random import randint
from fractions import gcd

'''
Pi can be approximated by finding the
ratio of coprime to total pairs
of randomly generated numbers

the probability that a pair of numbers is coprime
is equal to (6/pi^2)

So for
x = number_coprime / number_pairs
x ~= 6/pi^2
as number_pairs --> infinity
(and as your range of numbers --> inf)

thus:

pi ~= SQRT(6/x^2)

'''

def approx_pi(pairs=100000, ceiling=100000):
    coprime = 0

    for x in xrange(pairs):
        a,b = randint(1,ceiling), randint(1,ceiling)
        if gcd(a,b) == 1:
            coprime += 1

    return (6/(coprime/pairs))**(0.5)


def approx_pi_unreadable(pairs=10000, ceiling=10000):
    # Continuing my tradition of breaking pep-8 in order to terrify Matt . . .
    def r():
        return randint(1,ceiling)
    L = [gcd(r(), r()) == 1 for x in xrange(pairs)]
    return (6/(sum(L)/len(L)))**0.5


# TODO: build numpy version and test for speed with large pairs/ceiling
# http://stackoverflow.com/questions/15569429/numpy-gcd-function



if __name__ == '__main__':
    n = 1000000
    for x in xrange(5):
        print approx_pi(n,n)
