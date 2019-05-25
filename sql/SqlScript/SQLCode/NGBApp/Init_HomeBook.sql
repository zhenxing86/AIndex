USE NGBApp
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-15
-- Description:	
初始化家园联系册，并获取hbid,参数：cid,term。逻辑：如果有hbid直接取出返回，无则初始化homebook表
调用：获取家园联系册列表和进入成长档案时调用。
-- Memo:		
declare @hbid int
exec @hbid = Init_HomeBook 46144, '2013-1'
select @hbid
*/
CREATE PROC Init_HomeBook
	@cid int,
	@term varchar(6)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @hbid int
	
	select @hbid = hbid 
		from HomeBook 
		where cid = @cid 
			and term = @term
	IF @hbid IS NOT NULL
		RETURN @hbid
	ELSE
	BEGIN
		INSERT INTO HomeBook(kid, grade, cid, term)
			SELECT kid, grade, cid, @term
				FROM BasicData.dbo.class 
				where cid = @cid
		RETURN @@IDENTITY		
	END 
	
END
GO