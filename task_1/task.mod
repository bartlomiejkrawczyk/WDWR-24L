reset;

set PRODUCTS;
set PROCESSES;
set MONTHS;
set MONTHS_WITH_DECEMBER;
set ALL_MONTHS;
set MONTH_PREDECESSORS within MONTHS_WITH_DECEMBER cross MONTHS;

param WORKING_HOURS_IN_A_MONTH;
param PRODUCT_STORAGE_LIMIT;
param MONTHLY_PRODUCT_STORAGE_COST;
param PRODUCT_MINIMAL_LEFT_OVER;

param PROCESS_TOOLS{p in PROCESSES};

param PRODUCTION_TIME{i in PROCESSES, p in PRODUCTS};

param EXPECTED_INCOME_PER_PRODUCT{p in PRODUCTS};

param SELL_LIMIT{m in MONTHS, p in PRODUCTS};

data parameters.dat;

#############################################################################

# Produkcja nie mo¿e byæ negatywna:
var production{p in PRODUCTS, m in MONTHS} integer >= 0;

# Sprzeda¿ nie mo¿e byæ negatywna:
var sale{p in PRODUCTS, m in MONTHS} integer >= 0;

# Pozosta³oœci w magazynach nie mog¹ byæ negatywne:
var left_over{p in PRODUCTS, m in ALL_MONTHS} integer >= 0;

var income >= 0.0;

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

# Dochodem ca³kowitym jest ró¿nica dochodu ze sprzeda¿y oraz kosztu 
# magazynowania:
subject to income_constraint:
	income = sum{p in PRODUCTS, m in MONTHS} (
		sale[p, m] * EXPECTED_INCOME_PER_PRODUCT[p] 
		- left_over[p, m] * MONTHLY_PRODUCT_STORAGE_COST
	);

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

#############################################################################

maximize max_income:
	income;

#############################################################################

option solver cplex;
solve;

display production;
display sale;
display left_over;
display income;
