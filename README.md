---
title: "Wspomaganie decyzji w warunkach ryzyka"
author: Bartłomiej Krawczyk, 310774
geometry: margin=2cm
header-includes:
    - \usepackage{float}
    - \floatplacement{figure}{H}
    - \renewcommand{\figurename}{Rysunek}
---

## Zadanie

#### Rozważamy następujące zagadnienie planowania produkcji:

Przedsiębiorstwo wytwarza 4 produkty $P_1, P_2, P_3, P_4$ na następujących maszynach: 

- 4 szlifierkach,
- 2 wiertarkach pionowych, 
- 3 wiertarkach poziomych, 
- 1 frezarce 
- 1 tokarce. 

Wymagane czasy produkcji 1 sztuki produktu (w godzinach) w danym procesie obróbki zostały przedstawione w poniższej tabeli:

proces            | P1   | P2   | P3   | P4
------------------|------|------|------|-----
Szlifowanie       | 0.4  | 0.6  | -    | -
Wiercenie pionowe | 0.2  | 0.1  | -    | 0.6
Wiercenie poziome | 0.1  | -    | 0.7  | -
Frezowanie        | 0.06 | 0.04 | -    | 0.05
Toczenie          | -    | 0.05 | 0.02 | -

Dochody ze sprzedaży produktów (w zł/sztukę) modelują składowe wektora losowego $R = (R_1, R_2, R_3, R_4)^T$ . Wektor losowy $R$ opisuje 4-wymiarowy rozkład t-Studenta z 4 stopniami swobody, którego wartości składowych zostały zawężone do przedziału $[5; 12]$. Parametry $\mu$ oraz $\Sigma$ niezawężonego rozkładu t-Studenta są następujące:

$$
\mu = 
    \begin{bmatrix}
        9 \\
        8 \\
        7 \\
        6
    \end{bmatrix}
$$
$$
\Sigma = 
    \begin{bmatrix}
        16 & -2 & -1 & -3 \\
        -2 &  9 & -4 & -1 \\
        -1 & -4 &  4 &  1 \\
        -3 & -1 &  1 &  1
    \end{bmatrix}
$$

Istnieją ograniczenia rynkowe na liczbę sprzedawanych produktów w danym miesiącu:

miesiąc | P1  | P2  | P3  | P4
--------|-----|-----|-----|----
Styczeń | 200 | 0   | 100 | 200
Luty    | 300 | 100 | 200 | 200
Marzec  | 0   | 300 | 100 | 200

Jeżeli w danym miesiącu jest sprzedawany produkt $P_1$ lub $P_2$, to musi być również sprzedawany produkt $P_4$ w liczbie sztuk nie mniejszej niż suma sprzedawanych produktów $P_1$ i $P_2$.

Istnieje możliwość składowania do 200 sztuk każdego produktu w danym czasie w cenie
1 zł/sztukę za miesiąc. Aktualnie firma nie posiada żadnych zapasów, ale jest pożądane mieć po 50 sztuk każdego produktu pod koniec marca.

Przedsiębiorstwo pracuje 6 dni w tygodniu w systemie dwóch zmian. Każda zmiana trwa 8 godzin. Można założyć, że każdy miesiąc składa się z 24 dni roboczych.

---

1. Zaproponować jednokryterialny model wyboru w warunkach ryzyka z wartością średnią jako miarą zysku. Wyznaczyć rozwiązanie optymalne.

2. Jako rozszerzenie powyższego zaproponować dwukryterialny model zysku i ryzyka z wartością średnią jako miarą zysku i odchyleniem przeciętnym jako miarą ryzyka. Dla decyzji $x \in Q$ odchylenie przeciętne jest definiowane jako $\delta(x) = \sum_{t=1}^{T}|\mu(x)-r_t(x)|p_t$, gdzie $\mu(x)$ oznacza wartość średnią, $r_t(x)$ realizację dla scenariusza $t$, $p_t$ prawdopodobieństwo scenariusza $t$.
    - Wyznaczyć obraz zbioru rozwiązań efektywnych w przestrzeni ryzyko–zysk.
    - Wskazać rozwiązania efektywne minimalnego ryzyka i maksymalnego zysku. Jakie odpowiadają im wartości w przestrzeni ryzyko–zysk?
    - Wybrać trzy dowolne rozwiązania efektywne. Sprawdzić czy zachodzi pomiędzy nimi relacja dominacji stochastycznej pierwszego rzędu. Wyniki skomentować, odnieść do ogólnego przypadku.

