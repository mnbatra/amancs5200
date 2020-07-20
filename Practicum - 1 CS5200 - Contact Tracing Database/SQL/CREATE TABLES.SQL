CREATE TABLE IF NOT EXISTS Place (
  placeid INT NOT NULL AUTO_INCREMENT, 
  placename VARCHAR(255) NOT NULL, 
  streetarea VARCHAR(255) NOT NULL, 
  state VARCHAR(255) NOT NULL, 
  city VARCHAR(255) NOT NULL, 
  zip VARCHAR(255) NOT NULL,
  latitude decimal(10,8) signed NOT NULL,
  longitude decimal(11,8) signed NOT NULL,
  PRIMARY KEY (placeid)
);
CREATE TABLE IF NOT EXISTS Person (
  PersonID INT NOT NULL AUTO_INCREMENT, 
  firstName VARCHAR(255) NOT NULL, 
  lastName VARCHAR(255), 
  PRIMARY KEY (PersonID)
);
CREATE TABLE IF NOT EXISTS AppUser (
  UserID INT NOT NULL, 
  Birthdate date NOT NULL, 
  AddressID INT NOT NULL, 
  RecoveredFromCovid Boolean, 
  PRIMARY KEY (UserID), 
  FOREIGN KEY(UserID) REFERENCES Person(PersonID), 
  FOREIGN KEY (AddressID) REFERENCES Place(PlaceID)
);
CREATE TABLE IF NOT EXISTS PublicHealthAuthority (
  AuthorityID INT NOT NULL AUTO_INCREMENT, 
  AuthAddressID INT NOT NULL, 
  Name VARCHAR(255) NOT NULL, 
  Jurisdiction VARCHAR(255), 
  PRIMARY KEY (AuthorityID), 
  FOREIGN KEY (AuthAddressID) REFERENCES Place(PlaceId)
);
CREATE TABLE IF NOT EXISTS PublicHealthWorker (
  WorkerID INT NOT NULL, 
  Title VARCHAR(255) NOT NULL, 
  OfficeID VARCHAR(255) NOT NULL, 
  PublicAuthID INT NOT NULL,
  PRIMARY KEY (WorkerID),
  FOREIGN KEY (PublicAuthID) REFERENCES PublicHealthAuthority(AuthorityID),
  FOREIGN KEY (WorkerID) REFERENCES Person(PersonId)
);
CREATE TABLE IF NOT EXISTS ContactHistoryLog (
  LogID INT NOT NULL AUTO_INCREMENT, 
  Date datetime, 
  AssignedWorkerID INT NOT NULL, 
  PRIMARY KEY (LogID), 
  FOREIGN KEY (AssignedWorkerID) REFERENCES PublicHealthWorker(WorkerId)
);
CREATE TABLE IF NOT EXISTS UserEvents (
  EventID INT NOT NULL AUTO_INCREMENT, 
  EventStartTime Datetime NOT NULL, 
  EventEndTime Datetime NOT NULL,
  LogBookID INT NOT NULL,
  Description VARCHAR(1200), 
  PRIMARY KEY (EventID),
  FOREIGN KEY (LogBookID) REFERENCES ContactHistoryLog(LogID)
);
CREATE TABLE IF NOT EXISTS HealthReportCheck (
  ReportID INT NOT NULL AUTO_INCREMENT, 
  UserID INT NOT NULL, 
  Temperature decimal(10, 3), 
  OxygenLevel decimal(10, 3), 
  HealthStatus enum('sick', 'healthy') NOT NULL, 
  TestResult enum(
    'Positive', 'Negative', 'Unclear'
  ) NOT NULL, 
  Description Text, 
  CheckingWorkerID INT NOT NULL, 
  ReportDate date,
  PRIMARY KEY (ReportID), 
  FOREIGN KEY (UserID) REFERENCES AppUser(UserID), 
  FOREIGN KEY(CheckingWorkerID) REFERENCES PublicHealthWorker(WorkerId)
);
CREATE TABLE IF NOT EXISTS Assessment (
  AssessID INT NOT NULL AUTO_INCREMENT, 
  TakerID INT NOT NULL, 
  CovidSuspected boolean NOT NULL, 
  TimeStamp Datetime NOT NULL, 
  ResponseSheet VARCHAR(255), 
  AssesseeType enum('self', 'doctor', 'others') NOT NULL, 
  OverseeingWorkerID INT NOT NULL, 
  PRIMARY KEY (AssessID), 
  FOREIGN KEY (TakerID) REFERENCES AppUser(UserId), 
  FOREIGN KEY (OverseeingWorkerID) REFERENCES PublicHealthWorker(WorkerId)
);
CREATE TABLE IF NOT EXISTS AppUserEmail (
  UserID INT NOT NULL, 
  EmailID VARCHAR(255) NOT NULL, 
  PRIMARY KEY (EmailID), 
  FOREIGN KEY(UserID) REFERENCES AppUser(UserID)
);
CREATE TABLE IF NOT EXISTS PublicHealthAuthorityHelpline(
  HelplineNo VARCHAR(255) NOT NULL, 
  AuthorityID INT NOT NULL, 
  PRIMARY KEY(HelplineNo), 
  FOREIGN KEY(AuthorityID) REFERENCES PublicHealthAuthority(AuthorityID)
);
CREATE TABLE IF NOT EXISTS Interactions (
  InteractionID INT NOT NULL, 
  InteractingUserID INT NOT NULL, 
  VisitorID INT NOT NULL, 
  InteractionPlaceID INT NOT NULL, 
  PRIMARY KEY (InteractionID), 
  FOREIGN KEY (InteractionID) REFERENCES UserEvents(EventID), 
  FOREIGN KEY (InteractingUserID) REFERENCES AppUser(UserID), 
  FOREIGN KEY (VisitorID) REFERENCES Person(PersonID), 
  FOREIGN KEY (InteractionPlaceID) REFERENCES Place(PlaceId)
);
CREATE TABLE IF NOT EXISTS Visit (
  VisitID INT NOT NULL, 
  VisitPlaceID INT NOT NULL, 
  VisitingUserID INT NOT NULL, 
  PRIMARY KEY (VisitID), 
  FOREIGN KEY (VisitID) REFERENCES UserEvents(EventID), 
  FOREIGN KEY (VisitPlaceID) REFERENCES Place(PlaceID), 
  FOREIGN KEY(VisitingUserID) REFERENCES AppUser(UserID)
);
CREATE TABLE IF NOT EXISTS Notifications (
  Nid INT NOT NULL AUTO_INCREMENT, 
  PHAAuthorityID INT NOT NULL, 
  timeStamp datetime NOT NULL, 
  OtherInformation Text, 
  PRIMARY KEY (Nid), 
  FOREIGN KEY (PHAAuthorityID) REFERENCES PublicHealthAuthority(AuthorityId)
);
CREATE TABLE IF NOT EXISTS PersonNotification (
  Nid INT NOT NULL, 
  PersonID INT NOT NULL, 
  PRIMARY KEY (Nid, PersonID), 
  FOREIGN KEY(Nid) REFERENCES Notifications(Nid), 
  FOREIGN KEY(PersonID) REFERENCES Person(PersonID)
);
CREATE TABLE IF NOT EXISTS PersonPhone(
  PersonID INT NOT NULL, 
  PhoneNo VARCHAR(20) NOT NULL, 
  PRIMARY KEY (PhoneNo), 
  FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);