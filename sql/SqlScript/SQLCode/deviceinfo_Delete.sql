USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[deviceinfo_Delete]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
    
-- =============================================    
-- Author:  xzx    
-- Project: com.zgyey.ossapp    
-- Create date: 2013-06-08    
-- Description: 新增    
-- =============================================    
CREATE PROCEDURE [dbo].[deviceinfo_Delete]    
@id int,  
@douserid int =0,    
@ipaddress nvarchar(150)=''     
AS    
BEGIN    
    
 update d set deletetag=0     
 --Delete mcapp..driveinfo   
  Output Deleted.devid,Deleted.kid,Deleted.sno,Deleted.scode,Deleted.maddr,Deleted.saddr,        
   Deleted.adupt,Deleted.interval,Deleted.wifi,Deleted.photo,Deleted.firmw,Deleted.daddr,Deleted.pcfirmw,        
   Deleted.pcdaddr,Deleted.serialno,Deleted.showphoto,Deleted.cardone,Deleted.playcname,Deleted.devicetype,@douserid,GETDATE(),@ipaddress      
  Into [mcapp].[dbo].driveinfo_log( devid,kid,sno,scode,maddr,saddr,        
   adupt,interval,wifi,photo,firmw,daddr,pcfirmw,pcdaddr,        
   serialno,showphoto,cardone,playcname,devicetype,douserid,dotime,ipaddress)     
 from mcapp..driveinfo d    
 where id= @id        
   
 if @@ERROR<>0    
 return -1    
 else     
    return 1    
    
END 
GO
