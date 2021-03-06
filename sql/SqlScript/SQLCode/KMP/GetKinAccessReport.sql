USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetKinAccessReport]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,幼儿园访问报表>
-- =============================================
CREATE PROCEDURE [dbo].[GetKinAccessReport] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select s.ip as 来自ip, s.createtime as 访问时间, kin.name as 幼儿园 from siteaccessdetail s left join t_kindergarten kin on s.kid=kin.id group by kin.name, s.ip, s.createtime order by createtime desc
END

GO
