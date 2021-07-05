try:
    matrixA = []
    matrixB = []
    memory = []

    matA = []
    matB = []
    matC = []

    N = int(input('Enter Number of Cores : ').strip())
    D1 = int(input('Enter Number of Rows in Matrix A : ').strip())
    D2 = int(input('Enter Number of Columns in Matrix A / Number of Rows in Matrix B : ').strip())
    D3 = int(input('Enter Number of Columns in Matrix B : ').strip())

    print('\nEnter the Matrix A Row by Row : ')
    for dim1 in range(D1):
        row = list(map(int, str(input()).strip().split()))
        if (len(row)) != D2:
            print('Invalid Input!')
            break
        matrixA += row
        matA.append(row)

    else:
        print('\nEnter the Matrix B Row by Row : ')
        for dim2 in range(D2):
            row = list(map(int, str(input()).strip().split()))
            if (len(row)) != D3:
                print('Invalid Input!')
                break
            matrixB += row
            matB.append(row)
        else:
            matrixC = [0]*(D1*D3)
            for i in range(D1):
                matC += [[0]*D3]
            P = 8 + D1*D2 + D2*D3 + D1*D3
            memory += [N, D1, D2, D3, 8, 8 + D1*D2, 8 + D1*D2+D2*D3, P] + matrixA + matrixB + [0]

            memory_file = open('memory.txt', 'w')
            memory_file.writelines(['%s\n' % item for item in memory])
            memory_file.close()

            for i in range(D1):
                for j in range(D3):
                    for k in range(D2):
                        matC[i][j] += matA[i][k] * matB[k][j]

            FlatMatC = []
            for i in range(D1):
                FlatMatC += matC[i]

            result_file = open('result_matrix.txt', 'w')
            result_file.writelines(['%s\n' % item for item in FlatMatC])
            result_file.close()

            print('\nMatrix A :', matA)
            print('\nMatrix B :', matB)
            print('\nResult Matrix :', matC)
            print('\nMemory Array :', memory)

except:
    print('Please Give the Input in Correct Format!')
