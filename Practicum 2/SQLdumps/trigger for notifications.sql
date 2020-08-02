ALTER TABLE notifications
ADD COLUMN ExposureEvent text,
ADD COLUMN ExposureDate datetime,
ADD COLUMN threatLevel ENUM ('high','medium','low');

delimiter //

DROP TRIGGER If exists derive_notification_attributes;
//

delimiter //
CREATE TRIGGER derive_notifications_attributes
AFTER INSERT on personnotification for each row
BEGIN
  DECLARE sttime, ettime datetime;
  DECLARE suspected boolean;
  DECLARE testres text;
  DECLARE pid, eid integer;
  DECLARE create_notification_cursor CURSOR for 
  SELECT p.personid, i.interactionid, u.eventstarttime,u.eventendtime, h.testresult, a.covidsuspected
from person p, interactions i, healthreportcheck h, assessment a, userevents u
where p.personid = i.interactinguserid
and i.interactionid = u.eventid and h.userid = i.visitorid
and a.takerid = i.visitorid  and p.personid = NEW.PersonID;

OPEN create_notification_cursor;
FETCH from create_notification_cursor INTO pid, eid, sttime, ettime, testres, suspected;
if testres = 'positive' 
then update notifications set 
ExposureEvent=CONCAT('Met a covid positive person for', timediff(sttime,ettime)),
 ExposureDate = CAST(sttime as DATE),
 threatLevel='high'
 where nid= NEW.nid;
 
elseif suspected=1 and (testres='negative' or testres='unclear')  
then update notifications set 
ExposureEvent=CONCAT('Met a covid suspected person for', timediff(sttime,ettime)),
 ExposureDate = CAST(sttime as DATE),
 threatLevel='medium'
 where nid= NEW.nid;
 
end if;
close create_notification_cursor;
END;
//
select * from PublicHealthAuthority;

delete from PersonNotification where nid = 132123;
delete from notifications where nid = 132123;

select * from notifications where nid = 132122;

start transaction;
SET FOREIGN_KEY_CHECKS=0;

insert into PersonNotification values(132122,1004);
SET FOREIGN_KEY_CHECKS=1;
commit;
insert into Notifications(Nid, PHAAuthorityID,timeStamp,OtherInformation) values(132123,13110, current_timestamp,'please contact us asap on 321123123');
