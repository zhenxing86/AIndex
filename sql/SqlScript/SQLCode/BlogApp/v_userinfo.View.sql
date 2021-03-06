USE [BlogApp]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW v_userinfo
AS
SELECT     bb.userid, u.account, u.nickname, u.privince AS province, u.city, u.regdatetime AS createdate, bb.postscount, bb.albumcount, bb.photocount,
                          (SELECT     COUNT(1) AS Expr1
                            FROM          AppLogs.dbo.log_login
                            WHERE      (userid = u.userid)) AS logincount, dbo.UserCommentMessageboardCount(ub.bloguserid) AS commentcount, k.kname, 
                      u.usertype AS blogtype, k.kid, bb.isstart
FROM         BasicData.dbo.[user] AS u INNER JOIN
                      BasicData.dbo.user_bloguser AS ub ON u.userid = ub.userid INNER JOIN
                      dbo.blog_baseconfig AS bb ON ub.bloguserid = bb.userid LEFT OUTER JOIN
                      BasicData.dbo.kindergarten AS k ON u.kid = k.kid
WHERE     u.deletetag = 1
GO