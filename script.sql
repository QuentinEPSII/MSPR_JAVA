USE mspr_java;

--DROP TABLE BusinessIncident;
--DROP TABLE Users_Worksite;
--DROP TABLE BusinessProject;
--DROP TABLE Incident;
--DROP TABLE Video;
--DROP TABLE Projects;
--DROP TABLE Worksite;
--DROP TABLE Users;
--DROP TABLE Business;

CREATE TABLE Users (
	id INT NOT NULL IDENTITY(1,1),
	firstname nvarchar(255),
	lastname nvarchar(255),
    rights nvarchar(255),
    yearStart nvarchar(255),   
	PRIMARY KEY(id)
);

CREATE TABLE Worksite (
	id INT NOT NULL,
	latitude DECIMAL,
    longitude DECIMAL,
    name nvarchar(255),
    startDate DATE,
    endDate DATE,
	PRIMARY KEY(id)
);

CREATE TABLE Projects (
	id INT NOT NULL,
	startDate date,
    endDate date,
	idWorksite INT,
	name nvarchar(255),
	PRIMARY KEY(id),
    CONSTRAINT Project_Worksite_FK FOREIGN KEY (idWorksite) REFERENCES Worksite(id)
);

CREATE TABLE Video (
	id INT NOT NULL,
    idProject INT,
	name nvarchar(255),
    refGant INT,
    indoor bit,
    latitude DECIMAL,
    longitude DECIMAL,
    video nvarchar(255),
	PRIMARY KEY(id),
    CONSTRAINT Video_Project_FK FOREIGN KEY (idProject) REFERENCES Projects(id)
);

CREATE TABLE Incident (
	id INT IDENTITY(1,1),
    idVideo INT NOT NULL,
	description nvarchar(255),
	PRIMARY KEY(id),
    CONSTRAINT Incident_Video_FK FOREIGN KEY (idVideo) REFERENCES Video(id)
);

CREATE TABLE Users_Worksite (
	idWorksite INT NOT NULL,
	idUser INT NOT NULL,
	PRIMARY KEY(idWorksite, idUser),
    CONSTRAINT UserWorksite_User_FK FOREIGN KEY (idUser) REFERENCES Users(id),
    CONSTRAINT UserWorksite_Worksite_FK FOREIGN KEY (idWorksite) REFERENCES Worksite(id)
);

CREATE TABLE Business (
	siret INT NOT NULL,
    name nvarchar(255),
    address nvarchar(255),
    employees INT,
    phone nvarchar(16),
    mail nvarchar(255),
	description nvarchar(255),
	PRIMARY KEY(siret)
);

CREATE TABLE BusinessIncident (
	idIncident INT NOT NULL,
    idBusiness INT NOT NULL,
	PRIMARY KEY(idIncident, idBusiness),
    CONSTRAINT BusinessIncident_Incident_FK FOREIGN KEY (idIncident) REFERENCES Incident(id),
    CONSTRAINT BusinessIncident_Business_FK FOREIGN KEY (idBusiness) REFERENCES Business(siret)
);

CREATE TABLE BusinessProject (
	idBusiness INT NOT NULL,
    idProject INT NOT NULL,
	PRIMARY KEY(idBusiness, idProject),
    CONSTRAINT BusinessProject_Business_FK FOREIGN KEY (idBusiness) REFERENCES Business(siret),
    CONSTRAINT BusinessProject_Project_FK FOREIGN KEY (idProject) REFERENCES Projects(id)
);


--insert into Worksite(latitude, longitude, name, startDate, endDate) values ('-33.867886', '-63.987', 'Guitare', '2012-21-10', '2012-21-12');


insert into Users(id, firstname, lastname, rights, yearStart) values (1, 'Frédéric', 'Pouchan', 'ADMIN', 2012);
insert into Users(id, firstname, lastname, rights, yearStart) values (2, 'Quentin', 'GEORGHIOU', 'ADMIN', 2012);
insert into Users(id, firstname, lastname, rights, yearStart) values (3, 'Nicolas', 'Galy', 'ADMIN', 2012);
insert into Users(id, firstname, lastname, rights, yearStart) values (4, 'David', 'Cerna', 'ADMIN', 2012);
insert into Users(id, firstname, lastname, rights, yearStart) values (5, 'Larbin', 'larbin', 'USER', 2010);

