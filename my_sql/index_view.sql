select * from member;

delete from member
where member_id = 'carry';

select member_name, member_addr from member;

select * from member
where member_name = '아이유';

create index idx_member_name on member(member_name);

select *
from member
where member_addr like '%경기%';

CREATE INDEX idx_member_addr ON member(member_addr);

create view member_views
as
select  member_id, member_name, member_addr from  member;

select * from member_views;
