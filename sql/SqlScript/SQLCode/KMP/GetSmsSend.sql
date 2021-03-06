USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetSmsSend]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,短信发送情况>
-- =============================================
create PROCEDURE [dbo].[GetSmsSend] 
	@sd nvarchar(30),
	@ed nvarchar(30)
AS
BEGIN
	SET NOCOUNT ON;

select kid as 幼儿园,cid as 班级,recmobile as 接收手机,[content]as 内容,sendtime as 发送时间,
case status when 1 then '已发送' else '未发送' end  as 状态 
from t_smsmessage_Emay where sendtime between @sd and @ed 
order by sendtime desc
END

GO
