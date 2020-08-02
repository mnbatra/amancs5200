INSERT INTO UserEvents
VALUES (2155, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP+1,1350, 'an empy event');

 INSERT into UserEvents values(2107, current_timestamp, current_timestamp+1, 1208, 'A visit to landscape ground');

ALTER table interactions
drop column uniqueid;

INSERT INTO Interactions
VALUES (2223,1311,1350,222);

INSERT INTO Visit
VALUES (2223,257,1350);

DROP table ChkUserEventUniqueness;

DELETE from ChkUserEventUniqueness
WHERE usereventid=2222;

DELETE from visit
WHERE visitid in (2222,2101,2105,2107,2115);

DELETE from interactions
WHERE interactionid in (2222,2101,2105,2107,2115);

DELETE from UserEvents
WHERE eventid in (2222,2101,2105,2107,2115);

SELECT *
FROM UserEvents
WHERE eventid>2200;


SELECT *
FROM ChkUserEventUniqueness where usereventid is null;

UPDATE ChkUserEventUniqueness
SET ins_timestamp='2020-07-27 01:42:45'
WHERE usereventid='2222';


DROP TRIGGER UserEventFlagUpdation;


DELIMITER //
CREATE TRIGGER UserEventUpdation AFTER
UPDATE ON UserEvents
FOR EACH ROW BEGIN DECLARE 
WHERE v.visitid = OLD.eventid
  OR i.interactionid = OLD.eventid; IF updatecount=0 THEN
  DELETE
  FROM ChkUserEventUniqueness
  WHERE usereventid=OLD.eventid;
    INSERT INTO ChkUserEventUniqueness
  VALUES (NEW.eventid,
          0,
          CURRENT_TIMESTAMP); 
          END IF; 
END;

//
UPDATE UserEvents
SET LogBookId=LogBookID
WHERE EventID > 1;

 delimiter //
   DROP PROCEDURE IF EXISTS delete_unlinked_userevents;
   //
 CREATE DEFINER=root@localhost PROCEDURE delete_unlinked_userevents()
  BEGIN
DELETE from UserEvents
WHERE EventID NOT in ( SELECT usereventid from ChkUserEventUniqueness
  WHERE ChkUserEventUniqueness.ins_timestamp < now() - interval 1 HOUR);
  END;
  //
  
  call delete_unlinked_userevents();
  
   delimiter //
   DROP TRIGGER IF EXISTS update_deleted_userevents;
   //
CREATE DEFINER=root@localhost TRIGGER update_deleted_userevents
  AFTER DELETE ON UserEvents
  FOR EACH ROW
  BEGIN 
  if old.eventid not in (select usereventid from ChkUserEventUniqueness)
  then
  insert into ChkUserEventUniqueness values(null,null,concat('deleted_event_',old.eventid),current_timestamp);
  END IF;
  END;
  //
  


DROP TABLE ChkUserEventUniqueness;

  CALL delete_unlinked_userevents();

insert into userevents VALUES(2222,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP,1477, 'an old unused event');

insert into userevents VALUES(2223,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP,1477, 'an old unused event');

select * from person_contact_history;

UPDATE visit
SET visitplaceid=visitplaceid
where visitID>1;

UPDATE interactions
SET interactionid=interactionid
where interactionid>1;


delimiter //
DROP procedure IF EXISTS GenerateHealthAndExposureStatus;
//
delimiter //
CREATE procedure GenerateHealthAndExposureStatus()
BEGIN
DECLARE useridp integer;
DECLARE reportresult text;
DECLARE assessresult bool;
DECLARE finished INTEGER DEFAULT 0;

Declare health_status_cursor CURSOR for 
Select a.userid,h.TestResult, i.CovidSuspected from appuser a
JOIN healthreportcheck h on h.UserID=a.userid
JOIN assessment i on i.TakerID=h.UserID;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

OPEN health_status_cursor;
setHealthStatus : LOOP
		FETCH from health_status_cursor into useridp,reportresult,assessresult;
		IF finished=0 AND reportresult='positive'
        THEN UPDATE AppUser
        SET HealthStatus = 'infected' WHERE UserID=useridp;
        ELSEIF  finished=0 AND (reportresult='negative' or reportresult='unclear') 
        AND assessresult = 1
        THEN UPDATE AppUser
        SET HealthStatus = 'suspected' WHERE UserID=useridp;
        ELSEIF finished=0 AND reportresult='negative' 
        AND assessresult=0 
        THEN UPDATE AppUser
        SET HealthStatus = 'healthy' WHERE UserID=useridp;
		ELSEIF finished=1 THEN 
        LEAVE setHealthStatus;
        END IF;
