USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetVoteDetail]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[GetVoteDetail]
	@sd nvarchar(30),
	@ed nvarchar(30)
as
begin
select vl.siteid as ID, tk.name as 幼儿园名, vl.fromip as IP, vl.result as 结果, 
vl.createdatetime as 投票时间
from kwebcms..votelog vl left join t_kindergarten tk on vl.siteid = tk.id
where vl.createdatetime between @sd and @ed
 order by vl.createdatetime desc
end


GO
