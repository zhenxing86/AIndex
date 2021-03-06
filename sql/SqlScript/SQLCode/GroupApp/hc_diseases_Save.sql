USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hc_diseases_Save]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  
CREATE PROCEDURE [dbo].[hc_diseases_Save] 
@userid bigint,
@hid int,
@status smallint
AS  
  
SET NOCOUNT ON;  

if Not Exists (Select * From hc_user_health Where userid = @userid and hid = @hid)
  Insert Into hc_user_health(userid, hid, status) Values(@userid, @hid, @status)
else
  Update hc_user_health Set status = @status Where userid = @userid and hid = @hid

if scope_identity() > 0
  Select 1
else 
  Select 0



GO