END LOOP setHealthStatus;
CLOSE health_status_cursor;
END;



CALL GenerateHealthAndExposureStatus();

select * from appuser;


delimiter //
DROP PROCEDURE IF EXISTS delete_unlinked_userevents;
//
delimiter //
CREATE DEFINER=root@localhost PROCEDURE delete_unlinked_userevents()
  BEGIN
  DECLARE flagvar boolean;
  DECLARE timevar datetime;
  DECLARE eid,finished integer DEFAULT 0;
  DECLARE cleanup_userevent_cursor CURSOR for 
  SELECT u.eventid, c.usage_flag, c.ins_timestamp FROM UserEvents u
  JOIN ChkUserEventUniqueness c on c.usereventid=u.eventid;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
OPEN cleanup_userevent_cursor;
cleanup_userevent_loop : LOOP
		FETCH from cleanup_userevent_cursor into eid,flagvar,timevar;
		IF finished=0 AND flagvar=0 AND  timevar < now() - interval 1 HOUR
        THEN DELETE From UserEvents WHERE eventid=eid;
        DELETE from ChkUserEventUniqueness WHERE eventid=eid;
		ELSEIF finished=1 THEN LEAVE cleanup_userevent_loop;
        END IF;
END LOOP cleanup_userevent_loop;
CLOSE cleanup_userevent_cursor;
  END;
  //
  
  alter table person
  drop column infected_by;
  
  CALL delete_unlinked_userevents();
  
  delete from appuser where userid=1700;
  delete from person where personid=1700;
    
SET FOREIGN_KEY_CHECKS=0;

ALTER TABLE person DROP INDEX personid;
ALTER TABLE person ADD unique INDEX `personid`(`personid`);


ALTER TABLE HealthReportCheck DROP INDEX HealthRep;
ALTER TABLE HealthReportCheck ADD INDEX `HealthRep`(`testresult`);


ALTER TABLE appuser DROP INDEX appuserhealth;
ALTER TABLE appuser ADD INDEX `appuserhealth`(`recoveredfromcovid`,`healthstatus`);


ALTER TABLE place DROP INDEX `street_city_place`;

INSERT INTO UserEvents
VALUES (2155, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP+1,1350, 'an empy event');

 INSERT into UserEvents values(2107, current_timestamp, current_timestamp+1, 1208, 'A visit to landscape ground');

ALTER table interactions
drop column uniqueid;

INSERT INTO Interactions
VALUES (2223,1311,1350,222);

INSERT INTO Visit
VALUES (2223,257,1350);

DROP table ChkUserEventUniqueness;

DELETE from ChkUserEventUniqueness
WHERE usereventid=2222;

DELETE from visit
WHERE visitid in (2222,2101,2105,2107,2115);

DELETE from interactions
WHERE interactionid in (2222,2101,2105,2107,2115);

DELETE from UserEvents
WHERE eventid in (2222,2101,2105,2107,2115);

SELECT *
FROM UserEvents
WHERE eventid>2200;


SELECT *
FROM ChkUserEventUniqueness where usereventid is null;

UPDATE ChkUserEventUniqueness
SET ins_timestamp='2020-07-27 01:42:45'
WHERE usereventid='2222';


DROP TRIGGER UserEventFlagUpdation;


DELIMITER //
CREATE TRIGGER UserEventUpdation AFTER
UPDATE ON UserEvents
FOR EACH ROW BEGIN DECLARE 
WHERE v.visitid = OLD.eventid
  OR i.interactionid = OLD.eventid; IF updatecount=0 THEN
  DELETE
  FROM ChkUserEventUniqueness
  WHERE usereventid=OLD.eventid;
    INSERT INTO ChkUserEventUniqueness
  VALUES (NEW.eventid,
          0,
          CURRENT_TIMESTAMP); 
          END IF; 
END;

//
UPDATE UserEvents
SET LogBookId=LogBookID
WHERE EventID > 1;

 delimiter //
   DROP PROCEDURE IF EXISTS delete_unlinked_userevents;
   //
 CREATE DEFINER=root@localhost PROCEDURE delete_unlinked_userevents()
  BEGIN
