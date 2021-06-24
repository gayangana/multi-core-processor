try:
    python_result = open("python_result_matrix.txt","r")
    python_result_file = list(map(int,python_result.readlines()))
    python_result.close()
    print("Python result:", python_result_file)

    processor_result = open("processor_result_matrix.txt","r")
    D1 = int(processor_result.readline().strip())
    D2 = int(processor_result.readline().strip())
    D3 = int(processor_result.readline().strip())
    processor_result_file = list(map(int,processor_result.readlines()))
    processor_result.close()
    print("processor_result_file:",processor_result_file[9+D1*D2+D2*D3:])

    if (python_result_file == processor_result_file[9+D1*D2+D2*D3:]):
        print("Matrix result is correct")
    else:
        print("Matrix result is incorrect")
except:
    print("File Error")
