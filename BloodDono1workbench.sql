USE BloodBankDB;

CREATE TABLE BloodBank (
    BankID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(150),
    Contact VARCHAR(50)
);

CREATE TABLE Hospital (
    HospitalID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(150),
    Contact VARCHAR(50)
);

CREATE TABLE Donor (
    DonorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(150),
    Age INT,
    BloodType VARCHAR(10),
    LastDonationDate DATE,
    Contact VARCHAR(50)
);

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    BloodType VARCHAR(10),
    Contact VARCHAR(50)
);

CREATE TABLE Requests (
    BankID INT,
    HospitalID INT,
    Availability VARCHAR(100),
    PRIMARY KEY (BankID, HospitalID),
    FOREIGN KEY (BankID) REFERENCES BloodBank(BankID),
    FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID)
);

CREATE TABLE Donates (
    DonorID INT,
    BankID INT,
    PRIMARY KEY (DonorID, BankID),
    FOREIGN KEY (DonorID) REFERENCES Donor(DonorID),
    FOREIGN KEY (BankID) REFERENCES BloodBank(BankID)
);

CREATE TABLE Supplies (
    HospitalID INT,
    PatientID INT,
    PRIMARY KEY (HospitalID, PatientID),
    FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

INSERT INTO BloodBank VALUES (1, 'Red Cross', 'City Center', '1234567890');
INSERT INTO BloodBank VALUES (2, 'Life Care', 'Downtown', '0987654321');
INSERT INTO BloodBank VALUES (3, 'MGR Memorial', 'Chinatown', '927837167876');
INSERT INTO BloodBank VALUES (4, 'Pure Life Centre', 'Chennai', '92673156785');
INSERT INTO BloodBank VALUES (5, 'RNR Centre', 'Eastwood', '9746382718');

INSERT INTO Hospital VALUES (1, 'City Hospital', 'East Street', '1122334455');
INSERT INTO Hospital VALUES (2, 'Green Valley Hospital', 'West Street', '2233445566');
INSERT INTO Hospital VALUES (3, 'Kamala Hospital', 'Westwood', '1122334231');
INSERT INTO Hospital VALUES (4, 'Sathyam Hospital', 'North Avenue', '927183618647');
INSERT INTO Hospital VALUES (5, 'Maaran Hospital', 'Kalugumalai Ave', '926371536');

INSERT INTO Donor VALUES (1, 'Arthur Morgan', 'Gandhi Nagar', 30, 'A+', '2024-03-01', '9876543210');
INSERT INTO Donor VALUES (2, 'John Marston', 'Nehru Nagar', 28, 'B-', '2024-02-15', '8765432109');
INSERT INTO Donor VALUES (3, 'Vetri Maaran', 'Kovilpatti', 32, 'B+', '2024-02-01', '9876543212');
INSERT INTO Donor VALUES (4, 'Krishna', '123 Main St', 27, 'O+', '2024-01-03', '9876543216');
INSERT INTO Donor VALUES (5, 'Kumar', '321 Main St', 26, 'A+', '2024-01-05', '9876543213');

INSERT INTO Patients VALUES (1, 'Vaishak Vilak', 40, 'A+', '7788990011');
INSERT INTO Patients VALUES (2, 'Harish Pranesh', 35, 'O-', '6677889900');
INSERT INTO Patients VALUES (3, 'Jason', 44, 'A+', '7788990012');
INSERT INTO Patients VALUES (4, 'Chris Brown', 39, 'B+', '77889932411');
INSERT INTO Patients VALUES (5, 'Chris Black', 51, 'AB+', '77889932412');

INSERT INTO Requests VALUES (1, 1, 'Available');
INSERT INTO Requests VALUES (2, 2, 'Unavailable');
INSERT INTO Requests VALUES (1, 3, 'Available');

INSERT INTO Donates VALUES (1, 1);
INSERT INTO Donates VALUES (2, 2);


INSERT INTO Supplies VALUES (1, 1);
INSERT INTO Supplies VALUES (2, 2);

SHOW TABLES;

SELECT * FROM BloodBank;
SELECT * FROM Hospital;
SELECT * FROM Donor;
SELECT * FROM Patients;
SELECT * FROM Requests;
SELECT * FROM Donates;
SELECT * FROM Supplies;

ALTER TABLE BloodBank 
MODIFY COLUMN Name VARCHAR(100) NOT NULL;
ALTER TABLE Hospital 
MODIFY COLUMN Name VARCHAR(100) NOT NULL;
ALTER TABLE Donor 
MODIFY COLUMN Name VARCHAR(100) NOT NULL;
ALTER TABLE Patients 
MODIFY COLUMN Name VARCHAR(100) NOT NULL;

ALTER TABLE Donor ADD CONSTRAINT UNIQUE (Contact);
ALTER TABLE Patients ADD CONSTRAINT UNIQUE (Contact);
ALTER TABLE BloodBank ADD CONSTRAINT UNIQUE (Contact);
ALTER TABLE Hospital ADD CONSTRAINT  UNIQUE (Contact);

ALTER TABLE Donor ADD CONSTRAINT CHECK (Age >= 18);
ALTER TABLE Patients ADD CONSTRAINT CHECK (Age > 0);
ALTER TABLE Donor ADD CONSTRAINT CHECK (BloodType IN ('A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'));
ALTER TABLE Patients ADD CONSTRAINT CHECK (BloodType IN ('A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'));
ALTER TABLE Requests ADD CONSTRAINT CHECK (Availability IN ('Available', 'Unavailable'));

ALTER TABLE Requests 
MODIFY COLUMN Availability VARCHAR(100) DEFAULT 'Unavailable';

SELECT Name, BloodType FROM Donor WHERE BloodType = 'A+'
UNION
SELECT Name, BloodType FROM Patients WHERE BloodType = 'A+';

CREATE VIEW AvailableBlood
AS SELECT Bloodbank.Name, Requests.Availability
FROM Bloodbank
JOIN Requests ON Bloodbank.Bankid = Requests.Bankid;

CREATE VIEW DonorBloodBank AS  
SELECT Donor.Name AS DonorName, Donor.BloodType, BloodBank.Name AS BloodBankName, BloodBank.Location  
FROM Donor  
JOIN Donates ON Donor.DonorID = Donates.DonorID  
JOIN BloodBank ON Donates.BankID = BloodBank.BankID;

CREATE VIEW HospitalPatientSupplies AS  
SELECT Hospital.Name AS HospitalName, Hospital.Location,  
       Patients.Name AS PatientName, Patients.BloodType  
FROM Hospital  
JOIN Supplies ON Hospital.HospitalID = Supplies.HospitalID  
JOIN Patients ON Supplies.PatientID = Patients.PatientID;

DELIMITER //

CREATE TRIGGER trg_donor_age_check
BEFORE INSERT ON donor
FOR EACH ROW
BEGIN
  IF NEW.Age < 18 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Donor must be at least 18 years old';
  END IF;
END //

CREATE TRIGGER trg_donor_contact_check
BEFORE INSERT ON donor
FOR EACH ROW
BEGIN
  IF NEW.Contact IS NULL OR NEW.Contact = '' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Contact Number cannot be NULL or Empty for Donor';
  END IF;
END //

CREATE TRIGGER trg_hospital_contact_check
BEFORE INSERT ON hospital
FOR EACH ROW
BEGIN
  IF NEW.Contact IS NULL OR NEW.Contact = '' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Contact Number cannot be NULL or Empty for Hospital';
  END IF;
END //

CREATE TRIGGER trg_patient_contact_check
BEFORE INSERT ON patients
FOR EACH ROW
BEGIN
  IF NEW.Contact IS NULL OR NEW.Contact = '' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Contact Number cannot be NULL or Empty for Patient';
  END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE EligibleDonors()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE d_name VARCHAR(100);
    DECLARE d_contact VARCHAR(50);
    DECLARE d_last_date DATE;

    DECLARE donor_cursor CURSOR FOR
        SELECT Name, Contact, LastDonationDate FROM Donor;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN donor_cursor;

    read_loop: LOOP
        FETCH donor_cursor INTO d_name, d_contact, d_last_date;

        IF done THEN
            LEAVE read_loop;
        END IF;

        IF DATEDIFF(CURDATE(), d_last_date) > 90 THEN
            SELECT CONCAT('Eligible: ', d_name, ' | Contact: ', d_contact) AS EligibleDonor;
        END IF;
    END LOOP;

    CLOSE donor_cursor;
END //

DELIMITER ;

START TRANSACTION;
SELECT * FROM Donor WHERE DonorID = 1 FOR UPDATE;
INSERT INTO Donates (DonorID, BankID) VALUES (1, 2);
UPDATE Donor SET LastDonationDate = CURDATE() WHERE DonorID = 1;
COMMIT;

START TRANSACTION;
SELECT * FROM Donor WHERE DonorID = 1 FOR UPDATE;
SELECT * FROM BloodBank WHERE BankID = 2 FOR UPDATE;
INSERT INTO Donates (DonorID, BankID) VALUES (1, 2);
UPDATE Donor SET LastDonationDate = CURDATE() WHERE DonorID = 1;
COMMIT;


START TRANSACTION;
SELECT * FROM Patients WHERE PatientID = 2 FOR UPDATE;
INSERT INTO Supplies (HospitalID, PatientID) VALUES (2, 2);
COMMIT;

CREATE TABLE TransactionLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    Operation VARCHAR(100),
    Status VARCHAR(50),
    Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);

START TRANSACTION;
INSERT INTO TransactionLog (Operation, Status) VALUES ('Donate Blood', 'Started');
INSERT INTO Donates (DonorID, BankID) VALUES (2, 1);
UPDATE Donor SET LastDonationDate = CURDATE() WHERE DonorID = 2;
INSERT INTO TransactionLog (Operation, Status) VALUES ('Donate Blood', 'Committed');
COMMIT;

ROLLBACK;
INSERT INTO TransactionLog (Operation, Status) VALUES ('Donate Blood', 'Rolled Back');

START TRANSACTION;
UPDATE Donor SET Contact='0000000000' WHERE DonorID=3;
ROLLBACK; 
