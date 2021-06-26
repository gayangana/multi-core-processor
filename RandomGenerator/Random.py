import random

d1 = int(input('Enter Dimension 01 : '))
d2 = int(input('Enter Dimension 02 : '))
d3 = int(input('Enter Dimension 03 : '))


MatrixA = [random.choices(population = range(0, 1001), k = d2) for i in range(d1)]
print('MatrixA created')

MatrixB = [random.choices(population=range(0, 1001), k=d3) for i in range(d2)]
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

Total = [d1, d2, d3, 12 + d1 * d2, 12 + d1 * d2 + d2 * d3, 12 + d1 * d2 + d2 * d3 + d1 * d3, 0, 0, 0, 0, 0, 0] + MatrixA1 + MatrixB1 + MatrixC
Total = list(map(str,Total))

with open('RandomGenerator/memory_input.txt', 'w') as f:
    for line in Total:
        f.write(line)
        f.write('\n')

with open('RandomGenerator/python_matC.txt', 'w') as f:
    for line in MatrixC1:
        f.write(line)
        f.write('\n')