USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[deviceinfo_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*-- =============================================      
-- Author:  xzx      
-- Project: com.zgyey.ossapp      
-- Create date: 2013-11-14      
-- Description: 获取幼儿园设备信息  

	deviceinfo_GetListTag -1,1,10,'','','',0
    
-- =============================================  */    
alter PROCEDURE [dbo].[deviceinfo_GetListTag]      
@kid int,    
@page int=1,    
@size int=100,    
@kname nvarchar(50)='',    
@firmw nvarchar(50)='',    
@pcfirmw nvarchar(50)='',  
@devtype int=-1  
AS      
BEGIN      
      
SET NOCOUNT ON     
 DECLARE @fromstring NVARCHAR(2000)    
     
 SET @fromstring = ' mcapp..driveinfo d inner join basicdata..kindergarten k    
 on d.kid=k.kid where d.detetetag=1 '     
 if(@devtype>=0) set @fromstring = @fromstring+ ' and d.devicetype = @D2'     
 if(@kid>0) set @fromstring = @fromstring+ ' and d.kid=@D1'     
   
 if(@kname!='') set @fromstring = @fromstring+ ' and k.kname like ''%''+@S1+''%'''      
 if(@firmw!='') set @fromstring = @fromstring+ ' and d.firmw = @S2'     
 if(@pcfirmw!='') set @fromstring = @fromstring+ ' and d.pcfirmw = @S3'     
       
 --分页查询    
 exec sp_MutiGridViewByPager    
  @fromstring = @fromstring,      --数据集    
  @selectstring =     
  ' d.devid,d.kid,d.sno,d.scode,d.maddr,d.saddr,d.adupt,d.msms,d.tsms,d.psms,d.interval,d.wifi,d.photo,d.firmw,d.daddr,d.pcfirmw,d.pcdaddr,k.kname,d.devicetype',      --查询字段    
  @returnstring =     
  ' devid,kid,sno,scode,maddr,saddr,adupt,msms,tsms,psms,interval,wifi,photo,firmw,daddr,pcfirmw,pcdaddr,kname,devicetype',      --返回字段    
  @pageSize = @Size,                 --每页记录数    
  @pageNo = @page,                     --当前页    
  @orderString = 'd.kid,d.devid ',          --排序条件    
  @IsRecordTotal = 1,             --是否输出总记录条数    
  @IsRowNo = 0,           --是否输出行号    
  @D1 = @kid,    
  @D2 = @devtype,    
  @S1 = @kname,    
  @S2 = @firmw,    
  @S3 = @pcfirmw     
      
end  
GO
