USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_getfailphonecount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2011-4-18
-- Description:	无效手机号码数量
-- =============================================
CREATE PROCEDURE [dbo].[kmp_getfailphonecount]
@KID int,
@KName nvarchar(1000)
AS
declare @result int
            SELECT @result=COUNT(*)
			FROM KMP..T_Child d
			INNER JOIN KMP..Sms_userMobile s ON d.UserID=s.userid
			INNER JOIN KMP..T_Kindergarten k ON d.KindergartenID=k.ID
			WHERE k.ID=CASE @KID WHEN 0 THEN k.ID ELSE @KID END
            AND (len(s.Mobile)!=11 OR (substring(s.Mobile,1,2) NOT IN ('13','15','18')))
			AND k.[Name] LIKE '%'+@KName+'%'

			SELECT @result=@result+COUNT(*)
			FROM KMP..T_Staffer d 
			INNER JOIN KMP..Sms_userMobile s ON d.UserID=s.userid
			INNER JOIN KMP..T_Kindergarten k ON d.KindergartenID=k.ID
			WHERE k.ID=CASE @KID WHEN 0 THEN k.ID ELSE @KID END
			AND k.[Name] LIKE '%'+@KName+'%'
            AND (len(s.Mobile)!=11 OR (substring(s.Mobile,1,2) NOT IN ('13','15','18')))
RETURN @result



GO
