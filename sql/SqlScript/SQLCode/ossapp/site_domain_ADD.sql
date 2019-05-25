USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[site_domain_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[site_domain_ADD]
@siteid int,
@domain varchar(300)
as

IF EXISTS(SELECT * FROM KWebCMS..site_domain WHERE domain=@domain)
	BEGIN
		RETURN 0
	END	
	ELSE
	BEGIN
		insert into KWebCMS..site_domain(siteid,domain)
		values(@siteid,@domain)
	end

		IF @@ERROR <> 0
		BEGIN
			RETURN -1
		END
		ELSE
		BEGIN
			RETURN @@IDENTITY
		END






GO
