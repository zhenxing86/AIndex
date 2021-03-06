USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[deviceinfo_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================        
-- Author:  xzx        
-- Project: com.zgyey.ossapp        
-- Create date: 2013-06-08        
-- Description: 更新设备信息        
-- =============================================        
alter PROCEDURE [dbo].[deviceinfo_Update]        
@devid nvarchar(9),   
@tbdevid nvarchar(50),        
@kid int,        
@sno nvarchar(50),        
@scode nvarchar(32),        
@maddr nvarchar(150),        
@saddr nvarchar(150),        
@adupt int,        
@msms int,        
@tsms int,        
@psms int,        
@interval int,        
@wifi nvarchar(50),        
@photo int,        
@firmw nvarchar(50),        
@daddr nvarchar(150),        
@pcfirmw nvarchar(50),        
@pcdaddr nvarchar(150),        
@serialno nvarchar(50),        
@id int,        
@showphoto int=0  ,        
@cardone int=0  ,        
@playcname int=0,    
@devicetype int=0,  
@douserid int =0,    
@ipaddress nvarchar(150)=''         
AS        
BEGIN        
        
 update mcapp..driveinfo         
 set devid=@devid,tbdevid=@tbdevid,kid=@kid,sno=@sno,scode=@scode,maddr=@maddr,        
 saddr=@saddr,adupt=@adupt,msms=@msms,tsms=@tsms,psms=@psms,        
 interval=@interval,wifi=@wifi,photo=@photo,firmw=@firmw,        
 daddr=@daddr,pcfirmw=@pcfirmw,pcdaddr=@pcdaddr,serialno=@serialno,      
 showphoto=@showphoto, cardone=@cardone,playcname=@playcname,devicetype=@devicetype      
    where id = @id        
   
 insert into mcapp..driveinfo_log(devid,tbdevid,kid,sno,scode,maddr,saddr,    
 adupt,interval,wifi,photo,firmw,daddr,pcfirmw,pcdaddr,    
 serialno,showphoto,cardone,playcname,devicetype,douserid,dotime,ipaddress)     
 select @devid,@tbdevid,@kid,@sno,@scode,@maddr,@saddr,    
  @adupt,@interval,@wifi,@photo,@firmw,@daddr,@pcfirmw,    
  @pcdaddr,@serialno,@showphoto,@cardone,@playcname,@devicetype,@douserid,GETDATE(),@ipaddress  
      
 if( @devid like '%30')    
    exec mcapp..TransferCardListTocardinfo @kid = @kid     
          
    exec config_manage_Update 9,1  --更新缓存        
END  