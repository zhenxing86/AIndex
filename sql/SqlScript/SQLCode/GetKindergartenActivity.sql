USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[GetKindergartenActivity]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[GetKindergartenActivity]    
@kid int,    
@status Varchar(50),    
@linkstate Varchar(50),     
@infofrom  Varchar(50),    
@developer  Varchar(50),    
@begdate datetime,    
@enddate datetime,    
@Size Int,    
@page Int    
as    
Set Nocount On     
if Isnull(@begdate, '') = '' Select @begdate = '2000-01-01'    
if Isnull(@enddate, '') = '' Select @enddate = Convert(varchar(10), getdate(), 120)    
Select @enddate = dateadd(dd, 1, @enddate)    
    
Select a.kid, a.kname, a.address, a.remark, a.qq, a.mobile, b.name, Cast(0 as int) class_album, Cast(0 as int) class_notice, Cast(0 as int) class_photos,    
       Cast(0 as int) class_schedule, Cast(0 as int) class_video, Cast(0 as int) cms_album, Cast(0 as int) cms_content,     
       Cast(0 as int) cms_photo, Cast(0 as int) cms_contentattachs    
  Into #k    
  From ossapp.dbo.kinbaseinfo a Left Join ossapp.dbo.users b On a.developer = b.id    
  Where (isnull(@kid, '') = '' Or a.kid = @kid)    
    and (isnull(@status, '') = '' Or a.status = @status)    
    and (isnull(@linkstate, '') = '' Or a.linkstate = @linkstate)    
    and (isnull(@infofrom, '') = '' Or a.infofrom = @infofrom)    
    and (isnull(@developer, '') = '' Or b.name = @developer)    
  
Update #k Set class_album = b.class_album    
  From #k a, (Select kid, Count(*) class_album From ClassApp.dbo.class_album Where createdatetime Between @begdate and @enddate Group by kid) b    
  Where a.kid = b.kid    
    
Update #k Set class_notice = b.class_notice    
  From #k a, (Select kid, Count(*) class_notice From ClassApp.dbo.class_notice Where createdatetime Between @begdate and @enddate Group by kid) b    
  Where a.kid = b.kid    
    
Update #k Set class_photos = b.class_photos    
  From #k a, (Select kid, Count(*) class_photos From ClassApp.dbo.class_photos Where uploaddatetime Between @begdate and @enddate Group by kid) b    
  Where a.kid = b.kid    
    
Update #k Set class_schedule = b.class_schedule    
  From #k a, (Select kid, Count(*) class_schedule From ClassApp.dbo.class_schedule Where createdatetime Between @begdate and @enddate Group by kid) b    
  Where a.kid = b.kid    
    
Update #k Set class_video = b.class_video    
  From #k a, (Select kid, Count(*) class_video From ClassApp.dbo.class_video Where uploaddatetime Between @begdate and @enddate Group by kid) b    
  Where a.kid = b.kid    
    
Update #k Set cms_album = b.cms_album    
  From #k a, (Select siteid, Count(*) cms_album From KWebCMS.dbo.cms_album Where createdatetime Between @begdate and @enddate and deletetag = 1 Group by siteid) b    
  Where a.kid = b.siteid    
    
Update #k Set cms_content = b.cms_content    
  From #k a, (Select siteid, Count(*) cms_content From KWebCMS.dbo.cms_content Where createdatetime Between @begdate and @enddate and deletetag = 1 Group by siteid) b    
  Where a.kid = b.siteid    
    
Update #k Set cms_photo = b.cms_photo    
  From #k a, (Select siteid, Count(*) cms_photo From KWebCMS.dbo.cms_photo Where createdatetime Between @begdate and @enddate and deletetag = 1 Group by siteid) b    
  Where a.kid = b.siteid    
    
Update #k Set cms_contentattachs = b.cms_contentattachs    
  From #k a, (Select siteid, Count(*) cms_contentattachs From KWebCMS.dbo.cms_contentattachs Where deletetag = 1 and createdatetime Between @begdate and @enddate Group by siteid) b    
  Where a.kid = b.siteid    
    
--Select * From #k Order by class_album + class_notice + class_photos + class_schedule + class_video + cms_album + cms_content + cms_photo + cms_contentattachs Desc    
    
exec sp_MutiGridViewByPager          
@fromstring = '#k',      --数据集          
@selectstring = 'kid, kname, address, remark, qq, mobile, name, class_album, class_notice, class_photos, class_schedule, class_video, cms_album, cms_content, cms_photo, cms_contentattachs',      --查询字段          
@returnstring =           
'kid, kname, address, remark, qq, mobile, name, class_album, class_notice, class_photos, class_schedule, class_video, cms_album, cms_content, cms_photo, cms_contentattachs',      --返回字段          
@pageSize = @Size,  --每页记录数          
@pageNo = @page,                     --当前页          
@orderString = 'class_album + class_notice + class_photos + class_schedule + class_video + cms_album + cms_content + cms_photo + cms_contentattachs Desc',          --排序条件          
@IsRecordTotal = 1,             --是否输出总记录条数          
@IsRowNo = 0          --是否输出行号          


GO
