iclicker = 5
zybook = 5
labs = 25
projects = 40
midterm1 = 7.5
midterm2 = 7.5
final = 10


iclicker *= 0.95
zybook *= 0.95
projects *= 0.95
midterm1 *= 0.70
midterm2 *= 0.70
final *= 0.70


# there are 14 labs in total
lab0 = 98
lab1 = 99
lab2 = 100
lab3 = 97.5
lab4 = 70
numerator = lab0 + lab1 + lab2 + lab3 + lab4
numerator += (900 * 0.42)
lab_multiplier = (numerator) / 1400

labs *= lab_multiplier

print(lab_multiplier)

sumtests = iclicker + zybook + labs + projects + midterm1 + midterm2 + final

print(sumtests)