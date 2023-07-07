import json
import subprocess
from math import floor
from os import getcwd

limit_time = 5
nb_instances = 10

path_model = getcwd() + "\\clean.mzn"
data_path = getcwd() + "\\Instances\\instancesDzn\\inst"
path_res = getcwd() + "\\res\\CP\\"

data_names = [("0{}".format(num)) if num < 10 else num for num in range(1, nb_instances + 1)]
solvers = ["gecode", "chuffed"]
out = {}

for data_name in data_names:
    for solver in solvers:
        out[solver] = {}
        result = subprocess.run(
            ['minizinc', '--solver', solver,
             '--output-mode', 'json',
             '--output-time',
             '--output-objective',
             '-i',
             path_model,
             data_path + data_name + ".dzn",
             '--json-stream',
             '--time-limit', str(limit_time * 60 * 1000)], stdout=subprocess.PIPE)

        result = result.stdout.decode('utf8')
        # print(result)
        result = '[' + ','.join(result.splitlines()) + ']'
        data = json.loads(result)
        status = {}
        for d in data:
            if d["type"] == "status":
                status = d

        if status == {}:
            out[solver]["time"] = limit_time * 60
            out[solver]["optimal"] = False
            for d in data:
                if d["type"] == "solution":
                    status = d
            out[solver]["obj"] = status["output"]["json"]["_objective"]
        else:
            out[solver]["time"] = floor(status["time"] / 1000)
            if status["status"] == 'OPTIMAL_SOLUTION':
                out[solver]["optimal"] = True
                out[solver]["obj"] = data[0]["output"]["json"]["_objective"]
            else:
                out[solver]["optimal"] = False

    with open(path_res + data_name + ".txt", 'w') as f:
        json.dump(out, f, ensure_ascii=False, indent=4)

    print("{} : {}".format(data_name, out))
