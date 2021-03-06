USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_child_checked_detail_GetModel]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-04-20  
-- Description:   
-- Memo:  
--查询日期当日的晨检数据需要累积至统计数据中
--最近3个月晨检情况内容的组织格式描述如下：
--晨检健康天数：	**天
--未晨检天数：		**天
--晨检异常天数：	**天
--晨检异常症状名称：{异常次数}次
--[晨检异常症状名称：{异常次数}次。。。]
EXEC rep_mc_child_checked_detail_GetModel 12511,295765,'2013-09-20'     
*/    
CREATE PROCEDURE [dbo].[rep_mc_child_checked_detail_GetModel]
	@kid int    
 ,@stuid int    
 ,@cdate1 datetime    
AS     
BEGIN     
SET NOCOUNT ON 

DECLARE @EnterDate datetime, @uname varchar(50), @cname varchar(50),
				@Isweak bit, @degree int,@SEX varchar(10),@headpicupdate datetime,@headpic NVARCHAR(400)

select @EnterDate = ISNULL(MIN(udate),GETDATE()) from cardinfo where userid = @stuid				
SELECT	@uname = U.name, @cname = uc.cname, 
				@Isweak = ISNULL(zc.Isweak,0),@SEX = uc.sex, @headpicupdate = u.headpicupdate, @headpic = u.headpic
  FROM  [BasicData]..[user] u 
		inner join [BasicData]..User_Child uc 
			on u.userid = uc.userid
		LEFT join zz_counter zc 
			on u.userid = zc.userid 	
	WHERE u.userid = @stuid		

set @degree = 5
	
select top(1) @degree = degree  
	from rep_mc_child_week 
	where userid = @stuid 
	order by cdate desc

