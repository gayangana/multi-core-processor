result_file = open("result_matrix.txt", "r")
result = list(map(int, result_file.readlines()))
result_file.close()

print("Result :", result)

out_file = open("out.txt", "r")
out_file.readline().strip()

N = int(out_file.readline().strip())
D1 = int(out_file.readline().strip())
D2 = int(out_file.readline().strip())
D3 = int(out_file.readline().strip())

out = out_file.readlines()
out_matrix = out[4 + D1*D2+D2*D3 : 4 + D1*D2+D2*D3+D1*D3]
out_matrix = list(map(int, out_matrix))
out_file.close()

print("\nProcessor Result :", out_matrix)

if (result == out_matrix):
    print("\nMatrix Output is Correct!")
else:
    print("\nMatrix Output is Incorrect!")
