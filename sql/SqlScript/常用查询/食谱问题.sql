select * from kwebcms..recipe where siteid=33794 and createdatetime>='2017-03-24'

select * from kwebcms..recipe where siteid=33794 and createdatetime>='2017-03-21'


--d.sitedns +  contentid  + '.html?uid=123&categorycode=mzsp&view=1' from kwebcms.dbo.[site] 

----------食谱手机端链接----------
http://lxzzlkfy.zgyey.com/637252.html?uid=123&categorycode=mzsp&view=1   --旧版食谱
https://infoview.zgyey.com/625681.html?uid=123&categorycode=mzsp&view=1  --新版食谱

https://infoview.zgyey.com/app_recipe_MZSP-637252.html?uid=2265584&categorycode=mzsp&view=1&pmid=298863696

--cms_content

select * from kwebcms.dbo.[site] where siteid=31228


select * from kwebcms..cms_content where siteid=31228 order by contentid desc