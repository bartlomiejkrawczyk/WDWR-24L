
var income;
var risk;

subject to dupa_constraint:
	income >= MAX_INCOME;

subject to dupa2_constraint:
	risk >= MAX_INCOME;
	
minimize income_risk:
	income + risk;
