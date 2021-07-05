import random

n = int(input('Enter Number of Cores : '))
d1 = int(input('Enter Dimension 1 : '))
d2 = int(input('Enter Dimension 2 : '))
d3 = int(input('Enter Dimension 3 : '))
r1 = int(input('Enter Upper Bound : '))
r2 = int(input('Enter Lower Bound : '))

MatrixA = [random.choices(population=range(r2, r1+1), k=d2) for i in range(d1)]
print('\nMatrix A Created!')

MatrixB = [random.choices(population=range(r2, r1+1), k=d3) for i in range(d2)]
print('Matrix B Created!')

MatrixC = [0]*(d1*d3)

result = [[sum(a*b for a, b in zip(X_row, Y_col))
           for Y_col in zip(*MatrixB)] for X_row in MatrixA]
print('Result Matrix Calculated!')

MatrixA1 = []
for j in MatrixA:
    MatrixA1 += j

print('\nMatrix A :',MatrixA1)

MatrixB1 = []
for j in MatrixB:
    MatrixB1 += j
print('\nMatrix B :', MatrixB1)

MatrixC1 = []
for j in result:
    MatrixC1 += j
print('\nResult Matrix :', MatrixC1)

MatrixC1 = list(map(str, MatrixC1))

Total = [n, d1, d2, d3, 8, 8 + d1*d2, 8 + d1*d2 + d2*d3, 8 + d1*d2 + d2*d3 + d1*d3] + MatrixA1 + MatrixB1 + [0]
Total = list(map(str, Total))

with open('memory.txt', 'w') as f:
    for line in Total:
        f.write(line)
        f.write('\n')

with open('result_matrix.txt', 'w') as f:
    for line in MatrixC1:
        f.write(line)
        f.write('\n')
