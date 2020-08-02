SET SQL_SAFE_UPDATES=1;

delimiter //
DROP TRIGGER IF EXISTS VisitFlagCheck;
//
CREATE TRIGGER VisitFlagCheck AFTER INSERT ON Visit FOR EACH ROW
BEGIN 
DECLARE excep varchar(255);
IF  (SELECT count(*) from ChkUserEventUniqueness where usereventid=NEW.visitid)>0
THEN 
set excep = concat ('Insertion not accepted, event can be either interaction or visit, not both:  ', cast(new.visitid as char));
signal sqlstate '45000' set message_text = excep;
ELSEIF NEW.visitid NOT IN ( SELECT usereventid from  ChkUserEventUniqueness ) THEN
INSERT INTO ChkUserEventUniqueness VALUES(null,NEW.visitid,'visit_event',current_timestamp);
END IF;
END;
//


delimiter //
DROP TRIGGER IF EXISTS VisitFlagUpdate;
//
CREATE TRIGGER VisitFlagUpdate
AFTER UPDATE ON Visit FOR EACH ROW
BEGIN 
IF NEW.visitid NOT IN (SELECT usereventid from ChkUserEventUniqueness ) THEN 
INSERT INTO ChkUserEventUniqueness VALUES(null,NEW.visitid,'visit_event',current_timestamp);
END IF;
END;
//


delimiter //
DROP TRIGGER IF EXISTS VisitDelete_UpdateAudit;
//
CREATE TRIGGER VisitDelete_UpdateAudit AFTER
DELETE ON Visit
FOR EACH ROW 
BEGIN
IF OLD.visitid in (SELECT usereventid FROM ChkUserEventUniqueness WHERE usereventid = OLD.visitid) 
  THEN
  UPDATE ChkUserEventUniqueness
  SET usereventid = null,
  textlog=CONCAT('visit_',usereventid,'_deleted')
  WHERE usereventid=OLD.visitid;
END IF; 
END;
//


