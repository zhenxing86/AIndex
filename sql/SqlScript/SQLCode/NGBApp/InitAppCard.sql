USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[InitAppCard]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-09-07
-- Description:	
-- Memo:  exec Get_qmzp 1
*/
create PROC [dbo].[InitAppCard]

AS
declare @month varchar(1)
declare @gtype int
declare @ml varchar(5)
set @month=4
set @gtype=3
set @ml='5-6'
insert into appcard(gtype,showmonth,url)values(@gtype,@month,'http://czkp.zgyey.com/appcard/'+@ml+'/'+@month+'/1.jpg')
insert into appcard(gtype,showmonth,url)values(@gtype,@month,'http://czkp.zgyey.com/appcard/'+@ml+'/'+@month+'/2.jpg')
insert into appcard(gtype,showmonth,url)values(@gtype,@month,'http://czkp.zgyey.com/appcard/'+@ml+'/'+@month+'/3.jpg')
insert into appcard(gtype,showmonth,url)values(@gtype,@month,'http://czkp.zgyey.com/appcard/'+@ml+'/'+@month+'/4.jpg')
insert into appcard(gtype,showmonth,url)values(@gtype,@month,'http://czkp.zgyey.com/appcard/'+@ml+'/'+@month+'/5.jpg')
   

GO
