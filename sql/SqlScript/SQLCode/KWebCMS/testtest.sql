USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[testtest]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:    lx
-- Create date: 2010-8-4
-- Description:	 初始化现有用户的空间大小,并且统计出各栏目下照片的总大小
-- =============================================
CREATE PROCEDURE [dbo].[testtest]
	
AS
BEGIN 
   declare @siteid int,@useSize bigint,@siteid2 int,@useSize2 bigint
   create  table #photo
  (
     siteid int,
     sizes bigint
  )
  

  begin transaction

  insert into site_spaceInfo(siteID,spaceSize,useSize,lastSize,lastUpdateTime) select siteid,300*1024*1024,0,300*1024*1024,getdate() from site  group by siteid
   
  insert into  #photo(siteid,sizes) select  siteid,dbo.IsDayu300M(sum(convert(bigint,filesize)))   from cms_photo Where deletetag = 1 group by siteid	
 

  declare   cur1  insensitive cursor   for  
  select siteid,sizes  from   #photo
  open   cur1  
  fetch   next   from   cur1 into @siteid,@useSize
  while   @@fetch_status=0    
  begin 
   
     update   site_spaceInfo  set   useSize=dbo.IsDayu300M(useSize+@useSize),lastSize=300*1024*1024-dbo.IsDayu300M(useSize+@useSize),lastUpdateTime=getdate()  where siteID=@siteid 
    
     fetch   next   from   cur1   into @siteid,@useSize
  end  
  close   cur1  
  deallocate   cur1



COMMIT TRANSACTION
END

GO
