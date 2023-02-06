use marketing;


/*creating  table*/

CREATE TABLE login1(login_date DATE, user_id INT);
/*inserting values*/

INSERT INTO login1(login_date,user_id)
VALUES('2022-01-01',10),('2022-01-02',12),('2022-01-03',15),
('2022-01-04',11),('2022-01-05',13),('2022-01-06',9),
('2022-01-07',21),('2022-01-08',10),('2022-01-09',10),
('2022-01-10',2),('2022-01-11',16),('2022-01-12',12),
('2022-01-13',10),('2022-01-14',18),('2022-01-15',15),
('2022-01-16',12),('2022-01-17',10),('2022-01-18',18),
('2022-01-19',14),('2022-01-20',16),('2022-01-21',12),
('2022-01-22',21),('2022-01-23',13),('2022-01-24',15),
('2022-01-25',20),('2022-01-26',14),('2022-01-27',16),
('2022-01-28',15),('2022-01-29',10),('2022-01-30',18);
/*using Select clause for selecting the table*/
select * from login1;

/*First week of login */
select user_id,min(week(login_date))as first1 from login1 group by user_id; 
/*I joining  the table and finding week number*/
select m.user_id,m.login_week,n.first_week,(m.login_week-n.first_week) as week_number  from 
(select user_id,week(login_date) as login_week from login1 group by user_id,week(login_date))m,
(select user_id,min(week(login_date))as first_week from login1 group by user_id)n
where m.user_id=n.user_id order by user_id;

/*retention of the weeks*/
select first_week,
sum(case when week_number=0 then 1 else 0 end) as week_0,
sum(case when week_number=1 then 1 else 0 end) as week_1,
sum(case when week_number=2 then 1 else 0 end) as week_2,
sum(case when week_number=3 then 1 else 0 end) as week_3,
sum(case when week_number=4 then 1 else 0 end) as week_4,
sum(case when week_number=5 then 1 else 0 end) as week_5,
sum(case when week_number=6 then 1 else 0 end) as week_6,
sum(case when week_number>7 then 1 else 0 end) as above_week_7 from
(select m.user_id,m.login_week,n.first_week as first_week,(m.login_week-n.first_week) as week_number from
(select user_id,week(login_date) as login_week from login1 
group by user_id,week(login_date))m,
(select user_id,min(week(login_date)) as first_week from login1 group by user_id)n
where m.user_id=n.user_id ) as week_number 
group by first_week 
order by first_week;


