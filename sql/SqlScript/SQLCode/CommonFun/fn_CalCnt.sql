USE CommonFun
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-09-07
-- Description:	该函数用于判断非空字符串的个数
-- Memo:		
*/
CREATE FUNCTION fn_CalCnt(@s1 nvarchar(50),@s2 nvarchar(50),@s3 nvarchar(50),@s4 nvarchar(50))
returns int
as
begin
	declare @result int
select @result = case when isnull(@s1,'') = '' then 0 else 1 end
							 + case when isnull(@s2,'') = '' then 0 else 1 end
							 + case when isnull(@s3,'') = '' then 0 else 1 end
							 + case when isnull(@s4,'') = '' then 0 else 1 end	
return @result
end