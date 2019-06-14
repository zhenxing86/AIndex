USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[addmcappdatamonitor]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--exec [addmcappdatamonitor] @kid

CREATE PROCEDURE [dbo].[addmcappdatamonitor]

@kid int

as

if(exists(select kid from mcapp..driveinfo where kid=@kid ))
begin
INSERT INTO [mcapp].[dbo].[datamonitor]
           ([kid])
     VALUES
           (@kid)
end



GO
