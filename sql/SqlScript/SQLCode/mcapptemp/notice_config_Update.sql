USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[notice_config_Update]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[notice_config_Update]
@kid int
,@contents nvarchar(500)
,@outtime datetime
 AS 
 
 if(exists(select 1 from notice_config where kid=@kid))
 begin
 update notice_config set contents=@contents,outtime=@outtime where kid=@kid
 
 end
 else
 begin
 
 insert into notice_config(kid,contents,outtime) values (@kid,@contents,@outtime )
 
 end
 
 INSERT INTO [mcapp].[dbo].[querycmd]([kid],[devid],[querytag],[adatetime],[syndatetime],[status])
 SELECT @kid,[devid],6,getdate(),getdate()+0.01,1 FROM [mcapp].[dbo].[driveinfo] where kid=@kid
  

 

GO
