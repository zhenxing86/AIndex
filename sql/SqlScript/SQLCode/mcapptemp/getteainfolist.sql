USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[getteainfolist]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO















------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012-10-16 21:55:38
--[getteainfolist] 17709,'001770901'
--[getteainfolist] 12511,'001251101'
------------------------------------
CREATE PROCEDURE [dbo].[getteainfolist]
@kid int,
@devid varchar(10)
 AS 	

create table #teainfolist
(
oid int
)

insert into #teainfolist(oid)

select oid from teaid_tmp where devid=@devid

SELECT  [teaid]
      ,t1.[card]
      ,[name]
      ,case [sex] when '女' then '0' when '男' then '1' end 
  FROM [mcapp].[dbo].[teainfo] t1 
where t1.kid=@kid and  teaid not in(select oid from #teainfolist)
--and len(card)>0













GO
