'''
Thank you Matt:
https://github.com/zipfian/100-ds-problems/blob/master/100-problems.md

(Nick told me 4 stars/diamonds - online says 3)

Start with a deck with 60 cards - 52 blank, 4 stars, and 4 diamonds
Draw 5 cards.
For every diamond drawn discard the diamond and draw 3 more cards.
Repeat until your hand contains no diamonds
What is the probability of having at least one star in your hand at the end?
'''

def simulate_game(reps):
    '''
    just play the game above ...
    many many times
    '''
    stars_in_hand = 0
    for i in xrange(reps):
        hand = []
        # do the thing a bunch of times
        # add 1 to stars_in_hand if stars_in_hand
        pass
    return stars_in_hand / float(reps)

def generalized_game():
    '''
    simulate game with any number of cards, stars, and diamonds
    '''
    pass

def calc_proba():
    '''
    might be fun to build a recursive func
     to calculate the actual probability
    '''
    pass

def _calc_proba(remaining_cards, remaining_diamonds, num_diamonds):
    # internal recursion method
    pass
