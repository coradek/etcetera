from random import randint as rand
from datetime import timedelta
from datetime  import datetime

'''
Create Practice Tables for dinosaurs.sql question
'''

# TODO: could make this write the .sql file automattically

def make_dinobone_table():
    species = ['Tyrannosaurus rex', 'Triceratops', 'Pteranodon', 'Velociraptor']

    anatomy = ['rib', 'femur', 'metacarpal', 'metatarsal', 'pelvis'
              , 'skull', 'vertebra', 'humerus', 'radius', 'ulna']

    combos = [(s,a) for s in species for a in anatomy]
    entries = [(i,c[0],c[1]) for i, c in enumerate(combos)]

    print 'INSERT INTO Dino_Bones VALUES \n  {}\n;'.format('\n, '.join(str(e) for e in entries))


def site_entries():
    sites = ['Kem Kem Beds', 'Orapa', 'Seymour Island', 'Vega Island'
            , 'Cerro del Pueblo', 'Como Bluff', 'Cantwell Formation'
            , 'Ellisdale', 'Eutaw Formation', 'Hilda mega-bonebed']
    print 'INSERT INTO Sites VALUES \n  {}\n;'.format('\n, '.join(str((i,s)) for i,s in enumerate(sites)))


def rand_date():
    start = datetime.strptime('2014/1/1', '%Y/%m/%d').date()
    end = datetime.strptime('2016/12/31', '%Y/%m/%d').date()
    # datetime.strptime('1/1/2008 1:30 PM', '%m/%d/%Y %I:%M %p')
    day_range = (end - start).days
    delta = rand(0,day_range)
    return start + timedelta(days=delta)


def finds_entries():
    sites = ['Kem Kem Beds', 'Orapa', 'Seymour Island', 'Vega Island'
            , 'Cerro del Pueblo', 'Como Bluff', 'Cantwell Formation'
            , 'Ellisdale', 'Eutaw Formation', 'Hilda mega-bonebed']

    site_count = {'2014':{}, '2015':{}, '2016':{}}
    n = 400
    finds = [(i, rand(0,9), rand(0,39)
            , rand_date().strftime("%Y-%m-%d")) for i in xrange(n)]

    find_string = ["({}, {}, {}, to_date('{}', 'YYYY-MM-DD'))".format(f[0], f[1], f[2], f[3]) for f in finds]

    for f in finds:
        site = sites[f[1]]
        if f[2] > 29:
            year = f[-1][:4]
            site_count[year][site] = site_count[year].get(site, 0)+1
    # (id integer, site_id integer, bone_id integer, date date)
    #  unique       0-9             0-39                2014-2016

    print 'INSERT INTO Finds VALUES \n  {}\n;'.format('\n, '.join(str(f) for f in find_string))

    for year in site_count.iterkeys():
        print year
        desc_count = [(c,s) for s,c in site_count[year].iteritems()]
        for i in sorted(desc_count, reverse=True):
            print '\t', i



if __name__ == '__main__':

    # make_dinobone_table()
    # site_entries()
    finds_entries()