;WITH CET AS
(
	select @uname uname, @cname cname, rm.result, CONVERT(VARCHAR(10),rm.checktime,120) cdate,rm.status,
			case when (','+rm.result like '%,1,%') then 1 else 0 end fs,  --发烧
			case when (','+rm.result like '%,2,%') then 1 else 0 end ks,  --咳嗽
			case when (','+rm.result like '%,3,%') then 1 else 0 end hlfy,--喉咙发炎  
			case when (','+rm.result like '%,4,%') then 1 else 0 end lbt, --流鼻涕  
			case when (','+rm.result like '%,5,%') then 1 else 0 end pz,  --皮疹  
			case when (','+rm.result like '%,6,%') then 1 else 0 end fx,  --腹泻   
			case when (','+rm.result like '%,7,%') then 1 else 0 end hy,  --红眼病 
			case when (','+rm.result like '%,8,%') then 1 else 0 end szk, --重点观察   
			case when (','+rm.result like '%,9,%') then 1 else 0 end jzj, --剪指甲   
			case when (','+rm.result like '%,10,%') then 1 else 0 end fytx, --服药提醒   
			case when (','+rm.result like '%,11,%') then 1 else 0 end parentstake --家长带回 	
		from rep_mc_child_checked_detail rm 
			where rm.checktime >= CONVERT(VARCHAR(7),DATEADD(MM,-2,@cdate1),120)+'-01'
			AND rm.checktime <= CONVERT(VARCHAR(10),@cdate1,120)
			and rm.kid = @kid
			AND rm.checktime > @EnterDate
			and rm.userid = @stuid	
)
,CET1 AS
(
select uname, cname,sum(fs)fs,sum(ks)ks,sum(hlfy)hlfy,sum(lbt)lbt,
				 sum(pz)pz,sum(fx)fx,sum(hy)hy,sum(szk)szk,sum(jzj)jzj,
				 sum(fytx)fytx,sum(parentstake)parentstake,
				 SUM(CASE WHEN status = 0 then 1 else 0 end)healthcnt,	
				 SUM(CASE WHEN status = 1 then 1 else 0 end)sickcnt,	
				 SUM(CASE WHEN cdate is null then 1 else 0 end)uncheckcnt
				 	
		FROM CET
		GROUP BY uname, cname
) SELECT uname, cname, healthcnt, sickcnt, uncheckcnt,
		case when fs > 0 then '发烧<span class="red">('+CAST(fs as varchar(10))+')</span>' ELSE '' END
		+case when ks > 0 then '咳嗽<span class="red">('+CAST(ks as varchar(10))+')</span>' ELSE '' END
		+case when hlfy > 0 then '喉咙发炎<span class="red">('+CAST(hlfy as varchar(10))+')</span>' ELSE '' END
		+case when lbt > 0 then '流鼻涕<span class="red">('+CAST(lbt as varchar(10))+')</span>' ELSE '' END
		+case when pz > 0 then '皮疹<span class="red">('+CAST(pz as varchar(10))+')</span>' ELSE '' END
		+case when fx > 0 then '腹泻<span class="red">('+CAST(fx as varchar(10))+')</span>' ELSE '' END
		+case when hy > 0 then '红眼病<span class="red">('+CAST(hy as varchar(10))+')</span>' ELSE '' END
		+case when szk > 0 then '重点观察<span class="red">('+CAST(szk as varchar(10))+')</span>' ELSE '' END
		+case when jzj > 0 then '剪指甲<span class="red">('+CAST(jzj as varchar(10))+')</span>' ELSE '' END
		+case when fytx > 0 then '服药提醒<span class="red">('+CAST(fytx as varchar(10))+')</span>' ELSE '' END
		+case when parentstake > 0 then '家长带回<span class="red">('+CAST(parentstake as varchar(10))+')</span>' ELSE '' END AS detail,
		 @Isweak isweak, @degree degree,		 
		content = 
		 CASE WHEN @degree = 5 THEN uname + '小朋友最近身体很棒，希望继续保持哦！'
					WHEN @degree = 4 THEN uname + '小朋友最近身体健康，需要注意：症状名称偏多 '+
						case when fs > 0 then '发烧('+CAST(fs as varchar(10))+')' ELSE '' END
						+case when ks > 0 then '咳嗽('+CAST(ks as varchar(10))+')' ELSE '' END
						+case when hlfy > 0 then '喉咙发炎('+CAST(hlfy as varchar(10))+')' ELSE '' END
						+case when lbt > 0 then '流鼻涕('+CAST(lbt as varchar(10))+')' ELSE '' END
						+case when pz > 0 then '皮疹('+CAST(pz as varchar(10))+')' ELSE '' END
						+case when fx > 0 then '腹泻('+CAST(fx as varchar(10))+')' ELSE '' END
						+case when szk > 0 then '重点观察('+CAST(szk as varchar(10))+')' ELSE '' END
						+case when jzj > 0 then '剪指甲('+CAST(jzj as varchar(10))+')' ELSE '' END
						+case when fytx > 0 then '服药提醒('+CAST(fytx as varchar(10))+')' ELSE '' END
						+case when parentstake > 0 then '家长带回('+CAST(parentstake as varchar(10))+')' ELSE '' END +						
						 CASE WHEN jzj > 0 then ' 请提醒家长定期为孩子修剪指甲!' ELSE '' END					
					WHEN @degree = 3 THEN 
							'近期' + uname + '小朋友晨检健康状况一般，'+ case when hy > 0 THEN '出现过红眼症状，' ELSE '' END
						+ CASE WHEN uncheckcnt > 3 THEN  '缺勤次数比较多（缺勤次数'+CAST(uncheckcnt as varchar(10))+'次），' ELSE '' END
						+	'需要注意：'+case when fs > 0 then '发烧('+CAST(fs as varchar(10))+')' ELSE '' END
						+case when ks > 0 then '咳嗽('+CAST(ks as varchar(10))+')' ELSE '' END
						+case when hlfy > 0 then '喉咙发炎('+CAST(hlfy as varchar(10))+')' ELSE '' END
						+case when lbt > 0 then '流鼻涕('+CAST(lbt as varchar(10))+')' ELSE '' END
						+case when pz > 0 then '皮疹('+CAST(pz as varchar(10))+')' ELSE '' END
						+case when fx > 0 then '腹泻('+CAST(fx as varchar(10))+')' ELSE '' END
						+case when szk > 0 then '重点观察('+CAST(szk as varchar(10))+')' ELSE '' END
						+case when jzj > 0 then '剪指甲('+CAST(jzj as varchar(10))+')' ELSE '' END
						+case when fytx > 0 then '服药提醒('+CAST(fytx as varchar(10))+')' ELSE '' END
						+case when parentstake > 0 then '家长带回('+CAST(parentstake as varchar(10))+')' ELSE '' END
						+' 请老师特别关注'+CASE WHEN @SEX = '女' THEN '她' ELSE '他' END +'的在园情况'
						+CASE WHEN jzj > 0 then '并提醒家长定期为孩子修剪指甲，保持良好的个人卫生！' ELSE '！' END
					ELSE '' END, @headpicupdate AS headpicupdate, @headpic AS headpic		 
		from CET1	

END

GO
