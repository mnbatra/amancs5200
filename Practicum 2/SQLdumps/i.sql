
delimiter //
DROP TRIGGER IF EXISTS InteractionsUniquenessCheck;
//
CREATE TRIGGER InteractionsUniquenessCheck 
AFTER INSERT ON interactions FOR EACH ROW
BEGIN 
DECLARE excep varchar(255);
IF  (SELECT count(*) from ChkUserEventUniqueness where usereventid=NEW.InteractionID)>0
THEN set excep = concat ('Insertion not accepted, event can be either interaction or visit, not both:  ', cast(NEW.interactionid as char));
signal sqlstate '45000'  set message_text = excep;
ELSEIF NEW.InteractionID NOT IN ( SELECT usereventid from  ChkUserEventUniqueness ) THEN
INSERT INTO ChkUserEventUniqueness VALUES(null,NEW.interactionid,'interaction_event',current_timestamp);
END IF;
END;
//


delimiter //
DROP TRIGGER IF EXISTS InteractionsUpdateCheck;
//
CREATE TRIGGER InteractionsUpdateCheck AFTER UPDATE ON interactions FOR EACH ROW
BEGIN 
IF NEW.InteractionID NOT IN (SELECT usereventid from ChkUserEventUniqueness ) THEN 
INSERT INTO ChkUserEventUniqueness VALUES(null,NEW.interactionid,'interaction_event',current_timestamp);
END IF;
END;
//

delimiter //
DROP TRIGGER IF EXISTS InteractionsDelete_UpdateAudit;
//
CREATE TRIGGER InteractionsDelete_UpdateAudit AFTER
DELETE ON Interactions
FOR EACH ROW 
BEGIN
IF OLD.InteractionID in (SELECT usereventid FROM ChkUserEventUniqueness WHERE usereventid = OLD.InteractionID) 
  THEN
  UPDATE ChkUserEventUniqueness
  SET usereventid = null,
  textlog=CONCAT('interaction_',usereventid,'_deleted')
  WHERE usereventid=OLD.InteractionID;
END IF; 
END;
//
