'''
Create Practice Tables for dinosaurs.sql question
'''

# TODO: could make this write the file automattically

def make_dinobone_table():
    species = ['Tyrannosaurus rex', 'Triceratops', 'Pteranodon', 'Velociraptor']

    anatomy = ['rib', 'femur', 'metacarpal', 'metatarsal', 'pelvis'
              , 'skull', 'vertebra', 'humerus', 'radius', 'ulna']

    combos = [(s,a) for s in species for a in anatomy]
    entries = [(i,c[0],c[1]) for i, c in enumerate(combos)]

    print 'INSERT INTO Dino_Bones {}\n;'.format('\n, '.join(str(e) for e in entries))

def site_entries():
    sites = ['Kem Kem Beds', 'Orapa', 'Seymour Island', 'Vega Island'
            , 'Cerro del Pueblo', 'Como Bluff', 'Cantwell Formation'
            , 'Ellisdale', 'Eutaw Formation', 'Hilda mega-bonebed']

    print 'INSERT INTO Sites {}\n;'.format('\n, '.join(str((i,s)) for i,s in enumerate(sites)))


def finds_entries():
    site_count = {}
    pass


if __name__ == '__main__':

    # make_dinobone_table()
    site_entries()
