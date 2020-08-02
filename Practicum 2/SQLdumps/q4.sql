delimiter //
drop table ChkUserEventUniqueness;
//
CREATE TABLE IF NOT EXISTS ChkUserEventUniqueness (
  usereventid INTEGER NOT NULL, 
  usage_flag BOOLEAN NOT NULL DEFAULT 0,
  ins_timestamp datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (usereventid)
);
//
delimiter //
DROP TRIGGER IF EXISTS UserEventFlagGeneration; //



delimiter //
CREATE TRIGGER UserEventFlagGeneration 
AFTER INSERT ON UserEvents FOR EACH ROW BEGIN 
  DELETE FROM ChkUserEventUniqueness WHERE usereventid=NEW.eventid;
  INSERT INTO ChkUserEventUniqueness VALUES(NEW.eventid, 0,CURRENT_TIMESTAMP);
END;
//


delimiter //
DROP TRIGGER IF EXISTS  UserEventUpdation;
//
DELIMITER //
CREATE TRIGGER UserEventUpdation AFTER UPDATE ON UserEvents
FOR EACH ROW BEGIN
IF New.eventid not in (SELECT usereventid from ChkUserEventUniqueness) then
INSERT INTO ChkUserEventUniqueness VALUES(NEW.eventid, 0,CURRENT_TIMESTAMP);
END IF;
END;
//

delimiter //
DROP TRIGGER IF EXISTS  InteractionFlagCheck;
//

delimiter //
CREATE TRIGGER InteractionFlagCheck AFTER INSERT ON Interactions FOR EACH ROW
BEGIN  DECLARE excep varchar(255);
IF NEW.interactionid IN (SELECT usereventid from ChkUserEventUniqueness WHERE usage_flag = 1) THEN 
set  excep = concat (
    'Insertion not accepted, event can be either interaction or visit, not both:  ', 
    cast(new.interactionid as char)
  );
signal sqlstate '45000' set message_text = excep;
ELSE 
UPDATE ChkUserEventUniqueness 
SET  usage_flag = 1 
WHERE usereventid = NEW.Interactionid;
END IF;
END;
//

delimiter // 
DROP TRIGGER IF EXISTS  InteractionDeletion;
//
delimiter //
CREATE TRIGGER InteractionDeletion AFTER DELETE ON Interactions FOR EACH ROW
BEGIN 
IF OLD.interactionid IN (SELECT usereventid from ChkUserEventUniqueness WHERE usage_flag = 1) THEN 
UPDATE ChkUserEventUniqueness 
SET  usage_flag = 0
WHERE usereventid = OLD.Interactionid;
END IF;
END;
//

delimiter // 
DROP TRIGGER IF EXISTS  InteractionUpdation;
//
delimiter //
CREATE TRIGGER InteractionUpdation AFTER UPDATE ON Interactions FOR EACH ROW
BEGIN 
IF OLD.interactionid NOT  IN (SELECT usereventid from ChkUserEventUniqueness WHERE usage_flag=1 ) THEN 
UPDATE ChkUserEventUniqueness 
SET  usage_flag = 1
WHERE usereventid = OLD.Interactionid;
END IF;
END;
//



delimiter //
DROP TRIGGER IF EXISTS VisitFlagCheck;
//

delimiter //
CREATE TRIGGER VisitFlagCheck AFTER INSERT ON Visit FOR EACH ROW 
BEGIN DECLARE excep varchar(255);
IF NEW.visitid IN (SELECT usereventid from ChkUserEventUniqueness WHERE usage_flag = 1) THEN 
set excep = concat ('Insertion not accepted, event can be either interaction or visit, not both: ', 
cast(new.visitid as char)
  );
signal sqlstate '45000' set message_text = excep;
ELSE 
UPDATE ChkUserEventUniqueness 
SET  usage_flag = 1 
WHERE usereventid = NEW.visitid;
  END IF;
END;
//


delimiter // 
DROP TRIGGER IF EXISTS  VisitDeletion;
//


delimiter //
CREATE TRIGGER VisitDeletion AFTER DELETE ON Visit FOR EACH ROW
BEGIN 
IF OLD.visitid IN (SELECT usereventid from ChkUserEventUniqueness WHERE usage_flag = 1) THEN 
UPDATE ChkUserEventUniqueness 
SET  usage_flag = 0
WHERE usereventid = OLD.visitid;
END IF;
END;
//

delimiter // 
DROP TRIGGER IF EXISTS  VisitUpdation;
//
delimiter //
CREATE TRIGGER VisitUpdation AFTER UPDATE ON Visit FOR EACH ROW
BEGIN 
IF OLD.visitid NOT  IN (SELECT usereventid from ChkUserEventUniqueness WHERE usage_flag=1 ) THEN 
UPDATE ChkUserEventUniqueness 
SET  usage_flag = 1
WHERE usereventid = OLD.visitid;
END IF;
END;
//

delimiter //
DROP PROCEDURE IF EXISTS delete_unlinked_userevents;
//

delimiter //
 CREATE DEFINER=root@localhost PROCEDURE delete_unlinked_userevents()
  BEGIN
  DELETE u,c FROM UserEvents u
  JOIN ChkUserEventUniqueness c on c.usereventid=u.eventid
  WHERE c.usage_flag=0
  AND c.ins_timestamp < now() - interval 1 HOUR
  AND c.usereventid=u.eventid;
  END;
  //
  
  SET SQL_SAFE_UPDATES = 0;
  call delete_unlinked_userevents();
  