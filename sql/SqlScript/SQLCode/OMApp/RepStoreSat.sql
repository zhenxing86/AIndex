USE OMApp
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-11-13
-- Description:	
--库存统计	
--统计当前总的库存量，按物品分类汇总
-- Memo:	
RepStoreSat 12511, 0
RepStoreSat 12511, 1
*/
ALTER PROC RepStoreSat
	@kid int,
	@type int --0 按大类， 1 按小类
as
BEGIN
	SET NOCOUNT ON
	CREATE TABLE #T(Title VARCHAR(50), SortCode VARCHAR(10),SubTitle VARCHAR(50),  SortSubCode VARCHAR(10), SumQty int, cnt int)
	IF @type = 0
	INSERT INTO #T(Title, SortCode, SumQty, cnt)
		select s.Title, s.SortCode, o.SumQty, o.cnt 
			from Sort s 
				left join Object_M_SortNo_V o 
				on o.kid = s.kid
				and o.SortCode = s.SortCode
			where s.kid = @kid

	IF @type = 1
	INSERT INTO #T(Title, SortCode, SubTitle, SortSubCode, SumQty, cnt )
	select s.Title, s.SortCode, ss.Title SubTitle, ss.SortSubCode, o.SumQty, o.cnt 
		from Sort s 
			inner join SortSub ss
			on s.kid = ss.kid
			and s.SortCode = ss.SortCode		 
			left join Object_M_SortSubNo_V o 
			on o.kid = ss.kid
			and o.SortCode = ss.SortCode
			and o.SortSubCode = ss.SortSubCode
		where s.kid = @kid

;WITH CET AS
(
select Title, SubTitle, isnull(SumQty,0)SumQty, isnull(cnt,0)cnt from #T
union
select '合计', '',  SUM(SumQty)SumQty, SUM(cnt)cnt from #T 
)
SELECT * FROM CET ORDER BY CASE WHEN Title = '合计' then 1 else 0 end

END
GO