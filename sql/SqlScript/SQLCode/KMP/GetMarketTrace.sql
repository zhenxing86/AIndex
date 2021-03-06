USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetMarketTrace]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetMarketTrace]
	@sd nvarchar(30),
	@ed nvarchar(30)
as
begin
select k.id as ID, k.name as 幼儿园, m.market as 营销跟进情况, m.contentmemo as 内容跟进情况,  
	m.updatetime as 最后跟踪时间
from markettrace m inner join t_kindergarten k on m.kid = k.id
where m.updateTime between @sd and @ed
 order by m.updatetime desc
end




GO