DELETE from UserEvents
WHERE EventID NOT in ( SELECT usereventid from ChkUserEventUniqueness
  WHERE ChkUserEventUniqueness.ins_timestamp < now() - interval 1 HOUR);
  END;
  //
  
  call delete_unlinked_userevents();
  
   delimiter //
   DROP TRIGGER IF EXISTS update_deleted_userevents;
   //
CREATE DEFINER=root@localhost TRIGGER update_deleted_userevents
  AFTER DELETE ON UserEvents
  FOR EACH ROW
  BEGIN 
  if old.eventid not in (select usereventid from ChkUserEventUniqueness)
  then
  insert into ChkUserEventUniqueness values(null,null,concat('deleted_event_',old.eventid),current_timestamp);
  END IF;
  END;
  //
  


DROP TABLE ChkUserEventUniqueness;

  CALL delete_unlinked_userevents();

insert into userevents VALUES(2222,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP,1477, 'an old unused event');

insert into userevents VALUES(2223,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP,1477, 'an old unused event');

select * from person_contact_history;

UPDATE visit
SET visitplaceid=visitplaceid
where visitID>1;

UPDATE interactions
SET interactionid=interactionid
where interactionid>1;


delimiter //
DROP procedure IF EXISTS GenerateHealthAndExposureStatus;
//
delimiter //
CREATE procedure GenerateHealthAndExposureStatus()
BEGIN
DECLARE useridp integer;
DECLARE reportresult text;
DECLARE assessresult bool;
DECLARE finished INTEGER DEFAULT 0;

Declare health_status_cursor CURSOR for 
Select a.userid,h.TestResult, i.CovidSuspected from appuser a
JOIN healthreportcheck h on h.UserID=a.userid
JOIN assessment i on i.TakerID=h.UserID;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

OPEN health_status_cursor;
setHealthStatus : LOOP
		FETCH from health_status_cursor into useridp,reportresult,assessresult;
		IF finished=0 AND reportresult='positive'
        THEN UPDATE AppUser
        SET HealthStatus = 'infected' WHERE UserID=useridp;
        ELSEIF  finished=0 AND (reportresult='negative' or reportresult='unclear') 
        AND assessresult = 1
        THEN UPDATE AppUser
        SET HealthStatus = 'suspected' WHERE UserID=useridp;
        ELSEIF finished=0 AND reportresult='negative' 
        AND assessresult=0 
        THEN UPDATE AppUser
        SET HealthStatus = 'healthy' WHERE UserID=useridp;
		ELSEIF finished=1 THEN 
        LEAVE setHealthStatus;
        END IF;
END LOOP setHealthStatus;
CLOSE health_status_cursor;
END;



CALL GenerateHealthAndExposureStatus();

select * from appuser;


delimiter //
DROP PROCEDURE IF EXISTS delete_unlinked_userevents;
//
delimiter //
CREATE DEFINER=root@localhost PROCEDURE delete_unlinked_userevents()
  BEGIN
  DECLARE flagvar boolean;
  DECLARE timevar datetime;
  DECLARE eid,finished integer DEFAULT 0;
  DECLARE cleanup_userevent_cursor CURSOR for 
  SELECT u.eventid, c.usage_flag, c.ins_timestamp FROM UserEvents u
  JOIN ChkUserEventUniqueness c on c.usereventid=u.eventid;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
OPEN cleanup_userevent_cursor;
cleanup_userevent_loop : LOOP
		FETCH from cleanup_userevent_cursor into eid,flagvar,timevar;
		IF finished=0 AND flagvar=0 AND  timevar < now() - interval 1 HOUR
        THEN DELETE From UserEvents WHERE eventid=eid;
        DELETE from ChkUserEventUniqueness WHERE eventid=eid;
		ELSEIF finished=1 THEN LEAVE cleanup_userevent_loop;
        END IF;
END LOOP cleanup_userevent_loop;
CLOSE cleanup_userevent_cursor;
  END;
  //
  
  alter table person
  drop column infected_by;
  
  CALL delete_unlinked_userevents();
  
  delete from appuser where userid=1700;
  delete from person where personid=1700;
    
SET FOREIGN_KEY_CHECKS=0;

ALTER TABLE person DROP INDEX personid;
ALTER TABLE person ADD unique INDEX `personid`(`personid`);


