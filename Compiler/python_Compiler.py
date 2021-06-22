try:
    matrixA = []
    matrixB = []
    memory = []

    D1,DA2 = map(int,input('Enter the number of rows and columns for matrix A: ').strip().split(' '))
    print("Enter the matrix A row by row:")
    for dim1 in range(D1):
        row = input().strip().split(' ')
        if (len(row)) != DA2:
            print("Invalid Input")
            break
        matrixA += map(int,row)
    else:
        DB2,D3 = map(int,input('Enter the number of rows and columns for matrix B: ').strip().split(' '))
        print("Enter the matrix B row by row:")
        for dim2 in range(DB2):
            row = input().strip().split(' ')
            if (len(row)) != D3:
                print("Invalid Input")
                break
            matrixB += map(int,row)
        else:
            if (DA2 != DB2 ):
                print("Cannot do multiplication")
            elif (invalid == True):
                print("Invalid matrix input")
            else:
                D2 = DA2
                matrixC = [0]*(D1*D3)
                memory += [D1,DA2,D3,12,12+D1*D2,12+D1*D2+D2*D3,0,0,0,0,0,0] + matrixA + matrixB + matrixC
                print(memory)
                memory_file = open("memory.txt","w")
                memory_file.writelines(["%s\n" % item for item in memory])
                memory_file.close()
except:
    print("Please give input in correct format")

