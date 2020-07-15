SELECT COUNT(*) FROM FactInternetSales
OPTION (LABEL = 'CountInternetSales');

SELECT COUNT(*) FROM FactResellerSales
OPTION (LABEL = 'CountResellerSales');

SELECT COUNT(*) FROM SalesByDate
OPTION (LABEL = 'AggSalesByDate')