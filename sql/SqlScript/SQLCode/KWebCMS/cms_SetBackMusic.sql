USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_SetBackMusic]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--设置是否开启背景音乐@opt=1开启0关闭  
create proc [dbo].[cms_SetBackMusic]  
@siteid int,  
@opt int  
as  
update site_config set openbackmusic=@opt where siteid=@siteid  
if(@@ERROR<>0)  
begin  
 return -1  
end  
else  
begin  
 return 1  
end
GO
