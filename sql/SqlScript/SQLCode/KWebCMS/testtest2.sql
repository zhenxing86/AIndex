USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[testtest2]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:     liaoxin
-- Create date: 2010-8-5
-- Description:	统计附件表(视频，音乐，文档)大小
-- =============================================
create PROCEDURE [dbo].[testtest2]
	
AS
BEGIN 
 declare @siteid2 int,@useSize2 bigint

	 create table #fujian
(
   siteid int,
   sizes bigint
)

insert into #fujian(siteid,sizes)  select siteid,dbo.IsDayu300M(sum(convert(bigint,filesize))) from cms_contentattachs   group by siteid 
 
 declare   cur2  insensitive cursor   for  
 select siteid,sizes   from   #fujian
  open   cur2  
 fetch   next   from   cur2 into @siteid2,@useSize2
 while   @@fetch_status=0    
  begin 
   
     update   site_spaceInfo  set   useSize=dbo.IsDayu300M(useSize+@useSize2),lastSize=300*1024*1024-dbo.IsDayu300M(useSize+@useSize2),lastUpdateTime=getdate()   where siteID=@siteid2 
    
     fetch   next   from   cur2   into @siteid2,@useSize2
  end  
  close   cur2 
 deallocate   cur2
END

GO
