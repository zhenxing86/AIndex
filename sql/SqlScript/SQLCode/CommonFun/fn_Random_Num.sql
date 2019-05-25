USE CommonFun
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_Random_Num]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_Random_Num]
GO
USE CommonFun
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-08-19  
-- Description: 用于随机获取一定范围内的数字 
-- Para: 
	@type 
		0 平均分布 
		1 三等分后小的占60%，其他各占20%
		2 三等分后中的占60%，其他各占20%
		3 三等分后大的占60%，其他各占20%
-- Memo:    

SELECT dbo.fn_Random_Num(50,200,newid(),0)
*/
CREATE FUNCTION [dbo].[fn_Random_Num](@bgn int, @end int,@rand varchar(100),@type INT)
returns int
as
begin
	declare @second int, @third int,@second1 int, @third1 int, @result int
	IF @type = 0
	set @result = @bgn+abs(checksum(@rand))%(@end-@bgn+1) 
	else 
	BEGIN
		SET @second = @bgn + (@end-@bgn)/3 
		SET @third = @bgn + 2 * (@end-@bgn)/3		 
		SELECT @second1 = case when @third > @second then @second + 1 else @second end 
		SELECT @third1 = case when @end > @third then @third + 1 else @third end 
		IF @type = 1
		BEGIN 
			if abs(checksum(@rand))%100/10 + 1 between 3 and 8
				set @result = @bgn+abs(checksum(@rand))%(@second-@bgn+1) 		
			if abs(checksum(@rand))%100/10 + 1 between 1 and 2		
				set @result = @second1+abs(checksum(@rand))%(@third-@second1+1) 	
			if abs(checksum(@rand))%100/10 + 1 between 9 and 10
				set @result = @third1+abs(checksum(@rand))%(@end-@third1+1)
		END 
		IF @type = 2
		BEGIN 
			if abs(checksum(@rand))%100/10 + 1 between 1 and 2		
				set @result = @bgn+abs(checksum(@rand))%(@second-@bgn+1) 		
			ELSE
			if abs(checksum(@rand))%100/10 + 1 between 3 and 8
				set @result = @second1+abs(checksum(@rand))%(@third-@second1+1) 	
			ELSE
			if abs(checksum(@rand))%100/10 + 1 between 9 and 10
				set @result = @third1+abs(checksum(@rand))%(@end-@third1+1)
		END 		
		IF @type = 1
		BEGIN 
			if abs(checksum(@rand))%100/10 + 1 between 1 and 2		
				set @result = @bgn+abs(checksum(@rand))%(@second-@bgn+1)
			ELSE 
			if abs(checksum(@rand))%100/10 + 1 between 9 and 10		
				set @result = @second1+abs(checksum(@rand))%(@third-@second1+1) 	
			ELSE
			if abs(checksum(@rand))%100/10 + 1 between 3 and 8	
				set @result = @third1+abs(checksum(@rand))%(@end-@third1+1)
		END 
	END
	return @result
end
GO


