/* Partition Query Example*/
/* Test Reports of people who marked themselves sick*/
SELECT row_number() over(PARTITION by UserID Order by ReportDate) as RowNum, ReportID, UserID, TestResult, ReportDate
FROM HealthReportCheck
WHERE HealthStatus = 'Sick'