\newpage

# Jednokryterialny model wyboru w warunkach ryzyka z wartością średnią jako miarą zysku

## Analityczne sformułowanie modelu

Model jednokryterialny ma za zadanie opisać proces produkcyjny przedsiębiorstwa. Pozwoli on na optymalizację zysków z produkcji, zarządzanie sprzedażą oraz efektywne magazynowanie produktów.

Dochody ze sprzedaży produktów modelują składowe wektora losowego $R$. W przypadku jednokryterialnego modelu wyboru w warunkach ryzyka bazującym na maksymalizacji wartości oczekiwanej zysku możemy przyjąć oczekiwane dochody ze sprzedaży poszczególnych produktów jako oczekiwane wartości wektora $R$.

W przypadku funkcji liniowej (jaką jest suma) wartość oczekiwana sumy jest równa sumie wartości oczekiwanych. Pozwala to na wyliczenie całkowitego zysku jako sumę oczekiwanych wartości zysków ze sprzedaży produktów w czasie pomniejszoną o sumaryczne oczekiwane koszty magazynowania produktów.

<!-- TODO -->
<!-- Wskazanie i uzasadnienie przyjętych założeń. -->
<!-- Wskazanie podstaw teoretycznych. -->

### Wartość oczekiwana zawężonego rozkładu t-Studenta wektora losowego $R$

Zmienna losowa $R$ ma niestandardowy rozkład t-Studenta z 4 stopniami swobody zawężony do przedziału $[5; 12]$. 
Rozkład t-Studenta jest ciągły, więc wartość oczekiwana na przedziale domkniętym jest taka sama jak na przedziale otwartym.
Wartości oczekiwane wektora $R$ zostały policzone ze wzoru:

$$
E(R) = \mu + \sigma \frac{\Gamma((v-1)/2)((v+a^2)^{-(v-1)/2}-(v+b^2)^{-(v-1)/2})v^{v/2}}{2(F_v(b)-F_v(a))\Gamma(v/2)\Gamma(1/2)}
dla\ v > 1
$$

gdzie:

- $\Gamma(.)$ - funkcja gamma Eulera,
- $\mu$ - wartość oczekiwana niezawężonego rozkładu t-Studenta:

$$
\mu = 
    \begin{bmatrix}
        9 \\
        8 \\
        7 \\
        6
    \end{bmatrix}
$$

- $\Sigma$ - macierz kowariancji niezawężonego rozkładu t-Studenta:

$$
\Sigma = 
    \begin{bmatrix}
        16 & -2 & -1 & -3 \\
        -2 &  9 & -4 & -1 \\
        -1 & -4 &  4 &  1 \\
        -3 & -1 &  1 &  1
    \end{bmatrix}
$$

- $\alpha = 5$ - lewy kraniec przedziału,
- $\beta = 12$ - prawy kraniec przedziału,

- $R_i$ - rozkłady poszczególnych składowych wektora $R$:

$$
R_1 \sim Tt_{(5;12)}(9, 16; 4)
$$
$$
R_2 \sim Tt_{(5;12)}(8, 9; 4)
$$
$$
R_3 \sim Tt_{(5;12)}(7, 4; 4)
$$
$$
R_4 \sim Tt_{(5;12)}(6, 1; 4)
$$

- $a = \frac{\alpha - \mu}{\sigma},\ b = \frac{\beta - \mu}{\sigma}$

\newpage

Wyliczona wartość oczekiwana rozkładu wartości po podstawieniu do wzoru:

$$
E(R_1) = 8.6274568376001
$$
$$
E(R_2) = 8.304864144322744
$$
$$
E(R_3) = 7.605077266035032
$$
$$
E(R_4) = 6.421595377441505
$$

Ostatecznie wychodzi, że oczekiwane dochody ze sprzedaży poszczególnych produktów wynoszą odpowiednio:

produkt | oczekiwany dochód ze sprzedaży
--------|-------------------------------
P1      | 8.6274568376001 zł/sztukę
P2      | 8.304864144322744 zł/sztukę
P3      | 7.605077266035032 zł/sztukę
P4      | 6.421595377441505 zł/sztukę

\newpage

## Specyfikacja problemu decyzyjnego

