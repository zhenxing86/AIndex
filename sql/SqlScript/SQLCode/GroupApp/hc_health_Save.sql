USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hc_health_Save]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
    
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: 4.2 填写疾病史, 4.2 疫苗接种  
-- =============================================  
CREATE PROCEDURE [dbo].[hc_health_Save]  
@userid bigint,  
@hid int,  
@state smallint,   
@types Varchar(50) = '',   
@disease Varchar(50) = ''  
AS    
    
SET NOCOUNT ON;    
  
if @hid > 0  
begin  
  if Not Exists (Select * From hc_user_health Where userid = @userid and hid = @hid)  
    Insert Into hc_user_health(userid, hid, status) Values(@userid, @hid, @state)  
  else  
    Update hc_user_health Set status = @state Where userid = @userid and hid = @hid  
end  
else if @disease = '' and (not(Isnull(@hid, 0) > 0))  
begin  
  Delete a  
    From hc_user_health a, hc_health b  
    Where a.hid = b.hid and b.custom_user = @userid and a.userid = @userid and b.[types] = @types   
  
  Delete hc_health Where custom_user = @userid  
end  
  
else if @disease <> '' and (not(Isnull(@hid, 0) > 0))  
begin  
  if not Exists (Select * From hc_user_health a, hc_health b Where a.hid = b.hid and b.custom_user = @userid and a.userid = @userid and b.[types] = @types)  
  begin  
    Insert Into hc_health([types], title, custom_user)  
      Values(@types, @disease, @userid)  
    Select @hid = scope_identity()  
  
    Insert Into hc_user_health(userid, hid, status) Values(@userid, @hid, @state)  
  end  
  else begin   
    Update hc_health Set title = @disease Where custom_user = @userid and [types] = @types   
  end  
end  
  
Select 1  
  
  
GO
