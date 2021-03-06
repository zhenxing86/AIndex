USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[deviceinfo_UpdateVersion_Batch]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- =============================================      
-- Author:  xzx      
-- Project: com.zgyey.ossapp      
-- Create date: 2013-11-14      
-- Description: 批量更新设备信息      
-- =============================================      
    
memo:    
exec deviceinfo_UpdateVersion_Batch    
@firmw ='http://tmcgw.zgyey.com/version/school_v2.0.6.zip',      
@daddr ='school_v2.0.6',      
@pcfirmw ='http://tmcgw.zgyey.com/version/pc_v1.1.zip',      
@pcdaddr ='pc_v1.1',    
@vtype =1, --0:固件版本，1：pc端版本    
@ftype =1, --0:所选记录，1：所有查询记录  （区分分页）    
@str ='',    
@kid =0,    
@kname ='',    
@sourpcfirmw ='pc_v1.9',    
@sourfirmw ='school_v2.0.3,  
@devtype =3',
@douserid= 135,
@ipaddress = '127.0.0.1'
*/    
CREATE PROCEDURE [dbo].[deviceinfo_UpdateVersion_Batch]      
@firmw nvarchar(150),      
@daddr nvarchar(150),      
@pcfirmw nvarchar(150),      
@pcdaddr nvarchar(150),    
@vtype int, --0:固件版本，1：pc端版本    
@ftype int, --0:所选记录，1：所有查询记录  （区分分页）    
@str varchar(8000),    
@kid int,    
@kname nvarchar(200),    
@sourpcfirmw nvarchar(150),    
@sourfirmw nvarchar(150),  
@devtype int=-1,
@douserid int =0,
@ipaddress nvarchar(150)=''
AS      
BEGIN      
  if(@ftype=0)    
  begin    
    CREATE TABLE #DevID(col nvarchar(40))      
    INSERT INTO #DevID      
   select distinct col  --将输入字符串转换为列表    
   from BasicData.dbo.f_split(@str,',')      
   
   Declare @ss table (id int,serialno nvarchar(50),devid nvarchar(9),
		kid int,sno nvarchar(50),scode nvarchar(32),
		maddr nvarchar(150),saddr nvarchar(150),adupt int,
		msms int,tsms int,psms int,interval int,
		wifi nvarchar(150),photo int,firmw nvarchar(150),
		daddr nvarchar(150),pcfirmw nvarchar(150),pcdaddr nvarchar(150),
		showphoto int,cardone int,playcname int,devicetype int)  
		 
   if(@vtype=0)    
		update d      
		 set firmw=@firmw,daddr=@daddr  
		 output inserted.id,inserted.serialno,inserted.devid,inserted.kid,inserted.sno,inserted.scode
			,inserted.maddr,inserted.saddr,inserted.adupt,inserted.msms,inserted.tsms,inserted.psms
			,inserted.interval,inserted.wifi,inserted.photo,inserted.firmw,inserted.daddr,inserted.pcfirmw
			,inserted.pcdaddr,inserted.showphoto,inserted.cardone,inserted.playcname,inserted.devicetype  
		 into @ss
	   from mcapp..driveinfo d    
	   inner join #DevID di on d.devid=di.col  
   else if(@vtype=1)  
	  update d      
		 set pcfirmw=@pcfirmw,pcdaddr=@pcdaddr  
		 output inserted.id,inserted.serialno,inserted.devid,inserted.kid,inserted.sno,inserted.scode
			,inserted.maddr,inserted.saddr,inserted.adupt,inserted.msms,inserted.tsms,inserted.psms
			,inserted.interval,inserted.wifi,inserted.photo,inserted.firmw,inserted.daddr,inserted.pcfirmw
			,inserted.pcdaddr,inserted.showphoto,inserted.cardone,inserted.playcname,inserted.devicetype  
		 into @ss
	   from mcapp..driveinfo d    
	   inner join #DevID di on d.devid=di.col      
	   where 1=1   
	
	if @@ROWCOUNT<=0    
	return -1   
	  
	insert into mcapp..driveinfo_log(serialno,devid,kid,sno,scode,maddr,saddr,adupt,msms,
	 tsms,psms,interval,wifi,photo,firmw,daddr,pcfirmw,
	 pcdaddr,showphoto,cardone,playcname,devicetype,douserid,dotime,ipaddress)
	select serialno,devid,kid,sno,scode,maddr,saddr,adupt,msms,
	 tsms,psms,interval,wifi,photo,firmw,daddr,pcfirmw,
	 pcdaddr,showphoto,cardone,playcname,devicetype,@douserid,GETDATE(),@ipaddress 
	  from  @ss
	  
   end     
   else if(@ftype=1)    
   begin    
		declare @updateString nvarchar(2000),@ParmDefinition nvarchar(1000)   
		if(@vtype=0)    
			 set @updateString ='update d      
			 set firmw=@firmw,daddr=@daddr 
			 output inserted.serialno,inserted.devid,inserted.kid,inserted.sno,inserted.scode
				,inserted.maddr,inserted.saddr,inserted.adupt,inserted.msms,inserted.tsms,inserted.psms
				,inserted.interval,inserted.wifi,inserted.photo,inserted.firmw,inserted.daddr,inserted.pcfirmw
				,inserted.pcdaddr,inserted.showphoto,inserted.cardone,inserted.playcname,inserted.devicetype,@douserid,getdate(),@ipaddress 
		   from mcapp..driveinfo d    
		   inner join basicdata..kindergarten k on d.kid=k.kid     
		   where 1=1'    
		else if(@vtype=1)    
			set @updateString ='update d      
			 set pcfirmw=@pcfirmw,pcdaddr=@pcdaddr    
			 output inserted.serialno,inserted.devid,inserted.kid,inserted.sno,inserted.scode
				,inserted.maddr,inserted.saddr,inserted.adupt,inserted.msms,inserted.tsms,inserted.psms
				,inserted.interval,inserted.wifi,inserted.photo,inserted.firmw,inserted.daddr,inserted.pcfirmw
				,inserted.pcdaddr,inserted.showphoto,inserted.cardone,inserted.playcname,inserted.devicetype,@douserid,getdate(),@ipaddress  
			   from mcapp..driveinfo d    
			   inner join basicdata..kindergarten k on d.kid=k.kid    
			   where 1=1'  
		     
		if(@kid>0) set @updateString=@updateString+'and d.kid=@kid'    
		if(@kname!='') set @updateString = @updateString+ ' and k.kname like ''%''+@kname+''%'''      
		if(@sourfirmw!='') set @updateString = @updateString+ ' and d.firmw = @sourfirmw'     
		if(@sourpcfirmw!='') set @updateString = @updateString+ ' and d.pcfirmw = @sourpcfirmw'  
		
		if(@devtype>=0) set @updateString = @updateString+ ' and d.devicetype = @devtype'  
		
		SET @ParmDefinition =     
		N' @kid INT = NULL,    
		  @kname varchar(150) = NULL,    
		  @firmw varchar(150) = NULL,    
		  @daddr varchar(150) = NULL,    
		  @pcfirmw varchar(150) = NULL,    
		  @pcdaddr varchar(150) = NULL,    
		  @sourfirmw varchar(150) = NULL,    
		  @sourpcfirmw varchar(150) = NULL,
		  @devtype int = NULL,
		  @douserid int = NULL,
		  @ipaddress varchar(150)= NULL'   
		  print @updateString
		    
		  insert into mcapp..driveinfo_log(serialno,devid,kid,sno,scode,maddr,saddr,adupt,msms,
			 tsms,psms,interval,wifi,photo,firmw,daddr,pcfirmw,
			 pcdaddr,showphoto,cardone,playcname,devicetype,douserid,dotime,ipaddress) 
		  EXEC SP_EXECUTESQL @updateString,@ParmDefinition,    
		   @kid = @kid,    
		   @kname = @kname,    
		   @firmw = @firmw,     
		   @daddr = @daddr,     
		   @pcfirmw = @pcfirmw,    
		   @pcdaddr = @pcdaddr,    
		   @sourfirmw = @sourfirmw,    
		   @sourpcfirmw = @sourpcfirmw,
		   @devtype = @devtype,
		   @douserid=@douserid,
		   @ipaddress = @ipaddress;    
	   
		  --print convert(varchar,@kid)+@kname+@firmw+@daddr+@pcfirmw+@pcdaddr+@sourfirmw+@sourpcfirmw    
		  --print @@ROWCOUNT
		      
		if @@ROWCOUNT<=0    
		 return -1  
	      
   end     
      
 exec config_manage_Update 9,1  --更新缓存    
 return 1    
END 


--  delete  mcapp..driveinfo_log
GO
