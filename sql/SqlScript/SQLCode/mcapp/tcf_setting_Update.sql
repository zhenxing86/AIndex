USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[tcf_setting_Update]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
-- =============================================  
-- Author:  xzx  
-- Project: com.zgyey.ossapp  
-- Create date: 2013-07-22  
-- Description: 修改晨检枪参数设备信息  
-- =============================================  
CREATE PROCEDURE [dbo].[tcf_setting_Update]  
@id int  
,@serialno varchar(50)  
,@kid int  
,@xmsj varchar(50)  
,@lsavesj varchar(50)  
,@gunnum varchar(50)  
,@devid varchar(50)  
,@alarmt varchar(50)  
,@tox varchar(50)  
,@tax varchar(50)  
,@tx0A varchar(50)  
,@tx0B varchar(50)  
,@t5A varchar(50)  
,@t5B varchar(50)  
,@t10A varchar(50)  
,@t10B varchar(50)  
,@t15A varchar(50)  
,@t15B varchar(50)  
,@t20A varchar(50)  
,@t20B varchar(50)  
,@t25A varchar(50)  
,@t25B varchar(50)  
,@t30A varchar(50)  
,@t30B varchar(50)  
,@t35A varchar(50)  
,@t35B varchar(50)  
,@t40A varchar(50)  
,@t40B varchar(50)  
,@td40A varchar(50)  
,@td40B varchar(50)  
  
,@tx0C varchar(50)  
,@tx0 varchar(50)  
,@t5C varchar(50)  
,@t5 varchar(50)  
,@t10C varchar(50)  
,@t10 varchar(50)  
,@t15C varchar(50)  
,@t15 varchar(50)  
,@t20C varchar(50)  
,@t20 varchar(50)  
,@t25C varchar(50)  
,@t25 varchar(50)  
,@t30C varchar(50)  
,@t30 varchar(50)  
,@t35C varchar(50)  
,@t35 varchar(50)  
,@t40C varchar(50)  
,@t40 varchar(50)  
,@td40C varchar(50)  
,@td40 varchar(50)  
,@txMaxTW varchar(50)  
,@txMaxDif varchar(50)  
,@t25x1 varchar(50)  
,@t25x2 varchar(50)  
,@t25y1 varchar(50)  
,@t25y2 varchar(50)  
,@douserid int =0   
,@ipaddress nvarchar(150)=''   
AS  
BEGIN  
  
UPDATE [mcapp]..[tcf_setting]  
 SET [serialno] = @serialno,[kid] = @kid  
  ,[xmsj] = @xmsj,[lsavesj] = @lsavesj,[gunnum] = @gunnum  
  ,[devid] = @devid,[alarmt] = @alarmt,[tox] = @tox  
  ,[tax] = @tax,[tx0A] = @tx0A,[tx0B] = @tx0B  
  ,[t5A] = @t5A,[t5B] = @t5B,[t10A] = @t10A,[t10B] = @t10B  
  ,[t15A] = @t15A,[t15B] = @t15B,[t20A] = @t20A  
  ,[t20B] = @t20B,[t25A] = @t25A,[t25B] = @t25B  
  ,[t30A] = @t30A,[t30B] = @t30B,[t35A] = @t35A  
  ,[t35B] = @t35B,[t40A] = @t40A,[t40B] = @t40B  
  ,[td40A] = @td40A,[td40B] = @td40B,[tx0C] = @tx0C,[tx0] = @tx0  
  ,[t5C] = @t5C,[t5] = @t5,[t10C] = @t10C,[t10] = @t10  
  ,[t15C] = @t15C,[t15] = @t15,[t20C] = @t20C  
  ,[t20] = @t20,[t25C] = @t25C,[t25] = @t25  
  ,[t30C] = @t30C,[t30] = @t30,[t35C] = @t35C  
  ,[t35] = @t35,[t40C] = @t40C,[t40] = @t40  
  ,[td40C] = @td40C,[td40] = @td40,txMaxTW=@txMaxTW,txMaxDif=@txMaxDif  
  ,[t25x1] = @t25x1,[t25x2] = @t25x2,t25y1=@t25y1,t25y2=@t25y2  
 WHERE id = @id 
 
 insert into [mcapp]..[tcf_setting_log]([serialno],[kid],[xmsj],[lsavesj],[gunnum]  
  ,[devid],[alarmt],[tox],[tax],[tx0A],[tx0B],[t5A]  
  ,[t5B],[t10A],[t10B],[t15A],[t15B],[t20A],[t20B]  
  ,[t25A],[t25B],[t30A],[t30B],[t35A],[t35B],[t40A]  
  ,[t40B],[td40A],[td40B],[tx0C],[tx0],[t5C]  
  ,[t5],[t10C],[t10],[t15C],[t15],[t20C],[t20]  
  ,[t25C],[t25],[t30C],[t30],[t35C],[t35],[t40C]  
  ,[t40],[td40C],[td40],[txMaxTW],[txMaxDif],t25x1,t25x2,t25y1,t25y2,douserid,dotime,ipaddress)    
 values(@serialno,@kid,@xmsj,@lsavesj,@gunnum  
  ,@devid,@alarmt,@tox,@tax,@tx0A,@tx0B,@t5A  
  ,@t5B,@t10A,@t10B,@t15A,@t15B,@t20A,@t20B  
  ,@t25A,@t25B,@t30A,@t30B,@t35A,@t35B,@t40A  
  ,@t40B,@td40A,@td40B,@tx0C,@tx0,@t5C  
  ,@t5,@t10C,@t10,@t15C,@t15,@t20C,@t20  
  ,@t25C,@t25,@t30C,@t30,@t35C,@t35,@t40C  
  ,@t40,@td40C,@td40,@txMaxTW,@txMaxDif,@t25x1,@t25x2,@t25y1,@t25y2,@douserid,GETDATE(),@ipaddress)  
  
   
END  
GO
