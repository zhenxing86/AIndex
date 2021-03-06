USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[GBDownload_Query]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--[GBDownload_Query] '2012-01-08','2012-01-19',3,10,4
------------------------------------
CREATE PROCEDURE [dbo].[GBDownload_Query]
	@time_star datetime,
	@time_end datetime,
	@status int,
	@size int,
	@page int
 AS 
BEGIN
	SET NOCOUNT ON
	exec	sp_MutiGridViewByPager
			@fromstring = 'ebook..gbdownloadlist g 
							left join basicdata..[user] u on g.userid = u.userid  
							left join ebook..gb_growthbook gg on g.growthbookid = gg.growthbookid 
							left join basicdata..kindergarten k on g.kid = k.kid 
				where u.usertype = 0 
					and u.deletetag = 1
					and g.applydate between @T1 and @T2',      --数据集
			@selectstring = 
			'k.kname,u.name,g.recmobile,u.account,g.userid,g.applydate,g.gendate,
							g.downloaddate,g.status,g.downloadpath,g.growthbookid,g.isdownload,g.reapply',      --查询字段
			@returnstring = 
			'kname,name,recmobile,account,userid,applydate,gendate,
							downloaddate,status,downloadpath,growthbookid,isdownload,reapply',      --返回字段
			@pageSize = @Size,                 --每页记录数
			@pageNo = @page,                     --当前页
			@orderString = ' g.applydate desc',          --排序条件
			@IsRecordTotal = 0,             --是否输出总记录条数
			@IsRowNo = 0,										 --是否输出行号
			@T1 = @time_star,										
			@T2 = @time_end			
	
END

GO
