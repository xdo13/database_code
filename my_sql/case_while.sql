drop procedure if exists caseProc;

delimiter $$

create procedure caseProc()
begin
	declare point int;
    declare credit char(1);
    set point= 88;
    
    case
		when point >= 90 then
			set credit = 'A';
		when point >= 80 then
			set credit = 'B';
		when point >= 70 then
			set credit = 'C';
		when point >= 60 then
			set credit = 'D';
		else
			set credit = 'F';
		End case;
        select concat('취득점수==>', point), concat('학점==>', credit);
	end $$
    delimiter ;
    
    call caseproc();
    
    select m.mem_id, m.mem_name, sum(price*amount) '총구매액',
		case
			when (sum(price*amount) >= 1500) then '최우수고객'
            when (sum(price*amount) >= 1000) then '우수고객'
            when (sum(price*amount) >= 1) then '일반고객'
            else '유령고객'
		end '회원등급'
	from buy b
		right outer join member m
        on b.mem_id = m.mem_id
	group by m.mem_id
    order by sum(price*amount) desc;
    
    -- while 문
    
    drop procedure if exists whileProc2;
    
    delimiter $$
    
    create procedure whileproc2()
    begin
		declare i int;
        declare hap int;
        set i = 1;
        set hap = 0;
        
        myWhile:
        while(i<=100) do
			if (i%4 = 0) then
				set i = i +1;
                iterate mywhile;
			end if;
            set hap = hap + i;
            if(hap > 1000) then
				leave mywhile;
			end if;
            set i = i+1;
		end while;
        
        select '1부터 100까지의 합(4의 배수 제외), 1000 넘으면 종료 ==>', hap;
	end $$
    delimiter ;
    
    call whileProc2();
    
            
    