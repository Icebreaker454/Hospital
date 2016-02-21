USE Hospital;

/* 70000+ */
INSERT INTO Addresses (zip_code, country, city, region, street, building, apt) VALUES
	(79031, 'Ukraine', 'Lviv', 'Lvivska', 'Demnyanska', 6, 8 ),
	(79031, 'Ukraine', 'Lviv', 'Lvivska', 'Hasheka', 16, 11 ),
	(79031, 'Ukraine', 'Lviv', 'Lvivska', 'Skoryny', 4, 46 ),
	(79029, 'Ukraine', 'Lviv', 'Lvivska', 'Karbysheva', 3, 9 ),
	(79029, 'Ukraine', 'Lviv', 'Lvivska', 'Mazepy', 112, NULL ),
	(79001, 'Ukraine', 'Lviv', 'Lvivska', 'Svobody', 32, 6 ),
	(79001, 'Ukraine', 'Lviv', 'Lvivska', 'Gorodotska', 67, 1 ),
	(79301, 'Ukraine', 'Sambir', 'Lvivska', 'Shevchenka', 22, 8 ),
	(79501, 'Ukraine', 'Rudky', 'Lvivska', 'Lytovska', 13, 21 ),
	(72122, 'Ukraine', 'Kyiv', 'Kyivska', 'Hreschatyk', 54, 18 ),
	(72122, 'Ukraine', 'Kyiv', 'Kyivska', 'Grushevskogo', 18, 25 ),
	(72122, 'Ukraine', 'Kyiv', 'Kyivska', 'Nezalezhnosti', 31, 83 ),
	(72123, 'Ukraine', 'Kyiv', 'Kyivska', 'Andriivskyi Uzviz', 6, 31 ),
	(72123, 'Ukraine', 'Kyiv', 'Kyivska', 'Technichna', 40, 22 ),
	(72127, 'Ukraine', 'Kyiv', 'Kyivska', 'Promyslova', 39, 29 );
/* 10000+ */
INSERT INTO Patients (first_name, last_name, middle_name, patient_address, notes) VALUES
	('Gregor', 'Bresyshkevich', 'Jan', 70000, 'Quiet And Tolerative'),
	('Albert', 'Einstein', 'Erich', 70001, 'Innovative and cold-minded'),
	('Isaac', 'Newton', 'Peter', 70002, 'Crazy scientist'),
	('Alex', 'Messer', 'Voldemar', 70003, 'Ex-Colonel'),
	('Ludvig', 'Bethoven', 'Van', 70004, 'A beautiful musician'),
	('Erich', 'Krause', 'Von', 70005, 'A genious description'),
	('Nazariy', 'Dahk', 'Ivanovich', 70006, 'Does like to get off university'),
	('Viktor', 'Sadovy', 'Vasylovich', 70007, 'Pretty shitty dude'),
	('Taras', 'Telegiy', 'Oleksiyovych', 70008, 'Typical perfectionist'),
	('Sofia', 'Rymonyuk', 'Ignativna', 70009, 'Same as before');
/* 655000+1000 */
INSERT INTO Specializations (name, spec_description) VALUES
	('Cardiology', 'Specializes on human hearth'),
	('Surgery', 'Curing all kinds of mechanical traumas'),
	('Neurology', 'Examines Humans Mind activities'),
	('Intense theraphy', 'HOUSE M.D and his followers');
/* 1000+ */
INSERT INTO Doctors (last_name, doctor_address, specialization) VALUES
	('Evans', 70010, 655000),
	('Mayers', 70011, 656000),
	('Feth', 70012, 657000),
	('Colemann', 70013, 658000),
	('Smith', 70014, 658000);
/* 44000+ */
INSERT INTO Ingredients (codename) VALUES
	('Aspirine'),
	('Betaglunozoline'),
	('Codeine'),
	('Dextrine'),
	('E Vitamin'),
	('Flugozole'),
	('Hidrocloric Acid'),
	('Jyssezine'),
	('Levomikoline'),
	('Neuropronine'),
	('Peniciline'),
	('Restizine'),
	('Zenoconic Acid');
/* 50000+10 */
INSERT INTO Medicine (name) VALUES
	('Aspirine'),
	('GNU Painkiller'),
	('Zelda'),
	('Proprex'),
	('Anti-BIO Tec'),
	('Gripex'),
	('Atropine'),
	('Teocentrine');

