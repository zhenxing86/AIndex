USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetKinReport]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,最新加入幼儿园报表>
-- =============================================
CREATE PROCEDURE [dbo].[GetKinReport] 
	@sd nvarchar(30),
	@ed nvarchar(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select id, name as 幼儿园名,url as 网址,dbo.AreaCaptionFromID(Privince) as 所在省,dbo.AreaCaptionFromID(City) as 所在市,Address as 地址,Phone as 电话,Memo as 备注,ActionDate as 注册日期,theme as 所用模板,smsnum as 短信条数,linkman as 联系人,contractphone as 联系电话, qq as QQ, email as email  
	from t_kindergarten 
	where actiondate between @sd and @ed
	order by id desc
END


GO
