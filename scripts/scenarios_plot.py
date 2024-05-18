from trun_mvnt import rtmvt
from matplotlib import pyplot as plt

import numpy as np

N = range(1, 101)

Mean = np.array([9, 8, 7, 6])
Sigma = np.array([
    [16, -2, -1, -3],
    [-2, 9, -4, -1],
    [-1, -4, 4, 1],
    [-3, -1, 1, 1]
])
df = 4
D = np.diag(np.ones(4))
lower = np.array([5, 5, 5, 5])
upper = np.array([12, 12, 12, 12])

x: list[float] = []
y_1: list[float] = []
y_2: list[float] = []
y_3: list[float] = []
y_4: list[float] = []

for n in N:
    random_sample = rtmvt(  # type: ignore
        n=n,
        Mean=Mean,
        Sigma=Sigma,
        nu=df,
        D=D,
        lower=lower,
        upper=upper
    )
    x.append(n)
    y_1.append(np.average(random_sample[:, 0]))
    y_2.append(np.average(random_sample[:, 1]))
    y_3.append(np.average(random_sample[:, 2]))
    y_4.append(np.average(random_sample[:, 3]))

plt.plot(x, y_1, label="E(R_1)")
plt.plot(x, y_2, label="E(R_2)")
plt.plot(x, y_3, label="E(R_3)")
plt.plot(x, y_4, label="E(R_4)")

plt.xlabel("Ilość scenariuszy")
plt.ylabel("Średnia ze scenariuszy")
plt.legend()
plt.grid(True)
plt.show()
