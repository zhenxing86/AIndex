USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetMaxEnorlNum]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,取最大登记号>
-- =============================================
create PROCEDURE [dbo].[GetMaxEnorlNum] 	
	@KID int,
	@EnrolNum int output
AS
BEGIN
select @EnrolNum = EnrolNum from EnrolNumTable where kid = @KID
update EnrolNumTable set enrolnum = enrolnum-1 where kid = @KID

END


GO
