

select  * 
-- update c set title = replace(title,'昆明市第一幼儿园','广州中幼幼儿园')
 from KWebCMS..cms_content c where siteid=28277 and title like '%昆明市第一幼儿园%'
select  * 
--update c set content = REPLACE(cast(content AS varchar(8000)),'中幼幼儿园','昆明市第一幼儿园')
from KWebCMS..cms_content c where siteid=28277 and content like '%中幼幼儿园%'


update c set content = REPLACE(cast(content AS varchar(8000)),'昆明市第一幼儿园','广州中幼幼儿园')
from KWebCMS..cms_content c where siteid=28277 and content like '%昆明市第一幼儿园%'


select *
--update k set invoicetitle='广州中幼幼儿园'  --广州中幼幼儿园
 from ossapp..kinbaseinfo k where kid = 28277
 
 select *
--update k set invoicetitle='广州中幼幼儿园'  --广州中幼幼儿园
 from basicdata..kindergarten k where kid = 28277
 
  select *
--update s set shortname='中幼幼儿园'  --中幼幼儿园
 from kwebcms..site_config s where siteid = 28277
 
   select *
--update s set shortname='中幼幼儿园'  --中幼幼儿园
 from kwebcms..site s where siteid = 28277
 
 
 