

select * from mcapp..cardinfo where card='6801007984'
select * from mcapp..cardinfo_log where card='6801007984'
select * from applogs..EditLog where DbName='mcapp' and TbName='cardinfo' and KeyCol='6801007984'

select * from ossapp..users where ID=384
select * from BasicData..user_child where kid=26914 and name='ÐÜÒä³½'

select * from BigLog..loginfo where kid=26914 and logtype=7 and logtime>='2018-03-13'
select * from BigLog..loginfo_ex where kid=26914 and logtype=7 and logtime>='2018-03-13'
select * from BigLog..loginfo where kid=26914  and logtime>='2018-03-13'
select * from BigLog..loginfo_ex where kid=26914  and logtime>='2018-03-13'

select * from mcapp..OpenCard where kid=26914
select * from mcapp..OpenCard_history where kid=26914 and batchno='636565382541197976'
select * from mcapp..OpenCard_history where card='6801007984'

select * from cardinfo where kid=18699 and cardno='8359566'


