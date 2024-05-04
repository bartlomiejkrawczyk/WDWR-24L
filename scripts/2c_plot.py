# pyright: basic
import numpy as np
import matplotlib as mpl
from matplotlib import pyplot as plt
from typing import Tuple, List

SCENARIO_INCOME = [
    ("S1", [
        4614.949032, 4748.404226, 4774.270236, 5061.020761, 5167.406255, 5335.497670, 4682.377630,
        4987.766206, 4971.993126, 5278.200835, 4393.113854, 5165.202741, 4517.806499, 5111.313280,
        4190.861099, 5060.695630, 5997.560658, 5183.597074, 5354.229545, 5001.215341, 5082.329803,
        5124.315069, 5205.057755, 4974.818955, 4604.183914, 4730.100912, 4992.205924, 5367.409004,
        4519.149264, 5092.414810, 5017.525723, 5381.513072, 4994.865701, 4746.989320, 5039.278911,
        4752.952247, 4878.600868, 4723.090960, 4860.017964, 4699.478184, 5306.414768, 4918.721614,
        5016.404721, 4649.751852, 4870.978285, 6003.405680, 4749.280413, 4924.903401, 5092.191901,
        5214.368719, 5148.216590, 5000.546536, 5463.637060, 4758.979764, 5105.613904, 5423.366574,
        5151.231030, 4694.791731, 4747.304250, 4723.886626, 4788.893876, 5041.166168, 5270.221770,
        4872.141111, 5077.449691, 5485.531586, 4988.470271, 4853.508878, 5416.555527, 5617.656749,
        4782.817032, 4730.697055, 4674.044055, 5283.283974, 5088.964313, 4740.267052, 5400.944527,
        4789.839962, 5198.296904, 4879.226823, 4842.606856, 4997.532730, 4895.331446, 4546.384949,
        5518.750998, 5087.219961, 4945.047118, 5390.146613, 4880.693473, 4941.652298, 5047.593197,
        4606.547875, 4817.342293, 4748.378145, 5153.244894, 4892.389387, 5372.387905, 4817.234762,
        4928.822303, 5256.133587,
    ]),
    ("S2", [
        10632.098112, 11060.560398, 10886.933169, 11445.788217, 11963.926916, 12149.885155, 10777.527265,
        11363.476333, 11756.475156, 11261.882389, 10062.682580, 11271.468187, 10577.959918, 11762.808480,
        9450.665589, 11626.197466, 14127.936468, 12241.447630, 11983.015356, 10853.690133, 11091.057947,
        11855.725987, 11469.328508, 11769.423288, 10274.064754, 10830.923943, 10945.320254, 12586.780390,
        9594.322008, 11610.400369, 11436.098124, 13428.564997, 11569.560399, 10826.234256, 11412.961275,
        10706.263237, 11595.448355, 10821.289318, 11451.182141, 12149.206183, 12085.383249, 11717.626320,
        12266.893682, 10376.952814, 11098.417429, 13189.357027, 10780.704211, 10912.375319, 11943.236697,
        11785.343577, 11802.438890, 10855.504415, 12945.983374, 10887.057936, 12498.399386, 11853.838444,
        11246.748045, 10449.229701, 10826.716190, 10663.953376, 12285.922696, 11540.437846, 11899.819510,
        10907.422317, 11016.698147, 12518.324611, 10754.342452, 11573.703743, 12191.568210, 13604.678394,
        10746.759288, 10406.268671, 11223.699166, 12450.948500, 10617.492438, 10564.410819, 12608.756475,
        10501.918131, 11714.253014, 11907.104913, 10652.330597, 11067.697535, 11847.017673, 10293.451605,
        12375.177753, 12175.680679, 11593.099640, 12786.267990, 10853.013125, 11448.186936, 11851.651971,
        10773.173746, 11641.318721, 10379.740413, 12001.888197, 10642.892122, 11559.454345, 11028.319310,
        11621.953120, 12718.545171,
    ]),
    ("S3", [
        10628.282444, 11202.745340, 10996.192644, 11373.674947, 12356.348413, 11812.328991, 11217.002341,
        11325.495828, 12113.406543, 11700.458589, 9831.050028, 11020.230596, 10764.136177, 12067.108849,
        9394.254090, 11504.078192, 14251.135065, 12285.861526, 11969.717601, 11024.529981, 10943.880342,
        11731.728019, 11260.205241, 11992.095676, 10286.349336, 11351.045559, 11077.880789, 12838.640095,
        9796.014499, 11910.658068, 11414.808724, 13384.390596, 11939.886698, 10397.969290, 11867.591856,
        10640.199409, 11958.719130, 11112.897412, 11635.237147, 12268.594505, 11904.957893, 11731.303881,
        12154.726820, 10241.864561, 11384.305369, 13686.202964, 10598.219925, 10739.409515, 11914.650550,
        11591.042513, 12129.392316, 10490.175254, 12886.601883, 10894.797278, 12653.101701, 11775.358829,
        11032.958511, 10066.903825, 11177.805890, 10876.650907, 12394.386229, 11510.897462, 11992.292910,
        11477.498746, 10780.428960, 12926.141141, 10360.835016, 11267.410244, 12595.736721, 13852.205325,
        11123.560184, 10398.493640, 11543.426242, 12955.707181, 10635.032466, 10686.462442, 12783.062635,
        10360.445656, 11881.950544, 12096.971677, 11034.643512, 11074.718047, 12501.976413, 10471.830890,
        12412.602138, 12616.051771, 11744.407535, 13387.603499, 10551.927914, 11551.825806, 11955.886242,
        11208.134839, 11628.253442, 10026.772243, 12390.483087, 10741.114607, 11759.140239, 11289.317053,
        11633.015674, 12822.176667
    ]),
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
    plt.grid(True)
    plt.show()
