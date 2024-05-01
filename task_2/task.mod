set PRODUCTS;
set PROCESSES;
set MONTHS;
set MONTHS_WITH_DECEMBER;
set ALL_MONTHS;
set MONTH_PREDECESSORS within MONTHS_WITH_DECEMBER cross MONTHS;
set SCENARIOS;
set DEVIATION_MULTIPLIERS;

param WORKING_HOURS_IN_A_MONTH;
param PRODUCT_STORAGE_LIMIT;
param MONTHLY_PRODUCT_STORAGE_COST;
param PRODUCT_MINIMAL_LEFT_OVER;
param SCENARIOS_NO;
param MIN_AVERAGE_INCOME;

param PROCESS_TOOLS{p in PROCESSES};

param PRODUCTION_TIME{i in PROCESSES, p in PRODUCTS};

param SCENARIOS_INCOME_PER_PRODUCT{s in SCENARIOS, p in PRODUCTS};

param SELL_LIMIT{m in MONTHS, p in PRODUCTS};

#############################################################################

# Produkcja nie mo¿e byæ negatywna:
var production{p in PRODUCTS, m in MONTHS} integer >= 0;

# Sprzeda¿ nie mo¿e byæ negatywna:
var sale{p in PRODUCTS, m in MONTHS} integer >= 0;

# Pozosta³oœci w magazynach nie mog¹ byæ negatywne:
var left_over{p in PRODUCTS, m in ALL_MONTHS} integer >= 0;

# Dochód dla danego scenariusza
var scenario_income{s in SCENARIOS};

# Œredni zysk na podstawie wszystkich scenariuszy
var average_income;

# Zmienne pomocnicze reprezentuj¹ce dodatnie 
# i ujemne odchy³ki zysku z danego scenariusza od zysku œredniego
var deviation{s in SCENARIOS, d in DEVIATION_MULTIPLIERS} >= 0;

# MAD (Mean Absolute Deviation) - ryzyko wyliczone na bazie przeciêtnego odchylenia
var mad_risk >= 0.0;

#############################################################################

# Czas produkcji wszystkich przedmiotów w miesi¹cu nie mo¿e przekroczyæ 
# dostêpnoœci maszyn w miesi¹cu:
subject to production_time_constraint{m in MONTHS, i in PROCESSES}:
	sum{p in PRODUCTS} 
		(production[p, m] * PRODUCTION_TIME[i, p]) 
		<= WORKING_HOURS_IN_A_MONTH * PROCESS_TOOLS[i];

# Pozosta³oœci ze sprzeda¿y s¹ ró¿nic¹ sumy produktów przechowywanych 
# z poprzedniego miesi¹ca i wyprodukowanych oraz sprzedanych:
subject to left_over_constraint{(s, c) in MONTH_PREDECESSORS, p in PRODUCTS}:
	left_over[p, c] = production[p, c] + left_over[p, s] - sale[p, c];

# Firma na pocz¹tku stycznia nie posiada ¿adnych zapasów, 
# wiêc pozosta³oœci przedmiotów z grudnia s¹ równe 0:
subject to december_left_over_constraint{p in PRODUCTS}:
	left_over[p, "grudzien"] = 0;

# Ograniczenia rynkowe na liczbê sprzedawanych produktów 
# w danym miesi¹cu nie mog¹ byæ przekroczone:
subject to sale_limit_constraint{p in PRODUCTS, m in MONTHS}:
	sale[p, m] <= SELL_LIMIT[m, p];
	
# Produkt P4 musi byæ sprzedawany w liczbie sztuk nie mniejszej 
# ni¿ suma sprzedawanych produktów P1 i P2:
subject to product_sell_limit_constraint{m in MONTHS}:
	sale["P4", m] >= sale["P1", m] + sale["P2", m];
	
# Istnieje mo¿liwoœæ sk³adowania do PRODUCT_STORAGE_LIMIT 
# sztuk ka¿dego produktu:
subject to product_storage_limit_constraint{p in PRODUCTS, m in MONTHS}:
	left_over[p, m] <= PRODUCT_STORAGE_LIMIT;

# Po¿¹dane jest, aby pod koniec marca firma posiada³a 
# po PRODUCT_MINIMAL_LEFT_OVER sztuk ka¿dego produktu pod koniec marca:
subject to product_minimal_left_over_constraint{p in PRODUCTS}:
	left_over[p, "marzec"] >= PRODUCT_MINIMAL_LEFT_OVER;

# Dochodem dla danego scenariusza jest ró¿nica dochodu ze sprzeda¿y
# oraz kosztu magazynowania:
subject to scenario_income_constraint{s in SCENARIOS}:
	scenario_income[s] = sum{p in PRODUCTS, m in MONTHS} (
		sale[p, m] * SCENARIOS_INCOME_PER_PRODUCT[s, p] 
		- left_over[p, m] * MONTHLY_PRODUCT_STORAGE_COST
	);

# Œredni zysk jest wyliczany jako œrednia zarobków ze wszystkich scenariuszy:
subject to average_income_constraint:
	average_income = 1 / SCENARIOS_NO * sum{s in SCENARIOS} scenario_income[s];

# Warunek na minimalny zadany poziom zarobków:
subject to min_average_income_constraint:
	average_income >= MIN_AVERAGE_INCOME;

# Wyliczenie pomoczniczych odchy³ek:
subject to income_deviation{s in SCENARIOS}:
	sum{d in DEVIATION_MULTIPLIERS} deviation[s, d] * d = average_income - scenario_income[s];

# Wyliczenie przeciêtnego odchylenia:
subject to mean_absolute_deviation_constraint:
	mad_risk = 1 / SCENARIOS_NO * sum{t in SCENARIOS, d in DEVIATION_MULTIPLIERS} deviation[t, d];

#############################################################################

minimize min_mad_risk:
	mad_risk;

#maximize max_income_constraint:
#	average_income;

#############################################################################
