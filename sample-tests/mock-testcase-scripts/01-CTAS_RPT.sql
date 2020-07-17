IF EXISTS (SELECT * FROM sys.tables WHERE name = N'InternetSales')
	DROP TABLE InternetSales

CREATE TABLE InternetSales 
WITH (DISTRIBUTION = ROUND_ROBIN, HEAP ) 
AS

SELECT * FROM FactInternetSales
OPTION (LABEL = 'CTAS_SalesFacts')

