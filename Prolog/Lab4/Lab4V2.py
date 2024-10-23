import numpy as np
from itertools import permutations
import random
import time

N = 4
M = 24
A = 1
B = 13


def gen_perms():
    randnums = [8,8,3,3]
    #for i in range(N):
        #randnums.append(random.randint(A, B))

    perms = list(permutations(randnums))
    return perms

def get_sols(perm, path, solutions, single_sol=False):
    if single_sol:
        if len(solutions) > 0:
            return
    if len(perm) == 1:
        if abs(perm[0] - M) < 0.001:
            solutions.append(path)
            return
        else:
            return
    for i in range(0, len(perm) - 1):
        temp1 = perm.copy()
        temp2 = perm.copy()
        temp3 = perm.copy()
        temp4 = perm.copy()

        x = perm[i]
        y = perm[i + 1]

        temp1.pop(i + 1)
        temp1.pop(i)

        temp2.pop(i + 1)
        temp2.pop(i)

        temp3.pop(i + 1)
        temp3.pop(i)

        temp4.pop(i + 1)
        temp4.pop(i)

        temp1.insert(i, x + y)
        temp2.insert(i, x - y)
        temp4.insert(i, x * y)

        p1 = path + "(" + str(x) + " + " + str(y) + ") ; "
        p2 = path + "(" + str(x) + " - " + str(y) + ") ; "
        p4 = path + "(" + str(x) + " * " + str(y) + ") ; "

        get_sols(temp1, p1, solutions, single_sol)
        get_sols(temp2, p2, solutions, single_sol)
        get_sols(temp4, p4, solutions, single_sol)

        try:
            temp3.insert(i, x // y)
            p3 = path + "(" + str(x) + " / " + str(y) + ") ; "
            get_sols(temp3, p3, solutions)
        except ZeroDivisionError:
            pass

if __name__ == "__main__":
    sols = []
    single_sol = []
    perms = gen_perms()

    single_t0 = time.time()
    for perm in perms:
        get_sols(list(perm), "", single_sol, single_sol=True)
    single_t1 = time.time()


    t0 = time.time()
    for perm in perms:
        get_sols(list(perm), "", sols)
    t1 = time.time()

    print("Numbers: ", perms[0])
    print()

    if(len(sols) == 0):
        print("No solutions")
    else:
        print("Time to find first: ", single_t1 - single_t0)
        print("Soloution: ", single_sol[0])

        print()
        print()

        print("Time to find all is: ", t1 - t0)
        print()
        sols = set(sols)
        for sol in sols:
            print(sol)