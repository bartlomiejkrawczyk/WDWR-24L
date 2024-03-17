# Wspomaganie decyzji w warunkach ryzyka

```
Bartłomiej Krawczyk, 310774
```

## Zadanie

#### Rozważamy następujące zagadnienie planowania produkcji:

Przedsiębiorstwo wytwarza 4 produkty P1, P2, P3, P4 na następujących maszynach: 
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

Dochody ze sprzedaży produktów (w zł/sztukę) modelują składowe wektora losowego $R =
(R1, R2, R3, R4)^T$ . Wektor losowy $R$ opisuje 4-wymiarowy rozkład t-Studenta z 4 stopniami swobody, którego wartości składowych zostały zawężone do przedziału $[5; 12]$. Parametry $\mu$ oraz $\Sigma$ niezawężonego rozkładu t-Studenta są następujące:

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
        16 & -2 & -1 & -3 \\\\
        -2 &  9 & -4 & -1 \\\\
        -1 & -4 &  4 &  1 \\\\
        -3 & -1 &  1 &  1
    \end{bmatrix}
$$

Istnieją ograniczenia rynkowe na liczbę sprzedawanych produktów w danym miesiącu:

miesiąc | P1  | P2  | P3  | P4
--------|-----|-----|-----|----
Styczeń | 200 | 0   | 100 | 200
Luty    | 300 | 100 | 200 | 200
Marzec  | 0   | 300 | 100 | 200

Jeżeli w danym miesiącu jest sprzedawany produkt P1 lub P2, to musi być również sprzedawany produkt P4 w liczbie sztuk nie mniejszej niż suma sprzedawanych produktów P1 i P2.

Istnieje możliwość składowania do 200 sztuk każdego produktu w danym czasie w cenie
1 zł/sztukę za miesiąc. Aktualnie firma nie posiada żadnych zapasów, ale jest pożądane mieć po 50 sztuk każdego produktu pod koniec marca.

Przedsiębiorstwo pracuje 6 dni w tygodniu w systemie dwóch zmian. Każda zmiana trwa 8 godzin. Można założyć, że każdy miesiąc składa się z 24 dni roboczych.

1. Zaproponować jednokryterialny model wyboru w warunkach ryzyka z wartością średnią jako miarą zysku. Wyznaczyć rozwiązanie optymalne.

2. Jako rozszerzenie powyższego zaproponować dwukryterialny model zysku i ryzyka z wartością średnią jako miarą zysku i odchyleniem przeciętnym jako miarą ryzyka. Dla decyzji $x \in Q$ odchylenie przeciętne jest definiowane jako $\delta(x) = \Sigma_{t=1}^{T}|\mu(x)-r_t(x)|p_t$, gdzie $\mu(x)$ oznacza wartość średnią, $r_t(x)$ realizację dla scenariusza $t$, $p_t$ prawdopodobieństwo scenariusza $t$.
    - Wyznaczyć obraz zbioru rozwiązań efektywnych w przestrzeni ryzyko–zysk.
    - Wskazać rozwiązania efektywne minimalnego ryzyka i maksymalnego zysku. Jakie odpowiadają im wartości w przestrzeni ryzyko–zysk?
    - Wybrać trzy dowolne rozwiązania efektywne. Sprawdzić czy zachodzi pomiędzy nimi relacja dominacji stochastycznej pierwszego rzędu. Wyniki skomentować, odnieść do ogólnego przypadku.


## Analityczne sformułowanie modelu

<!-- Wskazanie i uzasadnienie przyjętych założeń. -->
<!-- Wskazanie podstaw teoretycznych. -->

## Specyfikacja problemu decyzyjnego

<!-- Specyfikacja problemu decyzyjnego z dookreśleniem wszystkich elementów. -->
<!-- Określenie zmiennych decyzyjnych, ograniczeń i funkcji oceny. -->

## Sformułowanie modelu

<!-- Sformułowanie modelu w postaci do rozwiązania z wykorzystaniem wybranego narzędzie/środowiska implementacji (kompletny kod źródłowy). -->
<!-- Polecane narzędzia: -->
<!-- - optymalizacja: AMPL, CPLEX (biblioteki) -->
<!-- - statystyka: R, MATLAB -->

## Testy poprawności implementacji

<!-- Omówienie testów poprawności implementacji -->

## Wyniki

<!-- Omówienie wyników z nawiązaniem do teorii. -->
