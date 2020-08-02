/* A View of all the interactions and visits of every person in the database */
CREATE or Replace VIEW person_contact_history as 
/* A union query to list out all the visits and interactions of everyone*/
SELECT 
  'Interaction', 
  i.interactinguserid as UserID, 
  i.visitorid as VisitorID, 
  i.interactionplaceid as PlaceID, 
  p.firstname as FirstPersonName, 
  v.firstname as VisitorName, 
  CONCAT('i', u.eventid) as EventID, 
  u.eventstarttime as Start_Time, 
  u.eventendtime as End_time, 
  u.description 
FROM 
  Interactions i, 
  userevents u, 
  person p, 
  person v 
WHERE 
  i.interactionid = u.eventid 
  AND i.InteractingUserID = p.personid 
  AND i.VisitorID = v.personid 
UNION ALL 
SELECT 
  'Visit', 
  v.visitinguserid, 
  ' ', 
  v.visitplaceid, 
  k.firstname as First_Person_Name, 
  '  ', 
  CONCAT('v', u.eventid) as EventID, 
  u.eventstarttime, 
  u.eventendtime, 
  u.description 
FROM 
  visit v, 
  userevents u, 
  person k 
WHERE 
  v.visitid = u.eventid 
  AND v.visitinguserid = k.personid 
ORDER by 
  UserID ASC;
