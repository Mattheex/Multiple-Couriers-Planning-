from os import getcwd

name = "inst"
for k in range(1, 22):
    if k < 10:
        number = "0" + str(k)
    else:
        number = str(k)

    new_file = open(getcwd() + "\\instancesDzn\\" + name +number+ ".dzn", 'w', encoding="utf-8")
    with open(name +number+ ".dat", encoding="utf-8") as f:
        for i, line in enumerate(f):
            line = line.replace("\n", "")
            if i == 0:
                new_file.write("m = {};\n".format(line))
            elif i == 1:
                new_file.write("n = {};\n".format(line))
            elif i == 2:
                new_file.write("l = [{}];\n".format(line.replace(" ", ",")))
            elif i == 3:
                new_file.write("s = [{}];\n".format(line.replace(" ", ",")))
            elif i == 4:
                new_file.write("D = [|{}\n".format(line.replace(" ", ",")))
            else:
                new_file.write("|{}\n".format(line.replace(" ", ",")))

        new_file.write("|];")

    new_file.close()
    f.close()