<!-- Specyfikacja problemu decyzyjnego z dookreśleniem wszystkich elementów. -->
<!-- Określenie zmiennych decyzyjnych, ograniczeń i funkcji oceny. -->

Przyjęta konwencja:

- UPPER_CASE - nazewnictwo zbiorów i stałych parametrów,
- snake_case - nazewnictwo zmiennych decyzyjnych,
- pojedyncze litery - nazewnictwo poszczególnych elementów należących do zbioru.


### Dostępne zbiory

- $PRODUCTS = \{P_1, P_2, P_3, P_4\}$ - zbiór produktów,
- $PROCESSES$ - zbiór procesów,
$$
PROCESSES = \{szlifowanie, wiercenie\_pionowe, wiercenie\_poziome, frezowanie, toczenie\}
$$

- $MONTHS = \{styczeń, luty, marzec\}$ - zbiór dostępnych miesięcy,
- $MONTH\_PREDECESSORS = \{(grudzień, styczeń), (styczeń, luty), (luty, marzec)\}$ - zbiór miesięcy oraz ich poprzedników.

### Parametry

- $HOURS\_IN\_A\_SHIFT = 8$ - zmiany trwają po 8h,
- $NUMBER\_OF\_SHIFTS = 2$ - przedsiębiorstwo pracuje w systemie dwóch zmian,
- $WORKING\_DAYS\_IN\_A\_MONTH = 24$ - każdy miesiąc składa się z 24 dni roboczych,
- $WORKING\_HOURS\_IN\_A\_MONTH = 384$ - całkowita liczba przepracowanych godzin w miesiącu,
$$
WORKING\_HOURS\_IN\_A\_MONTH = 
$$
$$
HOURS\_IN\_A\_SHIFT * NUMBER\_OF\_SHIFTS * WORKING\_DAYS\_IN\_A\_MONTH
$$

- $PRODUCT\_STORAGE\_LIMIT = 200$ - przedsiębiorstwo ma możliwość składowania do 200 sztuk każdego produktu,
- $MONTHLY\_PRODUCT\_STORAGE\_COST = 1$ - cena składowania produktu to 1 zł/sztukę,
- $PRODUCT\_MINIMAL\_LEFT\_OVER = 50$ - pożądany zapas każdego produktu pod koniec marca to 50 produktów,
- $PROCESS\_TOOLS[p]\ dla\ p \in PROCESSES$ - liczba maszyn pozwalających na równoległe wytwarzanie w ramach danego procesu $p$:

$p \in PROCESSES$ | $PROCESS\_TOOLS[p]$
------------------|--------------------
szlifowanie       | 4
wiercenie_pionowe | 2
wiercenie_poziome | 3
frezowanie        | 1
toczenie          | 1

\newpage

- $PRODUCTION\_TIME[i][p]\ dla\ p \in PRODUCTS,\ i \in PROCESSES$ - wymagany czas produkcji 1 sztuki produktu (w godzinach) w danym procesie obróbki:

$PRODUCTION\_TIME[i][p]$ | P1   | P2   | P3   | P4
-------------------------|------|------|------|-----
szlifowanie              | 0.4  | 0.6  | -    | -
wiercenie_pionowe        | 0.2  | 0.1  | -    | 0.6
wiercenie_poziome        | 0.1  | -    | 0.7  | -
frezowanie               | 0.06 | 0.04 | -    | 0.05
toczenie                 | -    | 0.05 | 0.02 | -

- $EXPECTED\_INCOME\_PER\_PRODUCT[p]\ dla \ p \in PRODUCTS$ - średni dochód ze sprzedaży produktów (w zł/sztukę):

$p \in PRODUCTS$ | $EXPECTED\_INCOME\_PER\_PRODUCT[p]$
-----------------|------------------------------------
P1               | $E(R_1)$
P2               | $E(R_2)$
P3               | $E(R_3)$
P4               | $E(R_4)$

- $SELL\_LIMIT[m][p]\ dla\ p \in PRODUCTS,\ m \in MONTHS$ - ograniczenia rynkowe na liczbę sprzedawanych produktów w danym miesiącu:

$SELL\_LIMIT$ | P1  | P2  | P3  | P4
--------------|-----|-----|-----|----
styczen       | 200 | 0   | 100 | 200
luty          | 300 | 100 | 200 | 200
marzec        | 0   | 300 | 100 | 200

