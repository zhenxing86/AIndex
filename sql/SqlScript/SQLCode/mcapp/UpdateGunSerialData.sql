USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[UpdateGunSerialData]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*      
-- Author:      xie  
-- Create date: 2014-01-15      
-- Description:       
-- Memo:        
exec UpdateGunSerialData 12511,'13010001,13010002','001251100' 

13082001	19636
13082001,13008901

select *from tcf_setting where kid=12511 and serialno in('13010002','13087014')   
select *From mcapp..loginfo_ex where kid = 12511 and uploadtime>='2014-10-24'
*/      
CREATE PROCEDURE [dbo].[UpdateGunSerialData]      
@kid int        
,@str varchar(8000) 
,@devid varchar(50) =''   
 AS       
begin    
 SET NOCOUNT ON  
 DECLARE @s1 varchar(8000)
  CREATE TABLE #SerialNo(col nvarchar(40))  
    
 INSERT INTO #SerialNo  
 select distinct col  --将输入字符串转换为列表  
   from BasicData.dbo.f_split(@str,',')  
  
 update t   
     set kid=@kid  
  Output Deleted.serialno,@kid,Deleted.xmsj,Deleted.lsavesj,Deleted.gunnum    
  ,Deleted.devid,Deleted.alarmt,Deleted.tox,Deleted.tax,Deleted.tx0A,Deleted.tx0B,Deleted.t5A    
  ,Deleted.t5B,Deleted.t10A,Deleted.t10B,Deleted.t15A,Deleted.t15B,Deleted.t20A,Deleted.t20B    
  ,Deleted.t25A,Deleted.t25B,Deleted.t30A,Deleted.t30B,Deleted.t35A,Deleted.t35B,Deleted.t40A    
  ,Deleted.t40B,Deleted.td40A,Deleted.td40B,Deleted.tx0C,Deleted.tx0,Deleted.t5C    
  ,Deleted.t5,Deleted.t10C,Deleted.t10,Deleted.t15C,Deleted.t15,Deleted.t20C,Deleted.t20    
  ,Deleted.t25C,Deleted.t25,Deleted.t30C,Deleted.t30,Deleted.t35C,Deleted.t35,Deleted.t40C    
  ,Deleted.t40,Deleted.td40C,Deleted.td40,Deleted.txMaxTW,Deleted.txMaxDif,Deleted.t25x1,  
  Deleted.t25x2,Deleted.t25y1,Deleted.t25y2,0,GETDATE()  
 into [mcapp].[dbo].[tcf_setting_log]([serialno],[kid],[xmsj],[lsavesj],[gunnum]    
  ,[devid],[alarmt],[tox],[tax],[tx0A],[tx0B],[t5A]    
  ,[t5B],[t10A],[t10B],[t15A],[t15B],[t20A],[t20B]    
  ,[t25A],[t25B],[t30A],[t30B],[t35A],[t35B],[t40A]    
  ,[t40B],[td40A],[td40B],[tx0C],[tx0],[t5C]    
  ,[t5],[t10C],[t10],[t15C],[t15],[t20C],[t20]    
  ,[t25C],[t25],[t30C],[t30],[t35C],[t35],[t40C]    
  ,[t40],[td40C],[td40],[txMaxTW],[txMaxDif],t25x1,t25x2,t25y1,t25y2,douserid,dotime)  
  FROM tcf_setting t   
  inner join #SerialNo ci   
   on t.serialno = ci.col  
   and t.kid <> @kid   
 
 set @s1 = '更换晨检枪归属：'+ @str
 exec mcapp..LogInfo_Ex_Add @kid,@devid,10,3,@s1
     
 IF @@ERROR<> 0  
 RETURN -1   
 else  
 return 1  
  
end  
GO
