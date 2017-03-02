/*
Sites:
id, name, location

Finds:
id, site_id, date, bone_id

Dino_Bones:
id, name, anatomy

Find names of the top 3 sites each year for Velociraptor Bones

*/

CREATE TABLE Sites
-- (id integer, name varchar(32), location varchar(32))
(id integer, name varchar(32))
;

INSERT INTO Sites
  (0, 'Kem Kem Beds')
, (1, 'Orapa')
, (2, 'Seymour Island')
, (3, 'Vega Island')
, (4, 'Cerro del Pueblo')
, (5, 'Como Bluff')
, (6, 'Cantwell Formation')
, (7, 'Ellisdale')
, (8, 'Eutaw Formation')
, (9, 'Hilda mega-bonebed')
;


CREATE TABLE Finds
(id integer, site_id integer, bone_id integer, date timestamp)
;

INSERT INTO Finds
()
;


CREATE TABLE Dino_Bones
(id integer, name varchar(32), anatomy varchar(32))
;

INSERT INTO Dino_Bones
  (0, 'Tyrannosaurus rex', 'rib')
, (1, 'Tyrannosaurus rex', 'femur')
, (2, 'Tyrannosaurus rex', 'metacarpal')
, (3, 'Tyrannosaurus rex', 'metatarsal')
, (4, 'Tyrannosaurus rex', 'pelvis')
, (5, 'Tyrannosaurus rex', 'skull')
, (6, 'Tyrannosaurus rex', 'vertebra')
, (7, 'Tyrannosaurus rex', 'humerus')
, (8, 'Tyrannosaurus rex', 'radius')
, (9, 'Tyrannosaurus rex', 'ulna')
, (10, 'Triceratops', 'rib')
, (11, 'Triceratops', 'femur')
, (12, 'Triceratops', 'metacarpal')
, (13, 'Triceratops', 'metatarsal')
, (14, 'Triceratops', 'pelvis')
, (15, 'Triceratops', 'skull')
, (16, 'Triceratops', 'vertebra')
, (17, 'Triceratops', 'humerus')
, (18, 'Triceratops', 'radius')
, (19, 'Triceratops', 'ulna')
, (20, 'Pteranodon', 'rib')
, (21, 'Pteranodon', 'femur')
, (22, 'Pteranodon', 'metacarpal')
, (23, 'Pteranodon', 'metatarsal')
, (24, 'Pteranodon', 'pelvis')
, (25, 'Pteranodon', 'skull')
, (26, 'Pteranodon', 'vertebra')
, (27, 'Pteranodon', 'humerus')
, (28, 'Pteranodon', 'radius')
, (29, 'Pteranodon', 'ulna')
, (30, 'Velociraptor', 'rib')
, (31, 'Velociraptor', 'femur')
, (32, 'Velociraptor', 'metacarpal')
, (33, 'Velociraptor', 'metatarsal')
, (34, 'Velociraptor', 'pelvis')
, (35, 'Velociraptor', 'skull')
, (36, 'Velociraptor', 'vertebra')
, (37, 'Velociraptor', 'humerus')
, (38, 'Velociraptor', 'radius')
, (39, 'Velociraptor', 'ulna')
;
