delimiter //
DROP TRIGGER IF EXISTS VisitFlagCheck;
//
CREATE TRIGGER VisitFlagCheck AFTER INSERT ON Visit FOR EACH ROW
BEGIN 
DECLARE excep varchar(255);
DECLARE newvisit varchar(255);
SET
newvisit = NEW.visitid;
IF newvisit IN (
  SELECT 
    usereventid 
  from 
    ChkUserEventUniqueness 
  WHERE 
    usage_flag = 1
) THEN 
set 
  excep = concat (
    'Insertion not accepted, event can be either interaction or visit, not both:  ', 
    cast(new.visitid as char)
  );
signal sqlstate '45000' 
set 
  message_text = excep;
  
ELSEIF newvisit IN (
  SELECT 
    usereventid 
  from 
    ChkUserEventUniqueness 
  WHERE 
    usage_flag = 0
) THEN 
UPDATE 
  ChkUserEventUniqueness 
SET 
  usage_flag = 1 
WHERE 
  usereventid = newvisit;
ELSE
INSERT INTO ChkUserEventUniqueness VALUES(null,newvisit,1,current_timestamp);
END IF;
END;
//



delimiter //
DROP TRIGGER IF EXISTS VisitFlagCheck;
//
CREATE TRIGGER VisitFlagCheck AFTER UPDATE ON Visit FOR EACH ROW
BEGIN 
DECLARE newvisit varchar(255);
SET
newvisit = NEW.visitid;
IF newvisit NOT IN (
  SELECT 
    usereventid 
  from 
    ChkUserEventUniqueness) 
THEN 
INSERT INTO ChkUserEventUniqueness VALUES(null,newvisit,1,current_timestamp);
END IF;
END;
//