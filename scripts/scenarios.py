from trun_mvnt import rtmvt

import numpy as np

n = 100

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

random_sample = rtmvt(  # type: ignore
    n=n,
    Mean=Mean,
    Sigma=Sigma,
    nu=df,
    D=D,
    lower=lower,
    upper=upper
)

# np.savetxt("scenarios.csv", random_sample, delimiter=";", fmt='%f')

print("""param SCENARIOS_INCOME_PER_PRODUCT
    :           P1                              P2                              P3                              P4                              :=""")
for y, row in enumerate(random_sample, start=1):
    print(f"    {y:<4}", end='\t')
    for element in row:
        print(f"{element:<24}", end='\t')
    print()
