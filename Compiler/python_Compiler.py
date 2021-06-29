try:
    matrixA = []
    matrixB = []
    memory = []

    matA = []
    matB = []
    matC = []

    N = int(input('Enter number of cores: ').strip())
    D1 = int(input('Enter the number of rows in matrix A: ').strip())
    D2 = int(input('Enter the number of columns in matrix A/ number of rows in matrixB: ').strip())
    D3 = int(input('Enter the number of columns in matrix B: ').strip())

    print("Enter the matrix A row by row:")
    for dim1 in range(D1):
        row = list(map(int, str(input()).strip().split()))
        if (len(row)) != D2:
            print("Invalid Input")
            break
        matrixA += row
        matA.append(row)

    else:
        print("Enter the matrix B row by row:")
        for dim2 in range(D2):
            row = list(map(int, str(input()).strip().split()))
            if (len(row)) != D3:
                print("Invalid Input")
                break
            matrixB += row
            matB.append(row)
        else:
            matrixC = [0]*(D1*D3)
            for i in range(D1):
                matC += [[0]*D3]
            P = 8 + D1*D2 + D2*D3 + D1*D3
            memory += [N,D1,D2,D3,8,8+D1*D2,8+D1*D2+D2*D3,P] + matrixA + matrixB + matrixC +  [0]*(N*4 + 1)

            memory_file = open("memory.txt","w")
            memory_file.writelines(["%s\n" % item for item in memory])
            memory_file.close()

            for i in range(D1):
                for j in range(D3):
                    for k in range(D2):
                        matC[i][j] += matA[i][k] * matB[k][j]

            FlatMatC = []
            for i in range(D1):
                FlatMatC += matC[i]

            result_file = open("python_result_matrix.txt","w")
            result_file.writelines(["%s\n" % item for item in FlatMatC])
            result_file.close()

            print("Matrix A:", matA)
            print("Matrix B:", matB)
            print("Result matrix", matC)
            print("Memory array:", memory)

except:
    print("Please give input in correct format")