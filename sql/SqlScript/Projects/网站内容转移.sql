kwebcms

--待确认
select * from site_usermenu where siteid=24945
select * from site_usermenu where siteid=9777

select * from defaultpage where siteid=24945
select * from defaultpage where siteid=9777

--将24945网站相关的内容转移到9777,
--1)备份数据库
select * into site_user_9777 from site_user where siteid in(9777,24945) 
select * into site_usermenu_9777 from site_usermenu where siteid in(9777,24945) 
select * into defaultpage_9777 from defaultpage where siteid in(9777,24945)
select * into cms_contentattachs_9777 from cms_contentattachs where siteid in(9777,24945)
select * into site_menu_9777 from site_menu where siteid in(9777,24945)
select * into site_themesetting_9777 from site_themesetting where siteid in(9777,24945)
select * into cms_category_9777 from cms_category where siteid in(9777,24945)
select *into cms_content_9777 from cms_content where siteid in(9777,24945)
select * into cms_photo_9777 from dbo.cms_photo where siteid in(9777,24945)
select * into cms_album_9777 from dbo.cms_album where siteid in(9777,24945)
select *into site_config_9777 from dbo.site_config where siteid in(9777,24945)
select *into site_9777 from dbo.[site] where siteid in(9777,24945)


--2)修改栏目权限、皮肤
insert into dbo.site(siteid,name,description,address,sitedns,provice,
city,regdatetime,contractname,QQ,phone,accesscount,status,
Email,synchro,dict,ktype,klevel,org_id,copyright,photowatermark,keyword)
select 15,name,description,address,sitedns,provice,
city,regdatetime,contractname,QQ,phone,accesscount,status,
Email,synchro,dict,ktype,klevel,org_id,copyright,photowatermark,keyword from site where siteid=9777

update s set org_id=20547 from dbo.site s where siteid=9777 --and org_id=5696
update s set theme='469' from dbo.site_config s where siteid=9777 -- and theme='Default'
update kwebcms..site_user set uid=89068 where siteid=9777 and userid=18013
 
--3)将9997的内容转到没用的kid=15，
update s set siteid=15 from site_usermenu s where siteid=9777 
update s set siteid=15 from defaultpage s where siteid=9777
update s set siteid=15 from cms_contentattachs s where siteid=9777
update s set siteid=15 from site_menu s where siteid=9777
update s set siteid=15 from site_themesetting s where siteid=9777
update s set siteid=15 from cms_category s where siteid=9777
update s set siteid=15 from cms_content s where siteid=9777
update s set siteid=15 from cms_photo s where siteid=9777
update s set siteid=15 from cms_album s where siteid=9777

--4)然后将24945的内容转到9777。
update s set siteid=9777 from site_usermenu s where siteid=24945
update s set siteid=9777 from defaultpage s where siteid=24945
update s set siteid=9777 from cms_contentattachs s where siteid=24945
update s set siteid=9777 from site_menu s where siteid=24945
update s set siteid=9777 from site_themesetting s where siteid=24945
update s set siteid=9777 from cms_category s where siteid=24945
update s set siteid=9777 from cms_content s where siteid=24945
update s set siteid=9777 from cms_photo s where siteid=24945
update s set siteid=9777 from cms_album s where siteid=24945



【数据恢复】
--1)将9997的内容转到没用的kid=15，
update s set siteid=24945 from cms_contentattachs s where siteid=9777
update s set siteid=24945 from site_menu s where siteid=9777
update s set siteid=24945 from site_themesetting s where siteid=9777
update s set siteid=24945 from cms_category s where siteid=9777
update s set siteid=24945 from cms_content s where siteid=9777
update s set siteid=24945 from cms_photo s where siteid=9777
update s set siteid=24945 from cms_album s where siteid=9777

--2)然后将24945的内容转到9777。
update s set siteid=9777 from cms_contentattachs s where siteid=15
update s set siteid=9777 from site_menu s where siteid=15
update s set siteid=9777 from site_themesetting s where siteid=15
update s set siteid=9777 from cms_category s where siteid=15
update s set siteid=9777 from cms_content s where siteid=15
update s set siteid=9777 from cms_photo s where siteid=15
update s set siteid=9777 from cms_album s where siteid=15

--3)恢复栏目权限、皮肤

 
update s set org_id=5696 from dbo.site s where siteid=9777 --and org_id=20547
update s set theme='Default' dbo.site_config s where siteid=9777 -- and theme='469'

update s set theme='Default' dbo.site_config s where siteid=9777 -- and theme='469'

--查询
select *from cms_contentattachs where siteid=24945
select *from site_menu where siteid=24945
select *from site_themesetting where siteid=24945
select *from cms_category where siteid=24945
select *from cms_content where siteid=24945
select * from dbo.cms_photo where siteid=24945
select * from dbo.cms_album where siteid=24945
select *from dbo.[site] where siteid=24945
select *from dbo.site_config where siteid=24945

--select min(siteid) from KWebCMS.dbo.site where siteid>0
--select min(kid) from BasicData..[kindergarten] where kid>0
--select min(kid) from ossapp..kinbaseinfo where kid>0

--select * from KWebCMS.dbo.site where siteid = 15
--select * from BasicData..[kindergarten] where kid = 15

select *from KWebCMS_right.dbo.sac_user where user_id= 89068
select *from KWebCMS_right.dbo.sac_user where org_id =20547

select *from KWebCMS_right.dbo.sac_user where user_id= 13028
select *from KWebCMS_right.dbo.sac_user where org_id =5696

select * into dbo.sac_user_9777 from KWebCMS_right.dbo.sac_user where user_id= 13028 or org_id=5696

select *from KWebCMS_right.dbo.sac_user where org_id =20547


update KWebCMS_right.dbo.sac_user set org_id=5696 where user_id = 13028 and org_id=5696

select * from site_user where siteid=24945
select * from kwebcms..site_user where siteid=9777 and userid=18013
select * from kwebcms..site_user_9777 where siteid=9777 and userid=18013


