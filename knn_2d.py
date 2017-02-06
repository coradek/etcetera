'''
Take a list of training data (tuples): [(x1, x2, label), (...), ...]
     a list of new data to predict: [(x1, x2), ...]
     an integer K
Return k-nearest neighbors prediction for each element in the data list

assumes two dimensional data
        label is one of two classes: 0 or 1

NOTE: even choice of k may result in obnoxious error!
'''

def knn(train, data, k):
    preds = []
    for d in data:
        dists = []
        for t in train:
            a = (((t[0]-d[0])**2 + (t[1]-d[1])**2)**0.5, t[2])
            dists.append(a)
        neighbors = sorted(dists)[:k]
        label = sum(n[1] for n in neighbors)/float(k)

        if label == 0.5:
            return "Please Choose Odd K"

        label = int(round(label))
        preds.append(label)
    return preds

if __name__ == '__main__':
    print 'should predict: [1, 0]'
    data = [(1.5,1.5),(-1.5,-1.5)]
    train = [(2,2,1),(2.2,3,1),(-2,-2.5,0),(-2.5,-3,0),(3,2,1),(-3,-3,0)]
    k = 3

    print "prediction:    ", knn(train, data, k)