INSERT INTO Containment (ingredient, medicine) VALUES
	(44001, 50000),
	(44001, 50010),
	(44001, 50020),
	(44001, 50030),
	(44001, 50040),
	(44001, 50050),
	(44001, 50060),
	(44001, 50070),
	(44003, 50000),
	(44003, 50010),
	(44003, 50020),
	(44003, 50030),
	(44003, 50040),
	(44003, 50050),
	(44003, 50060),
	(44003, 50070),
	(44000, 50000),
	(44004, 50000),
	(44002, 50010),
	(44005, 50020),
	(44006, 50020),
	(44007, 50020),
	(44008, 50030),
	(44009, 50040),
	(44010, 50050),
	(44011, 50060),
	(44012, 50070);

INSERT INTO Restrictions (patient, ingredient) VALUES
	(10000, 44002),
	(10000, 44004),
	(10003, 44005),
	(10003, 44006),
	(10005, 44005),
	(10005, 44008),
	(10007, 44002),
	(10007, 44009),
	(10009, 44010),
	(10009, 44012)
/* 335000+ */
INSERT INTO Diagnosis (name, symptoms) VALUES
	('Basic Trauma', 'Bleeding, bonebreaks'),
	('Brain Shock', 'Headache, Puke'),
	('Appendicite', 'Enormous pain near the right kidney, Temperature'),
	('Common Cold', 'Temperature, Headache'),
	('Heart Attack', 'Chest Pain'),
	('Aortas blow', 'Immediate Death'),
	('Intoxication', 'Temperature, Headache, Puke'),
	('Malaria', 'Fever');
/* 972000+ */	
INSERT INTO MedicalHistory(patient, doctor, start_treatment, end_treatment, mark) VALUES
	(10001, 1000, '2015-01-01', '2015-01-14', 90),
	(10001, 1000, '2015-02-18', '2015-02-22', 90),
	(10001, 1002, '2015-03-25', '2015-03-27', 87),
	(10001, 1003, '2015-03-02', '2015-03-20', 87),
	(10002, 1001, '2015-04-01', '2015-04-03', 99),
	(10002, 1001, '2015-05-01', '2015-05-03', 97),
	(10002, 1003, '2015-04-05', '2015-04-07', 89),
	(10003, 1001, '2015-06-06', '2015-06-12', 100),
	(10003, 1002, '2015-06-06', '2015-06-12', 98),
	(10003, 1002, '2015-07-01', '2015-07-03', 90),
	(10003, 1003, '2015-07-10', '2015-07-12', 91),
	(10004, 1000, '2015-02-02', '2015-02-03', 65),
	(10004, 1001, '2015-04-12', '2015-04-22', 88),
	(10005, 1004, '2015-05-02', '2015-05-11', 100),
	(10006, 1002, '2015-09-09', '2015-09-11', 97),
	(10006, 1001, '2015-07-07', '2015-07-12', 80),
	(10007, 1000, '2015-09-01', '2015-09-10', 98),
	(10007, 1002, '2015-10-06', NULL, NULL),
	(10007, 1004, '2015-01-02', '2015-01-06', 56),
	(10008, 1003, '2015-08-02', '2015-08-05', 100),
	(10008, 1004, '2015-10-07', NULL, NULL),
	(10009, 1000, '2015-10-05', NULL, NULL);

INSERT INTO ConfirmedDiagnosis (medical_history, diagnosis) VALUES
	(972000, 335003),
	(972000, 335004),
	(972001, 335001),
	(972002, 335002),
	(972003, 335003),
	(972004, 335004),
	(972005, 335001),
	(972006, 335002),
	(972007, 335006),
	(972008, 335001),
	(972009, 335002),
	(972009, 335005),
	(972010, 335007),
	(972010, 335003),
	(972011, 335002),
	(972012, 335004),
	(972013, 335004),
	(972014, 335001),
	(972015, 335003),
	(972016, 335004),
	(972017, 335001),
	(972019, 335003),
	(972020, 335004);

INSERT INTO ChosenTreatment (medical_history, medicine) VALUES
	(972000, 50000),
	(972001, 50010),
	(972002, 50020),
	(972003, 50030),
	(972004, 50040),
	(972005, 50050),
	(972006, 50060),
	(972007, 50070),
	(972008, 50000),
	(972009, 50010),
	(972010, 50020),
	(972011, 50030),
	(972012, 50040),
	(972013, 50050),
	(972014, 50060),
	(972015, 50070),
	(972016, 50000),
	(972017, 50010),
	(972019, 50020),
	(972020, 50030);	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 