### Zmienne decyzyjne

- $production[p][m]\ dla\ p \in PRODUCTS,\ m \in MONTHS$ - ilość danego produktu $p$ wytworzona w ciągu miesiąca $m$,
- $sale[p][m]\ dla\ p \in PRODUCTS,\ m \in MONTHS$ - oczekiwana ilość produktu $p$, która powinna zostać sprzedana w ciągu miesiąca $m$,
- $left\_over[p][m]\ dla\ p \in PRODUCTS,\ m \in MONTHS \cup \{grudzień\}$ - ilość produktu $p$, która pozostanie w magazynie na koniec miesiąca $m$,
- $income$ - zmienna reprezentująca oczekiwany całkowity dochód. Dodanie tej zmiennej pozwala na uproszczenie funkcji oceny.

### Ograniczenia

- Czas produkcji wszystkich przedmiotów w miesiącu nie może przekroczyć dostępności maszyn w miesiącu:
$$
\forall{m \in MONTHS,\ i \in PROCESSES}: 
$$
$$
\sum_{p \in PRODUCTS}\ (production[p][m] * PRODUCTION\_TIME[i][p]) \le 
$$
$$
WORKING\_HOURS\_IN\_A\_MONTH * PROCESS\_TOOLS[i]
$$

- Pozostałości ze sprzedaży są różnicą sumy produktów przechowywanych z poprzedniego miesiąca, produktów wyprodukowanych oraz sprzedanych:
$$
\forall{(s, c) \in MONTH\_PREDECESSORS,\ p \in PRODUCTS}:
$$
$$
left\_over[p][c] = production[p][c] + left\_over[p][s] - sale[p][c]
$$

- Firma na początku stycznia nie posiada żadnych zapasów, więc pozostałości przedmiotów z grudnia są równe 0:
$$
\forall{p \in PRODUCTS}:\ left\_over[p][grudzień] = 0
$$

- Oczekiwanym dochodem całkowitym jest suma wartości oczekiwanych ze sprzedaży poszczególnych produktów w różnych miesiącach pomniejszonym o sumaryczne koszty magazynowania produktów w tym czasie:
$$
income =\sum_{p \in PRODUCTS,\ m \in MONTHS}
$$
$$
(sale[p][m] * EXPECTED\_INCOME\_PER\_PRODUCT[p] - 
$$
$$
left\_over[p][m] * MONTHLY\_PRODUCT\_STORAGE\_COST)
$$

- Ograniczenia rynkowe na liczbę sprzedawanych produktów w danym miesiącu nie mogą zostać przekroczone:
$$
\forall{p \in PRODUCTS,\ m \in MONTHS}:\ sale[p][m] <= SELL\_LIMIT[m][p]
$$

- Produkt $P_4$ w danym miesiącu musi być sprzedawany w liczbie sztuk nie mniejszej niż suma sprzedawanych produktów $P_1$ i $P_2$:
$$
\forall{m \in MONTHS}:\ sale[P_4][m] \ge sale[P_1][m] + sale[P_2][m]
$$

- Istnieje możliwość składowania do $PRODUCT\_STORAGE\_LIMIT$ sztuk każdego produktu na koniec miesiąca:
$$
\forall{p \in PRODUCTS,\ m \in MONTHS}:\ left\_over[p][m] \le PRODUCT\_STORAGE\_LIMIT
$$

- Pożądane jest, aby pod koniec marca firma posiadała po $PRODUCT\_MINIMAL\_LEFT\_OVER$ sztuk każdego produktu:
$$
\forall{p \in PRODUCTS}:\ left\_over[p][marzec] \ge PRODUCT\_MINIMAL\_LEFT\_OVER
$$

- Produkcja poszczególnych produktów w miesiącu nie może być negatywna:
$$
\forall{p \in PRODUCTS,\ m \in MONTHS}:\ production[p][m] >= 0
$$

- Sprzedaż poszczególnych produktów w miesiącu nie może być negatywna:
$$
\forall{p \in PRODUCTS,\ m \in MONTHS}:\ sale[p][m] >= 0
$$

- Pozostałości w magazynach na koniec miesiąca nie mogą być negatywne:
$$
\forall{p \in PRODUCTS,\ m \in MONTHS}:\ left\_over[p][m] >= 0
$$

