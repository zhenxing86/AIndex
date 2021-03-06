USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[enlistonline_GetListByDateRange]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--根据报名开始和结束时间获取列表  
CREATE proc [dbo].[enlistonline_GetListByDateRange]  
@siteid int,  
@begintime datetime,  
@endtime datetime  
as  
SELECT [id],[siteid],[name],[sex],[birthday],[contactphone],[contactaddress],[memo],[createdatetime],classname,ffamily,funit,fphone,sfamily,sunit,sphone,nativeplace,nation,fname,sname         
 from enlistonline where siteid=@siteid and createdatetime>=@begintime and createdatetime <=@endtime  
GO
