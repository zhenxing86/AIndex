USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[UpdateGartenInfo]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[UpdateGartenInfo]
@kid int,
@garten_desc nvarchar(4000),
@m_garten_photo nvarchar(200)
 AS 	


	if(exists(select * from garteninfo where kid=@kid))
	begin
		update garteninfo set garten_desc=@garten_desc,m_garten_photo=@m_garten_photo where kid=@kid
	end
	else
	begin
		insert into garteninfo(hbid,garten_desc,m_garten_photo,kid)
		values(0,@garten_desc,@m_garten_photo,@kid)
	end

	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN (-1)
	END
	ELSE
	BEGIN	
	   RETURN (1)
	END







GO
