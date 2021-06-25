d1 = int(input('Enter Dimension 01 : '))
d2 = int(input('Enter Dimension 02 : '))
d3 = int(input('Enter Dimension 03 : '))

print('Enter Matrix raw elements separated by commas')
print('Matrix A Dimension => ' + str(d1) + ' x ' + str(d2))

MatrixA = []
MatrixA1 = []

for i in range(d1):
    rw = str(input('Enter Matrix A Row Number ' + str(i + 1) + ' : '))
    rw = rw.strip(' ,').replace(' ', '')
    try:
        raw = list(map(int, rw.split(',')))
    except:
        assert False, 'Invalid Input'
    if len(raw) > d2:
        print('Taking first ' + str(d2) + ' elements')
        raw = raw[:d2]
    MatrixA += raw
    MatrixA1.append(raw)

print('Matrix B Dimension => ' + str(d2) + ' x ' + str(d3))

MatrixB = []
MatrixB1 = []

for i in range(d2):
    rw = str(input('Enter Matrix B Row Number ' + str(i + 1) + ' : '))
    rw = rw.strip(' ,').replace(' ', '')
    try:
        raw = list(map(int, rw.split(',')))
    except:
       assert False, 'Invalid Input'
    if len(raw) > d3:
        print('Taking first ' + str(d3) + ' elements')
        raw = raw[:d3]
    MatrixB += raw
    MatrixB1.append(raw)

print('Matrix A')    
for j in MatrixA1:
    print(j)
print('Matrix B')
for j in MatrixB1:
    print(j)
print('Resultant Matrix Dimensions => ' + str(d1) + ' x ' + str(d3))
print('MatrixC')
result = [[sum(a*b for a,b in zip(X_row,Y_col)) for Y_col in zip(*MatrixB1)] for X_row in MatrixA1]

MatrixC1 = []
for r in result:
    MatrixC1 += r
    print(r)
MatrixC1 = list(map(str, MatrixC1))
MatrixC = [0]* (d1*d3)

Final = [d1, d2, d3, 12, 12 + d1 * d2, 12 + d1 * d2 + d2 * d3, 0, 0, 0, 0, 0, 0] + MatrixA + MatrixB + MatrixC
L = len(Final)

with open('memory.txt', 'w') as f:
    for line in range(L):
        f.write('ram['+str(line)+ '] = ' + str(Final[line]))
        f.write('\n')

with open('matCresults.txt', 'w') as f:
    for line in MatrixC1:
        f.write(line)
        f.write('\n')
        
