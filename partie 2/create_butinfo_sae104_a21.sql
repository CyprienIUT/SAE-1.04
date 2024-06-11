DROP schema IF EXISTS programme_but CASCADE;
CREATE schema programme_but;
SET schema 'programme_but';

CREATE TABLE _competences (
    lib_competence VARCHAR(50) NOT NULL,
    CONSTRAINT _competences_pk PRIMARY KEY(lib_competence)
);

CREATE TABLE _activites (
    lib_activite VARCHAR(50) NOT NULL,
    lib_competence VARCHAR(50) NOT NULL,
    CONSTRAINT _activites_pk PRIMARY KEY(lib_activite),
    CONSTRAINT _activites_fk_competences
        FOREIGN KEY(lib_competence) REFERENCES _competences
);

CREATE TABLE _niveau (
    numero_N INTEGER NOT NULL,
    CONSTRAINT _niveau_pk PRIMARY KEY(numero_N)
);

CREATE TABLE _semestre (
    numero_sem CHAR(2) NOT NULL,
    numero_N INTEGER NOT NULL,
    CONSTRAINT _semestre_pk PRIMARY KEY(numero_sem),
    CONSTRAINT _semestre_fk_niveau
        FOREIGN KEY(numero_N) REFERENCES _niveau
);

CREATE TABLE _ue (
    code_UE VARCHAR(10) NOT NULL,
    numero_sem CHAR(2) NOT NULL,
    lib_activite VARCHAR(50) NOT NULL,
    CONSTRAINT _ue_pk PRIMARY KEY(code_UE),
    CONSTRAINT _UE_fk_activites
        FOREIGN KEY(lib_activite) REFERENCES _activites,
    CONSTRAINT _UE_fk_semestre
        FOREIGN KEY(numero_sem) REFERENCES _semestre
);

CREATE TABLE _parcours (
    code_P CHAR(1) NOT NULL,
    libelle_parcours VARCHAR(50) NOT NULL,
    nbre_gpe_TD_P INTEGER NOT NULL,
    nbre_gpe_TP_P INTEGER NOT NULL,
    CONSTRAINT _parcours_pk PRIMARY KEY(code_P)
);

CREATE TABLE _correspond (
    lib_activite VARCHAR(50) NOT NULL,
    numero_N INTEGER NOT NULL,
    code_P CHAR(1) NOT NULL,
    CONSTRAINT _correspond_pk PRIMARY KEY(lib_activite,numero_N,code_P),
    CONSTRAINT _correspond_fk_activite
        FOREIGN KEY(lib_activite) REFERENCES _activites,
    CONSTRAINT _correspond_fk_niveau
        FOREIGN KEY(numero_N) REFERENCES _niveau,
    CONSTRAINT _correspond_fk_parcours
        FOREIGN KEY(code_P) REFERENCES _parcours
);

CREATE TABLE _ressources (
    code_R CHAR(2) NOT NULL,
    lib_R VARCHAR(50) NOT NULL,
    nb_h_CM_PN INTEGER NOT NULL,
    nb_h_TD_PN INTEGER NOT NULL,
    nb_h_TP_PN INTEGER NOT NULL,
    numero_sem CHAR(2) NOT NULL,
    CONSTRAINT _ressources_pk PRIMARY KEY(code_R),
    CONSTRAINT _ressources_fk_semestre
        FOREIGN KEY(numero_sem) REFERENCES _semestre
);

CREATE TABLE _est_enseignee( 
    code_P CHAR(1) NOT NULL,
    code_R CHAR(2) NOT NULL,
    CONSTRAINT _est_enseignee_pk PRIMARY KEY(code_P, code_R),
    CONSTRAINT _est_enseignee_fk_parcours
        FOREIGN KEY(code_P) REFERENCES _parcours,
    CONSTRAINT _est_enseignee_fk_ressources
        FOREIGN KEY(code_R) REFERENCES _ressources   
);

CREATE TABLE _sae(
    code_SAE VARCHAR(10) NOT NULL,
    lib_SAE VARCHAR(50) NOT NULL,
    nb_h_TD_enc INTEGER NOT NULL,
    nb_h_TD_projet_autonomie INTEGER NOT NULL,
    CONSTRAINT _sae_pk PRIMARY KEY(code_SAE)
);

CREATE TABLE _comprend_R (
    code_R CHAR(2) NOT NULL,
    code_SAE VARCHAR(10) NOT NULL,
    nb_h_TD_C INTEGER NOT NULL,
    nb_h_TP_C INTEGER NOT NULL,
    CONSTRAINT _comprend_R_pk PRIMARY KEY(code_R, code_SAE),
    CONSTRAINT _comprend_R_fk_ressources
        FOREIGN KEY(code_R) REFERENCES _ressources,
    CONSTRAINT _comprend_R_fk_sae
        FOREIGN KEY(code_SAE) REFERENCES _sae
);
