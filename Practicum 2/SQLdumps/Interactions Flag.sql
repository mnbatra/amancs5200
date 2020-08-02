delimiter //
DROP TRIGGER IF EXISTS  InteractionFlagCheck;
//
CREATE TRIGGER InteractionFlagCheck AFTER INSERT ON Interactions FOR EACH ROW
BEGIN 
DECLARE excep varchar(255);
IF NEW.interactionid IN (
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
    cast(new.interactionid as char)
  );
signal sqlstate '45000' 
set 
  message_text = excep;
  
ELSEIF NEW.interactionid IN (
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
  usereventid = NEW.interactionid;
ELSE
INSERT INTO ChkUserEventUniqueness VALUES(null,NEW.Interactionid,1,current_timestamp);
END IF;
END;
//


delimiter //
DROP TRIGGER IF EXISTS  UpdateInteraction_UpdateFlag;
//
CREATE TRIGGER UpdateInteraction_UpdateFlag AFTER INSERT ON Interactions FOR EACH ROW
BEGIN 
IF NEW.interactionid NOT IN (
  SELECT 
    usereventid 
  from 
    ChkUserEventUniqueness )
THEN
INSERT INTO ChkUserEventUniqueness VALUES(null,NEW.Interactionid,1,current_timestamp);
END IF;
END;
//