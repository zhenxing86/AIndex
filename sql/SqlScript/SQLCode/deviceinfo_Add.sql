use ossapp
go
-- =============================================      
-- Author:  xzx      
-- Project: com.zgyey.ossapp      
-- Create date: 2013-06-08      
-- Description: 新增      
-- =============================================      
alter PROCEDURE [dbo].[deviceinfo_Add]         
@devid nvarchar(9),      
@kid int,      
@sno nvarchar(50),      
@scode nvarchar(32),      
@maddr nvarchar(150),      
@saddr nvarchar(150),      
@adupt int,      
@interval int,      
@wifi nvarchar(50),      
@photo int,      
@firmw nvarchar(50),      
@daddr nvarchar(150),      
@pcfirmw nvarchar(50),      
@pcdaddr nvarchar(150),      
@serialno nvarchar(50)='',      
@showphoto int=0,        
@cardone int=0  ,        
@playcname int=0  ,      
@devicetype int=0,    
@douserid int =0,      
@ipaddress nvarchar(150)=''      
AS      
BEGIN      
      
insert into mcapp..driveinfo(devid,kid,sno,scode,maddr,saddr,      
 adupt,interval,wifi,photo,firmw,daddr,pcfirmw,pcdaddr,      
 serialno,showphoto,cardone,playcname,devicetype)      
 values(@devid,@kid,@sno,@scode,@maddr,@saddr,      
  @adupt,@interval,@wifi,@photo,@firmw,@daddr,@pcfirmw,      
  @pcdaddr,@serialno,@showphoto,@cardone,@playcname,@devicetype)      
     
 insert into mcapp..driveinfo_log(devid,kid,sno,scode,maddr,saddr,      
 adupt,interval,wifi,photo,firmw,daddr,pcfirmw,pcdaddr,      
 serialno,showphoto,cardone,playcname,devicetype,douserid,dotime,ipaddress)       
 select @devid,@kid,@sno,@scode,@maddr,@saddr,      
  @adupt,@interval,@wifi,@photo,@firmw,@daddr,@pcfirmw,      
  @pcdaddr,@serialno,@showphoto,@cardone,@playcname,@devicetype,@douserid,GETDATE(),@ipaddress    
          
 if( @devid like '%30')      
    exec mcapp..TransferCardListTocardinfo @kid = @kid       
          
exec config_manage_Update 9,1  