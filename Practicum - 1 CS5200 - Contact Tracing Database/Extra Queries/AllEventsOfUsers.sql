/* A union query to list out all the visits and interactions of everyone*/


SELECT 'Interaction', i.interactinguserid as User1_ID, i.visitorid as Visitor_ID, i.interactionplaceid as Place_ID, u.eventid as EventID, u.eventstarttime as Start_Time, u.eventendtime as End_time, u.description
FROM Interactions i, userevents u
WHERE i.interactionid=u.eventid
UNION ALL
SELECT 'Visit', v.visitinguserid, ' ',v.visitplaceid, u.eventid, u.eventstarttime, u.eventendtime, u.description
FROM visit v,userevents u
WHERE v.visitid=u.eventid
ORDER by User1_ID ASC;

