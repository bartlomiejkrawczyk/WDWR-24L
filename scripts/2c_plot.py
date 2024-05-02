# pyright: basic
import numpy as np
import matplotlib as mpl
from matplotlib import pyplot as plt
from typing import Tuple, List

SCENARIO_INCOME = [
    ("S1", [0, 1, 50, 100]),
    ("S2", [0, 30, 50, 80]),
    ("S3", [0, 12, 110, 140]),
]


def cdf(x: List[float], *args, **kwargs):
    x, y = sorted(x), list(np.arange(1, len(x)+1) / len(x))
    x.insert(0, 0)
    y.insert(0, 0)
    return plt.step(x, y, where='post', *args, **kwargs)


if __name__ == '__main__':
    fig, ax = plt.subplots()
    for scenario in SCENARIO_INCOME:
        plot = cdf(scenario[1], label=scenario[0])
    plt.xlabel("Zysk")
    plt.ylabel("Dystrybuanta")
    plt.legend()
    plt.show()
