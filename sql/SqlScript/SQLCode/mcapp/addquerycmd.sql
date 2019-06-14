USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[addquerycmd]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







--[addquerycmd] '001715001',17150,1
--[addquerycmd] '001251102',12511,10
--[addquerycmd] '001251100',12511,2
--[addquerycmd] '001251100',12511,3
CREATE PROCEDURE [dbo].[addquerycmd]
@devid varchar(9),
@kid int,
@querytag varchar(20)

as

if(@querytag=1)
begin
	delete from stuid_tmp where devid=@devid
end
else if(@querytag=2)
begin
	delete from teaid_tmp where devid=@devid
end
else if(@querytag=9)
begin
	delete from stuid_tmp where devid=@devid
	delete from teaid_tmp where devid=@devid
end


INSERT INTO [mcapp].[dbo].[querycmd]
           ([kid]
           ,[devid]
           ,[querytag]
           ,[adatetime]
           ,[syndatetime]
           ,[status])
     VALUES
           (@kid
           ,@devid
           ,@querytag
           ,getdate()
           ,getdate()+0.01
           ,1)





GO
