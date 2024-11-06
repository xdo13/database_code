-- 프로시져 
drop procedure if exists ifproc1;
delimiter $$
create procedure ifProc1()
begin
	if 100 = 100 then
		select '100은 100과 같습니다';
	end if;
end $$
delimiter ;

call ifProc1();

drop procedure if exists ifproc2;

delimiter $$
create procedure ifproc2()
begin
declare mynum int;
set mynum = 200;
if mynum = 100 then
	select '100입니다.';
else
	select '100이 아닙니다.';
    end if;
end $$
delimiter ;

call ifproc2();

-- proc3() 
drop procedure if exists ifproc3;

delimiter $$
create procedure ifproc3()
begin
	declare debutdate date; -- 데뷔 일자
    declare curdate date; -- 오늘
    declare days int; -- 황동한 일수
	select debut_date into debutdate
	from market_db.member
    where mem_id = 'APN';
    
set curdate = current_date(); -- 현재 날짜
set days = datediff(curdate, debutdate); -- 날짜의 차이, 일 단위

if (days/365) >= 5 then -- 5년이 지났다면
	select concat('데뷔한 지 ', days, '일이나 지났습니다. 핑순이들 축하합니다.');
else
	select '데뷔한 지 ' + days + '일밖에 안되었네요. 핑순이들 화이팅~';
end if;
end $$
delimiter ;

call ifproc3();