ALTER TABLE HealthReportCheck DROP INDEX HealthRep;
ALTER TABLE HealthReportCheck ADD INDEX `HealthRep`(`testresult`);


ALTER TABLE appuser DROP INDEX appuserhealth;
ALTER TABLE appuser ADD INDEX `appuserhealth`(`recoveredfromcovid`,`healthstatus`);


ALTER TABLE place DROP INDEX `street_city_place`;

select p.personid,p.firstname,p.lastname, pp.phoneno from person p
inner join personphone pp on pp.personid=p.PersonID
inner join appuser a on a.userid=p.personid
inner join place l on l.placeid=a.addressid
inner join healthreportcheck h on h.userid=a.userid
where h.testresult = 'positive'
and a.age<85 and a.age>55
and l.city like '%boston%'
and h.temperature>99.5;


 select p.personid, p.firstname, p.lastname, pp.PhoneNo
from person p
inner join personphone pp on pp.personid=p.personID
 where p.personid in(select userid from appuser where age between 55 and 85
 and addressid in(select placeid from place where city like '%boston%'))
 and p.personid in(select userid from HealthReportCheck where testresult='positive' and temperature>99.5);
 

 WITH recursive iml AS (
select interactionid, interactinguserid, visitorid, 0 AS depth from 
interactions
where interactinguserid in (1310,1311,1312)
UNION ALL
SELECT i.interactionid, i.interactinguserid, i.VisitorID, iml.depth +1
from interactions i
inner join iml on i.interactinguserid=iml.visitorid
) 
select * from iml;

select personid, firstname, lastname
from person where 
personid in (select userid from appuser
 where userid in 
 (select userid from HealthReportCheck
 where testresult='positive' and temperature>101)
 and age between 55 and 85
 and addressid in
 (select placeid from place 
 where city like '%boston%')
 );
 
FLUSH STATUS;

 SHOW SESSION STATUS LIKE 'Handler%';

select personid, firstname, lastname
from person where exists(select userid from appuser
 where userid = person.personid and
 exists (select userid from HealthReportCheck 
 where testresult='positive' and temperature>101 and userid=appuser.userid )
 and age between 55 and 85
 and exists (select placeid from place 
 where city like '%boston%' and placeid=appuser.addressid )
 );
SHOW STATUS LIKE 'last_query_cost';

FLUSH STATUS;

SET profiling = 1;


select p.personid,p.firstname,p.lastname from person p
inner join appuser a on a.userid=p.personid
inner join place l on l.placeid=a.addressid
inner join healthreportcheck h on h.userid=a.userid
where h.testresult ='positive'
and a.age between 55 and 85
and l.city like '%boston%'
and h.temperature>101;

show profiles;

SHOW SESSION STATUS LIKE 'Handler%';



	explain SELECT a.UserID, p.firstName, cast(u.EventStartTime as date) as Visit_date,
	TIMEDIFF(u.EventEndTime,u.EventStartTime)as DurationOfVisit,m.streetarea, m.city  FROM visit v
    INNER JOIN AppUser a on a.UserID=v.visitinguserid
	INNER JOIN Person p on p.PersonID=a.userid
	INNER JOIN Place m on v.VisitPlaceID=m.placeid
	INNER JOIN UserEvents u on v.VisitID=u.EventID
	INNER JOIN HealthReportCheck h on a.userid=h.UserID
	WHERE h.TestResult='positive'
	AND datediff(h.ReportDate, u.EventStartTime)<20 
	AND datediff(h.ReportDate, u.EventStartTime)>-20
	HAVING DurationOfVisit>'01:00:00'
	ORDER by PersonID;
	 
	EXPLAIN SELECT a.UserID, p.firstName, cast(u.EventStartTime as date) as Visit_date,
	TIMEDIFF(u.EventEndTime,u.EventStartTime)as DurationOfVisit,m.streetarea, m.city  FROM visit v
    INNER JOIN AppUser a on a.UserID=v.visitinguserid
	INNER JOIN Person p on p.PersonID=a.userid
	INNER JOIN Place m on v.VisitPlaceID=m.placeid
	INNER JOIN UserEvents u on v.VisitID=u.EventID
	WHERE p.personid in 
	(select userid from HealthReportCheck where 
	TestResult='positive' and datediff(ReportDate, u.EventStartTime)<20  and datediff(ReportDate, u.EventStartTime)>-20)
	HAVING DurationOfVisit>'01:00:00'
	ORDER by PersonID;
 
 
 