- Produkty są niepodzielne - produkcja, sprzedaż i pozostałości muszą być całkowitoliczbowe:
$$
\forall{p \in PRODUCTS,\ m \in MONTHS}:\ production[p][m] \in \mathbb{N}
$$

$$
\forall{p \in PRODUCTS,\ m \in MONTHS}:\ sale[p][m] \in \mathbb{N}
$$

$$
\forall{p \in PRODUCTS,\ m \in MONTHS}:\ left\_over[p][m] \in \mathbb{N}
$$

gdzie, $\mathbb{N}$ - zbiór liczb naturalnych.

### Funkcja oceny

Firma chce osiągnąć największy oczekiwany zysk. Maksymalizujemy oczekiwany dochód z produkcji, zatem funkcją oceny jest: 
$$
max(income)
$$

## Sformułowanie modelu

<!-- TODO: Sformułowanie modelu w postaci do rozwiązania z wykorzystaniem wybranego narzędzie/środowiska implementacji (kompletny kod źródłowy). -->
<!-- Polecane narzędzia: -->
<!-- - optymalizacja: AMPL, CPLEX (biblioteki) -->
<!-- - statystyka: R, MATLAB -->

## Testy poprawności implementacji

<!-- TODO: Omówienie testów poprawności implementacji -->

## Wyniki

<!-- TODO: Omówienie wyników z nawiązaniem do teorii. -->

Znalezione rozwiązanie efektywne prowadzi do oczekiwanego zysku równego 11806.90 zł.

Zmienne decyzyjne dla tego rozwiązania wynoszą odpowiednio:

- Produkcja:

production | P1  | P2  | P3  | P4
-----------|-----|-----|-----|----
styczen    | 200 | 0   | 100 | 200
luty       | 200 | 0   | 200 | 200
marzec     | 50  | 250 | 150 | 250

- Sprzedaż:

sale    | P1  | P2  | P3  | P4
--------|-----|-----|-----|----
styczen | 200 | 0   | 100 | 200
luty    | 200 | 0   | 200 | 200
marzec  | 0   | 200 | 100 | 200

- Magazynowane produkty pod koniec miesiąca:

left_over | P1 | P2 | P3 | P4
----------|----|----|----|---
grudzien  | 0  | 0  | 0  | 0
styczen   | 0  | 0  | 0  | 0
luty      | 0  | 0  | 0  | 0
marzec    | 50 | 50 | 50 | 50

\newpage

# Dwukryterialny model zysku i ryzyka z wartością średnią jako miarą zysku i odchyleniem przeciętnym jako miarą ryzyka

## Analityczne sformułowanie modelu

<!-- TODO -->
<!-- Wskazanie i uzasadnienie przyjętych założeń. -->
<!-- Wskazanie podstaw teoretycznych. -->

<!-- wartością średnią jako miarą zysku i odchyleniem przeciętnym jako miarą ryzyka -->

Model dwukryterialny został utworzony na bazie modelu jednokryterialnego. Przy rozwiązywaniu kolejnych podpunktów zostały zastosowane dwa sposoby optymalizacji rozwiązania:

- maksymalizacja średniego zysku przy ustalonym maksymalnym poziomie ryzyka,
- minimalizacja ryzyka przy ustalonym minimalnym poziomie oczekiwanego zysku.

Zastosowane metody dla poszczególnych podpunktów są lepiej opisane w sekcji $Wyniki$.

Model dwukryterialny bazuje na dwóch kryteriach:

- oczekiwanej wartości dochodu - miara zysku,
- odchyleniu przeciętnym wartości oczekiwanej dla poszczególnych realizacji scenariuszy od wartości średniej - miara ryzyka.

Miarę ryzyka możemy wyliczyć ze wzoru:
$$
\delta(x) = \sum_{t=1}^{T}|\mu(x)-r_t(x)|p_t
$$

gdzie:

- $\mu(x)$ - wartość średnia,
- $r_t(x)$ - realizacja scenariusza $t$,
- $p_t$ - prawdopodobieństwo scenariusza $t$.

W celu zamodelowania rozwiązania zostało wygenerowane 100 jednakowo prawdopodobnych scenariuszy z zadanego rozkładu zmiennej losowej $R$. Generacja jednakowo prawdopodobnych scenariuszy pozwala na zastosowanie zwykłej średniej zamiast średniej ważonej z ustalonymi prawdopodobieństwami każdego scenariusza.

