import os.path

directory = os.path.abspath(os.getcwd())
result_file = open(os.path.join(directory, "results3.txt"), 'r')

lines = result_file.read().split('\n')

index = 0
set_of_index_accu_own = dict()
set_of_index_accu = dict()

for line in lines[:-1] :
    line = line.split("|")
    #line = line[-1]
    set_of_index_accu_own[index] = line[-1]
    set_of_index_accu[index] = line[-3]
    index = index + 1


maximum_index = 0
for i in set_of_index_accu_own.keys():
    if(set_of_index_accu_own[i] > set_of_index_accu_own[maximum_index]):
        maximum_index = i

max_index = 0
for i in set_of_index_accu.keys():
    if(set_of_index_accu[i]>set_of_index_accu[max_index]):
        max_index = i

print("The case that has the maximum accuracy for own data is :", lines[maximum_index])
print("The case that has the maximum accuracy for validation data is :", lines[max_index])