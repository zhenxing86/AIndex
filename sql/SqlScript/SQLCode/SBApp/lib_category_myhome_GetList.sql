USE [SBApp]
GO
/****** Object:  StoredProcedure [dbo].[lib_category_myhome_GetList]    Script Date: 2014/11/24 23:26:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[lib_category_GetList]    Script Date: 02/19/2013 11:29:23 ******/



CREATE PROCEDURE [dbo].[lib_category_myhome_GetList]
 @uid int
 AS 
 
 create table #temp
 (
 tid int
 ,tsbid varchar(100)
 ,ty int
 )
 insert into #temp(tid,tsbid,ty)
 select catid,m.sbid,0 from my_book m
 inner join dbo.sb_book s on s.sbid=m.sbid
 where userid=@uid
 order by orderno

select [catid],[cat_title]    ,[css_name]  ,[parentid],index_view,cat_py,book_css,book_count,book_url,tsbid from dbo.lib_category l
inner join #temp t on  l.book_url+',' like '%'+t.tsbid+',%' 


drop table #temp


GO