Dodatkowo możemy zamodelować wartość bezwzględną jako sumę dodatniej i ujemnej odchyłki:
$$
|x| = x^+ + x^-
$$

gdzie:

- $x = x^+ - x^-$ - różnica odchyłek jest równa wartości tej liczby,
- $x^+ \ge 0$ - odchyłka dodatnia jest nieujemna,
- $x^- \ge 0$ - odchyłka ujemna jest nieujemna,
- jeśli odchyłka $x^+$ jest różna 0 to odchyłka $x^-$ jest równa 0 i na odwrót, jeśli odchyłka $x^-$ jest różna 0 to odchyłka $x^+$ jest równa 0 - możemy to zapewnić dodając pewną wagę dla poszczególnych odchyłek przy minimalizacji w funkcji oceny.

Zastosowanie obu tych sposobów pozwoli na uproszczenie wyliczania odchylenia przeciętnego.

## Specyfikacja problemu decyzyjnego

<!-- Specyfikacja problemu decyzyjnego z dookreśleniem wszystkich elementów. -->
<!-- Określenie zmiennych decyzyjnych, ograniczeń i funkcji oceny. -->

Model dwukryterialny w większości bazuje na zbiorach, parametrach, zmiennych decyzyjnych i ograniczeniach zdefiniowanych dla modelu jednokryterialnego.

Konwencja zapisu matematycznego modelu jest tożsama z konwencją wykorzystaną przy modelu w zadaniu 1.

### Zbiory

W modelu dwukryterialnym dochodzą dwa zbiory:

- $SCENARIOS = \{1, 2, ..., 100\}$ - zbiór liczb reprezentujących kolejne scenariusze,
- $DEVIATION\_MULTIPLIERS = \{1, -1\}$ - pomocniczy zbiór pozwalający na uproszczenie zapisu realizacji odchyłek.

### Parametry

- $SCENARIOS\_NO = 100$ - liczba wszystkich testowanych scenariuszy,

Pozbywamy się wcześniej ustalonych parametrów $EXPECTED\_INCOME\_PER\_PRODUCT$ oraz wszystkich ograniczeń, w których te parametry były wykorzystane. Tym razem definiujemy zysk oddzielnie dla poszczególnych realizacji scenariuszy:

- $SCENARIOS\_INCOME\_PER\_PRODUCT[s][p]\ dla\ s \in SCENARIOS,\ p \in PRODUCTS$ - dochód ze sprzedaży produktu $p$ przy realizacji scenariusza $s$. Wartości tego parametru zostały wygenerowane z obciętego rozkładu t-studenta.

### Zmienne decyzyjne

Zmienna decyzyjna $income$ została zastąpiona przez zysk wyliczany dla poszczególnych scenariuszy:

- $scenario\_income[s],\ s \in\ SCENARIOS$ - całkowity zysk osiągalny w przypadku danego scenariusza $s$,
- $deviation[s][d],\ s \in\ SCENARIOS,\ d \in\ DEVIATION\_MULTIPLIERS$ - macierz dodatnich i ujemnych odchyłek dochodów z poszczególnych scenariuszy $s$ od średniej dochodów na bazie wszystkich scenariuszy. Wartości tych odchyłek są potrzebne przy wyliczaniu wartości bezwzględnej różnicy zysków przy realizacji scenariuszy i średnich zysków,
- $mad\_risk$ - (MAD - ang. Mean Absolute Deviation) miara ryzyka wyliczona na bazie przeciętnego odchylenia zysku ze scenariuszy i średniego zysku. Dzięki wprowadzeniu ryzyka jako zmiennej decyzyjnej upraszcza się zapis funkcji oceny. 

### Ograniczenia

- Dochodem dla danego scenariusza jest różnica dochodu ze sprzedaży oraz kosztu magazynowania produktów w tym czasie:
$$
\forall{s \in SCENARIOS}: scenario\_income[s] =
$$
$$
\sum_{p \in PRODUCTS, m \in MONTHS} (sale[p][m] * SCENARIOS\_INCOME\_PER\_PRODUCT[s][p] - 
$$
$$
left\_over[p][m] * MONTHLY\_PRODUCT\_STORAGE\_COST)
$$

