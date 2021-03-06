USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[rep_my_book_statistics_GetList]    Script Date: 08/10/2013 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：统计数字图书销量
--项目名称：家长增值服务结算报表
--说明：数字图书销量统计
--时间：2013-3-7 11:50:29
--exec my_book_statistics
------------------------------------ 
CREATE procedure [dbo].[rep_my_book_statistics_GetList]
as
begin	
	create table #viewtemp
	(
		sbid nvarchar(50)
		,title nvarchar(100)
		,price numeric(18,2)
		,viewcount int
		,salecount int
		,salemoney numeric(18, 2)
	)


	insert into #viewtemp(sbid,title,price,viewcount,salecount,salemoney)
	select b.sbid,b.book_title,b.bean_price/5.0,v.viewcount,v.salecount,v.salemoney
	from SBApp..sb_book b
	left join SBAppLog..sbviewcount v on b.sbid=v.sbid
	 
	insert into #viewtemp(sbid,title,price,viewcount,salecount,salemoney)
	select '','合计',0,sum(viewcount),sum(salecount),sum(salemoney)
	from #viewtemp
	
	select sbid,title,price,viewcount,salecount,salemoney
	from #viewtemp
	order by (case when len(sbid)>0 then -1 else 0 end) asc,viewcount desc,salecount desc
	
	drop table #viewtemp
	
	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	    RETURN (1)
	END
end
GO