select c.logid, concat(p.firstname,' ',p.lastname) as PersonName, cast(c.date as date) as LogDate, c.assignedworkerid as HealthWorkerID, 
u.eventid as InteractionId, timediff(u.eventendtime,u.eventstarttime) as InteractionTime
from contacthistorylog c, userevents u, person p, interactions i
where c.logid = u.logbookid
and u.eventid = i.interactionid
and i.interactinguserid = p.personid
order by logid;


update healthreportcheck
set userid=userid
where userid>1;

alter table interactions
add column uniqueid BINARY(37);


 drop trigger before_update_healthreportcheck;
CREATE TRIGGER before_update_healthreportcheck
  before update ON healthreportcheck
  FOR EACH ROW
  SET new.uniqueid = uuid();
  
  


explain select interactions.interactinguserid as FirstPersonID, visitorid as SecondPersonID
from interactions
union all
select j.Interactinguserid,j.visitorid from interactions j, Interactions i
where j.Interactinguserid = i.visitorid
order by FirstPersonID;


 explain WITH recursive iml(interactinguserid , visitorid, level ) AS (
select interactinguserid as FirstPersonID, visitorid as SecondPersonID, 0 AS level from 
interactions
where interactinguserid is not null
UNION ALL
SELECT i.interactinguserid, i.VisitorID, j.level+1 AS level
from interactions i , iml j
WHERE i.interactinguserid=j.visitorid
and level <1
) 
select * from iml
order by interactinguserid;


FLUSH STATUS;


select distinct p.personid, p.firstname, p.lastname from person p
inner join contacthistorylog c on c.assignedworkerid=p.personid
inner join userevents u on c.logid=u.logbookid
inner join Interactions i on i.interactionid=u.eventid
inner join appuser a on a.userid=i.interactinguserid
inner join place pl on pl.placeid=a.addressid
inner join healthreportcheck h on h.userid=a.userid
where a.healthstatus in ('suspected','infected')
and (h.oxygenlevel<90 or h.temperature>99.5)
and a.RecoveredFromCovid=0
and pl.city like '%boston%';
SHOW SESSION STATUS LIKE 'Handler%';


FLUSH STATUS;
select personid, firstname, lastname from person FORCE INDEX (primary) where personid in 
(select AssignedWorkerID from contacthistorylog where logid in 
(select logbookid from userevents where eventid in 
(select interactionid from interactions where interactinguserid in 
(select userid from HealthReportCheck where oxygenlevel<90 or temperature>99.5)
 and Interactinguserid in
 (select userid from appuser where recoveredfromcovid=0
 and healthstatus in ('suspected','infected')
 and addressid in (select placeid from place where city like '%boston%')
 ))));
SHOW SESSION STATUS LIKE 'Handler%';


select distinct personid, firstname, lastname from person where personid in 
(select AssignedWorkerID from contacthistorylog where logid in 
(select logbookid from userevents where eventid in 
(select interactionid from interactions where interactinguserid in 
(select userid from appuser where addressid in 
(select placeid from place where city like '%boston%') 
and userid in 
(select userid from HealthReportCheck where oxygenlevel<90 or temperature>99.5)
and RecoveredFromCovid=0
and healthstatus in ('suspected','infected'))
)));


select  personid, firstname, lastname from person where personid in 
(select AssignedWorkerID from contacthistorylog where logid in 
(select logbookid from userevents where eventid in 
(select interactionid from interactions where interactinguserid in 
(select userid from appuser where addressid in 
(select placeid from place where city like '%boston%') 
and exists (select userid from HealthReportCheck where oxygenlevel<90 or temperature>99.5 and userid=interactions.interactinguserid)
and RecoveredFromCovid=0
and healthstatus in ('suspected','infected'))
)));


select p.personid, concat(p.firstname, p.lastname) from person p
join appuser a on a.userid=p.personid;

 

select distinct userid from healthreportcheck
where testresult='negative'
and exists(select takerid from assessment where covidsuspected=1 and takerid=healthreportcheck.userid);


select distinct userid from HealthReportCheck h
inner join assessment a on h.userid = a.takerid
where a.covidsuspected=1 and h.TestResult='negative';