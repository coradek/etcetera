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

def approx_pi(pairs, ceiling=1000):
    coprime = 0

    for x in xrange(pairs):
        a,b = randint(1,ceiling), randint(1,ceiling)
        if gcd(a,b) == 1:
            coprime += 1

    return (6/(coprime/pairs))**(0.5)


if __name__ == '__main__':
    for x in xrange(5):
        print approx_pi(1000)
