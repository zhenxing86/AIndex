USE OMApp 
GO
CREATE VIEW Object_PicCnt_v WITH SCHEMABINDING
AS
	SELECT	kid, BarCode, count_big(*) as cnt   
		FROM DBO.Object_Pic
		GROUP BY kid, BarCode
			 
GO
CREATE UNIQUE CLUSTERED INDEX idx_kid_BarCode ON dbo.Object_PicCnt_v(kid, BarCode);