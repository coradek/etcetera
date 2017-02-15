'''
each player (0 - n) has a card with a number on it
ex: [3,5,7,4]
game: start w/ person 0 take that many steps (ex: 3),
drop the person you land on (ex: person 3 [card = 4]),
take the number of steps according to the card
of the NEXT person still in the game (ex: 3 steps, person 0 again)
repeat until only the winner is left
return the winner

Uber interview question
'''

def play_game(player_list):
    player_cards = [(n,i) for i, n in enumerate(player_list)]
    return play_round(0, player_cards)


def play_round(start, player_cards):
    lng = len(player_cards)
    if lng == 1:
        # print player_cards[0][1]
        return player_cards[0][1]
    else:
        steps = player_cards[start][0]
        land_on = (start + steps) % lng
        next_start = land_on % (lng-1)  # % etc incase land at end of list
        player_cards.pop(land_on)       # eliminate player
        new_list = player_cards         # for clarity
        return play_round(next_start, new_list)


if __name__ == '__main__':
    # print play_game([2,7,3,5,1,8])
    print "winner: ", play_game([9,4,7,2,6,4]), ", should be: 0"
    print "winner: ", play_game([2,7,3,5,1,8]), ", should be: 1"
    print "winner: ", play_game([5,5,5,5,5,5]), ", should be: 3"