- W przypadku tego zadania oczekiwany zysk jest wyliczany jako średnia dochodów ze wszystkich scenariuszy. Scenariusze są jednakowo prawdopodobne, więc możemy zastosować zwykłą średnią:
$$
average\_income = 1 / SCENARIOS\_NO * \sum_{s \in SCENARIOS} scenario\_income[s]
$$

- Wyliczenie odchyłek zysków przy realizacji scenariusza od wartości średniej. Pozwoli to zamodelować wartość bezwzględną modelem liniowym. Korzystamy tutaj ze zdefiniowanego zbioru $DEVIATION\_MULTIPLIERS$, w którym zdefiniowane są odpowiednie mnożniki dla odchyłek:
$$
\forall{s \in SCENARIOS}: 
$$
$$
\sum{d \in DEVIATION\_MULTIPLIERS}\ deviation[s][d] * d = average\_income - scenario\_income[s]
$$

- Ustalenie przeciętnego odchylenia, jako średniej wartości bezwzględnej odchyleń zysków ze scenariuszy i średniego zysku. Wartość bezwzględną odchyleń jesteśmy wstanie wyliczyć sumując dodatnie i ujemne odchyłki dla poszczególnych scenariuszy. Całkowitą miarę ryzyka wyliczamy jako średnia tych wartości bezwzględnych odchylenia. Wszystkie scenariusze są jednakowo prawdopodobne, więc wzór zostaje uproszczony do:
$$
mad\_risk = 1 / SCENARIO\_NO * \sum_{s \in SCENARIOS, d \in DEVIATION\_MULTIPLIERS} deviation[s, d]
$$

- Zgodnie z ustaleniami w $Analitycznym\ sformułowaniu\ modelu$ wymagamy, aby poszczególne odchyłki były nieujemne:
$$
\forall{s \in SCENARIOS, d \in DEVIATION\_MULTIPLIERS}: deviation[s][d] \ge 0
$$

Dodatkowo w zależności od podpunktu zostały zdefiniowane następujące ograniczenia:

- Został zdefiniowany warunek na zadany poziom minimalnych zysków $MIN\_AVERAGE\_INCOME$. Warunek ten został wykorzystany w ramach podpunktu:
    - $a)$ w celu wizualizacji rozwiązań efektywnych na wykresie,
    - $b)$, aby znaleźć rozwiązanie efektywne maksymalnego zysku. Symulujemy optymalizację leksykograficzną poprzez wywołanie dwóch optymalizacji. Najpierw maksymalizujemy zysk, a następnie dodajemy warunek na ustalony poziom maksymalnego zysku i zastępujemy funkcję maksymalizującą zysk przez minimalizację ryzyka,
    - $c)$ w celu wizualizacji poszczególnych rozwiązań na wykresie.
$$
average\_income >= MIN\_AVERAGE\_INCOME
$$

- Został zdefiniowany warunek na zadany poziom maksymalnego ryzyka $MAX\_MAD\_RISK$. Warunek ten został wykorzystany w ramach podpunktu:
    - $b)$ w celu znalezienia rozwiązania efektywnego minimalnego ryzyka. Wykonujemy optymalizację leksykograficzną poprzez wywołanie dwóch niezależnych optymalizacji. Najpierw minimalizujemy ryzyko, a następnie dodajemy ten warunek na ustalony poziom minimalnego ryzyka i następnie ustalamy funkcję oceny na maksymalizację zysku.
$$
mad\_risk <= MAX\_MAD\_RISK
$$

### Funkcje oceny

Funkcje oceny podobnie jak powyższe ograniczenia zależą od rozwiązywanego podpunktu.

W podpunktach $a)$ i $c)$ stosujemy minimalizację ryzyka (przy zadanym poziomie zysku):
$$
min(mad\_risk)
$$

W podpunkcie $b)$ w celu wyznaczenia efektywnego rozwiązania maksymalnego zysku stosujemy najpierw maksymalizację zysku:
$$
max(average\_income)
$$
a następnie poszukujemy rozwiązania minimalnego ryzyka (przy zadanym maksymalnym poziomie zysku):
$$
min(mad\_risk)
$$

W podpunkcie $b)$ w celu wyznaczenia efektywnego rozwiązania minimalnego ryzyka stosujemy najpierw minimalizację ryzyka:
$$
min(mad\_risk)
$$
a następnie poszukujemy rozwiązania maksymalnego zysku (przy zadanym minimalnym poziomie ryzyka):
$$
max(average\_income)
$$

