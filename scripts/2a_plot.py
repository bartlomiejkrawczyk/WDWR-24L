# pyright: basic
from matplotlib import pyplot as plt
from typing import Tuple, List

RESULT = [
    (1.0, 2.0)
]


def plot_income_risk(points: List[Tuple[float, float]]) -> None:
    x_values = [point[1] for point in points]
    y_values = [point[0] for point in points]
    plt.scatter(x_values, y_values)
    plt.xlabel("Ryzyko")
    plt.ylabel("Zysk")
    plt.title("Obraz zbioru rozwiązań efektywnych w przestrzeni ryzyko-zysk")
    plt.grid(True)
    plt.show()


if __name__ == '__main__':
    plot_income_risk(RESULT)