insert into Worksite(id, latitude, longitude, name, startDate, endDate) values (1, '45.186973698061685', '5.7770144356323145', 'EPSI GRENOBLE', '2013-07-05', '2014-11-14');
insert into Worksite(id, latitude, longitude, name, startDate, endDate) values (2, '33.747252', '112.633853', 'Triangle', '2012-10-10', '2012-11-10');
insert into Worksite(id, latitude, longitude, name, startDate, endDate) values (3, '-33.867886', '-63.987', 'Guitare', '2012-12-21', '2012-12-27');

insert into Projects(id, startDate, endDate, idWorksite, name) values (1, '2021-01-01', '2021-12-31', 1, 'Projet N°1');
insert into Projects(id, startDate, endDate, idWorksite, name) values (2, '2021-02-01', '2021-12-31', 2, 'Projet N°2');
insert into Projects(id, startDate, endDate, idWorksite, name) values (3, '2021-03-01', '2021-12-31', 3, 'Projet N°3');

insert into Video(id, idProject, name, refGant, indoor, latitude, longitude, video) values (1, 1, 'Video test N°1 EPSI GRENOBLE', 42, 1, '45.186973698061685', '5.7770144356323145', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ');
insert into Video(id, idProject, name, refGant, indoor, latitude, longitude, video) values (2, 1, 'Video test N°2 Triangle', 27, 0, '33.747252', '112.633853', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ');
insert into Video(id, idProject, name, refGant, indoor, latitude, longitude, video) values (3, 3, 'Video test N°3 Guitare', 12, 1, '-33.867886', '-63.987', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ');
insert into Video(id, idProject, name, refGant, indoor, latitude, longitude, video) values (4, 3, 'Video test N°4 Rien de fou', 12, 1, '-33.867886', '-63.987', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ');
insert into Video(id, idProject, name, refGant, indoor, latitude, longitude, video) values (5, 2, 'Video test N°5 Toujours rien de fou', 12, 1, '-33.867886', '-63.987', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ');

INSERT INTO Incident(idVideo, description) VALUES (1, 'Une description où je ne sais pas vraiment quoi dire');
INSERT INTO Incident(idVideo, description) VALUES (2, 'Il y a eu un gros incident la wow');
INSERT INTO Incident(idVideo, description) VALUES (3, 'Un café renversé');

insert into Users_Worksite(idWorksite, idUser) values (1, 1);
insert into Users_Worksite(idWorksite, idUser) values (2, 2);
insert into Users_Worksite(idWorksite, idUser) values (3, 3);

insert into Business(siret, name, address, employees, phone, mail, description) values (123456789, 'Business N°1', '42 rue de la vérité', 125, '+33654124152', 'emaildetest@test.com', 'Super business qui rapporte beaucoup de thunes');
insert into Business(siret, name, address, employees, phone, mail, description) values (987654321, 'Business N°2', '4h20 rue du plaisir', 142, '+33420420420', 'emaildetest2@test.com', 'Business qui respect ses employés');
insert into Business(siret, name, address, employees, phone, mail, description) values (123456780, 'Business N°3', '69 j''ai plus d''inspi', 158, '+33654124152', 'emaildetest3@test.com', 'Super business qui rapporte beaucoup de thunes');

INSERT INTO BusinessProject VALUES (123456789, 1)
INSERT INTO BusinessProject VALUES (123456789, 3)
INSERT INTO BusinessProject VALUES (987654321, 3)
INSERT INTO BusinessProject VALUES (987654321, 2)
INSERT INTO BusinessProject VALUES (123456780, 2)


insert into BusinessIncident(idIncident, idBusiness) values (1, 123456789);
insert into BusinessIncident(idIncident, idBusiness) values (2, 987654321);
insert into BusinessIncident(idIncident, idBusiness) values (3, 123456780);