## Sformułowanie modelu

<!-- TODO: Sformułowanie modelu w postaci do rozwiązania z wykorzystaniem wybranego narzędzie/środowiska implementacji (kompletny kod źródłowy). -->
<!-- Polecane narzędzia: -->
<!-- - optymalizacja: AMPL, CPLEX (biblioteki) -->
<!-- - statystyka: R, MATLAB -->

## Testy poprawności implementacji

<!-- TODO: Omówienie testów poprawności implementacji -->

## Wyniki

> Wyznaczyć obraz zbioru rozwiązań efektywnych w przestrzeni ryzyko–zysk.

W celu wyznaczenia możliwych rozwiązań efektywnych dwukryterialnego zadania w przestrzeni ryzyko-zysk podzielono zadanie na kilka mniejszych zadań optymalizacyjnych. 

Chcąc zwizualizować rozwiązania poszczególnych zadań na wykresie został zdefiniowany nowy parametr $MIN\_AVERAGE\_INCOME$ oraz zostało dodane dodatkowe ograniczenie na średni poziom zysku:

$$
average\_income >= MIN\_AVERAGE\_INCOME
$$

Iteracja po równo odległych osiągalnych poziomach zysku z zakresu [-200; 11553] pozwala zwizualizować te rozwiązania efektywne w przestrzeni.

Dla tak zdefiniowanych poszczególnych zadań została ustalona funkcja oceny na minimalizację miary ryzyka:

$$
min(mad\_risk)
$$

Na wykresie zostały przedstawione 119 rozwiązania efektywne zadania:

![Obraz zbioru rozwiązań efektywnych w przestrzeni ryzyko–zysk](./img/risk-income.png)

---

> Wskazać rozwiązania efektywne minimalnego ryzyka i maksymalnego zysku. Jakie odpowiadają im wartości w przestrzeni ryzyko–zysk?

typ \\ wartość   | zysk  | ryzyko
-----------------|-------|--------
minimalne ryzyko | -200  | 0
maksymalny zysk  | 11553 | 735.498

Rozwiązania te zostały osiągnięte poprzez ustalenie funkcji celu odpowiednio na minimalizację ryzyka w pierwszym przypadku i maksymalizację zysku w drugim przypadku. Następnie, aby zapobiec wyborze nie efektywnego rozwiązania ustalono poziom ryzyka (w pierwszym przypadku) i zysku (w drugim przypadku) na stały poziom ustalony w poprzednim kroku i uruchomiono ponownie optymalizację. Tym razem w pierwszym przypadku maksymalizując zysk przy stałym ryzyku i w drugim przypadku minimalizując ryzyko przy stałym zysku.

---

> Wybrać trzy dowolne rozwiązania efektywne. Sprawdzić czy zachodzi pomiędzy nimi relacja dominacji stochastycznej pierwszego rzędu. Wyniki skomentować, odnieść do ogólnego przypadku.

Zostały wybrane trzy zadane poziomy zysku, dla których następnie były wyliczone rozwiązania efektywne. Wyliczono wartości oczekiwanego zysku oraz miary ryzyka, a rozkład zysku w zależności od scenariusza został przedstawiony na Rysunku 2.

nazwa | zadany poziom zysku (w zł) | oczekiwany zysk (w zł) | wyliczona miara ryzyka (w zł)
------|----------------------------|------------------------|------------------------------
S1    | 5000                       | 5000.13                | 233.011
S2    | 11450                      | 11452.1                | 660.965
S3    | 11550                      | 11550                  | 728.842

![Dystrybuanta dla trzech rozwiązań efektywnych](./img/income-cdf.png)

Rozwiązanie $S1$ jest zdominowane przez rozwiązania $S2$ i $S3$ w sensie FSD.

W przypadku rozwiązań $S2$ i $S3$ dystrybuanty się przecinają, oznacza to że nie występuje między nimi dominacja w sensie FSD.

W ogólnym przypadku dla dwóch rozwiązań efektywnych o dużej różnicy w oczekiwanym zysku rozwiązanie o wyższej średniej zysku dominuje w sensie FSD rozwiązanie o niższym oczekiwanym zysku. Dla rozwiązań efektywnych nieznacznie różniących się oczekiwanymi zyskami dominacja może zajść, ale nie musi.
