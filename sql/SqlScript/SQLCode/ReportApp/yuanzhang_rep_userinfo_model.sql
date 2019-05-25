USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[yuanzhang_rep_userinfo_model]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--[yuanzhang_rep_Child_Info_GetList] 12021,677427
CREATE PROCEDURE [dbo].[yuanzhang_rep_userinfo_model] 
@kid int,
@userid int
as 

DECLARE @ptype_photo int,@noread int

SELECT  @ptype_photo=count(1) FROM blogapp..permissionsetting
 WHERE kid=@kid and ptype=72
 
select @noread=count(1) 
	FROM AndroidApp..and_msg_detail m
		inner join AndroidApp..and_msg a
			on m.sms_id=a.ID
		  where m.userid=@userid 
				and m.readstate=0 
				and m.deletetag=1
				and m.channel_id is  null
				and a.send_status=1
 
select kname,@ptype_photo,@noread from BasicData..kindergarten 
where kid=@kid 
		

GO
