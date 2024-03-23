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

var production{p in PRODUCTS, m in MONTHS} integer >= 0;
var sale{p in PRODUCTS, m in MONTHS} integer >= 0;
var left_over{p in PRODUCTS, m in ALL_MONTHS} integer >= 0;
var income >= 0.0;


subject to production_time_constraint{m in MONTHS, i in PROCESSES}:
	sum{p in PRODUCTS} (production[p, m] * PRODUCTION_TIME[i, p]) <= WORKING_HOURS_IN_A_MONTH * PROCESS_TOOLS[i];

subject to left_over_constraint{(s, c) in MONTH_PREDECESSORS, p in PRODUCTS}:
	left_over[p, c] = production[p, c] + left_over[p, s] - sale[p, c];

subject to december_left_over_constraint{p in PRODUCTS}:
	left_over[p, "grudzien"] = 0;

subject to income_constraint:
	income = sum{p in PRODUCTS, m in MONTHS} (
		sale[p, m] * EXPECTED_INCOME_PER_PRODUCT[p] 
		- left_over[p, m] * MONTHLY_PRODUCT_STORAGE_COST
	);

subject to sale_limit_constraint{p in PRODUCTS, m in MONTHS}:
	sale[p, m] <= SELL_LIMIT[m, p];

subject to product_sell_limit_constraint{m in MONTHS}:
	sale["P4", m] >= sale["P1", m] + sale["P2", m];
	
subject to product_storage_limit_constraint{p in PRODUCTS, m in MONTHS}:
	left_over[p, m] <= PRODUCT_STORAGE_LIMIT;

subject to product_minimal_left_over_constraint{p in PRODUCTS}:
	left_over[p, "marzec"] >= PRODUCT_MINIMAL_LEFT_OVER;


maximize max_income:
	income;


option solver cplex;
solve;

display production;
display sale;
display left_over;
display income;
