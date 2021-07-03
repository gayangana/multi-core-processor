import random

n  = int(input('Enter Number of Cores : '))
d1 = int(input('Enter Dimension 01 : '))
d2 = int(input('Enter Dimension 02 : '))
d3 = int(input('Enter Dimension 03 : '))
r1 = int(input('Enter Upper Bound : '))
r2 = int(input('Enter Lower Bound : '))  

MatrixA = [random.choices(population = range(r2, r1+1), k = d2) for i in range(d1)]
print('MatrixA created')

MatrixB = [random.choices(population=range(r2, r1+1), k=d3) for i in range(d2)]
print('MatrixB created')

MatrixC = [0] * (d1 * d3)

result = [[sum(a * b for a, b in zip(X_row, Y_col)) for Y_col in zip(*MatrixB)] for X_row in MatrixA]
print('Resultant Matrix Calculated')

MatrixA1 = []
for j in MatrixA: MatrixA1 += j
print(MatrixA1)

MatrixB1 = []
for j in MatrixB: MatrixB1 += j
print(MatrixB1)

MatrixC1 = []
for j in result: MatrixC1 += j
print(MatrixC1)
MatrixC1 = list(map(str,MatrixC1))

Total = [n, d1, d2, d3, 8,8 + d1 * d2, 8 + d1 * d2 + d2 * d3, 8 + d1 * d2 + d2 * d3 + d1 * d3] + MatrixA1 + MatrixB1 + MatrixC + [0]*(4*n+1)
Total = list(map(str,Total))

with open('memory.txt', 'w') as f:
    for line in Total:
        f.write(line)
        f.write('\n')

with open('python_result_matrix.txt', 'w') as f:
    for line in MatrixC1:
        f.write(line)
        f.write('\n')