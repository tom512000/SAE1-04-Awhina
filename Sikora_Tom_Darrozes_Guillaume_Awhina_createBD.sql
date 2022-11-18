/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 11g                            */
/* Date de création :  18/11/2022 13:27:28                      */
/*==============================================================*/


alter table ABSENCE
   drop constraint FK_ABSENCE_AVOIR_EMPLOYE;

alter table AFFECTER
   drop constraint FK_AFFECTER_AFFECTER_EMPLOYE;

alter table AFFECTER
   drop constraint FK_AFFECTER_AFFECTER2_DOSSIER;

alter table CHARGER
   drop constraint FK_CHARGER_CHARGER_EMPLOYE;

alter table CHARGER
   drop constraint FK_CHARGER_CHARGER2_ENFANT;

alter table CONDUIRE
   drop constraint FK_CONDUIRE_CONDUIRE_EMPLOYE;

alter table CONDUIRE
   drop constraint FK_CONDUIRE_CONDUIRE2_VEHICULE;

alter table DOSSIER
   drop constraint FK_DOSSIER_OCCUPER_CLIENT;

alter table EMPLOYE
   drop constraint FK_EMPLOYE_TRAVAILLE_AGENCE;

alter table PRENDRE_CONTACT
   drop constraint FK_PRENDRE__PRENDRE_C_CLIENT;

alter table PRENDRE_CONTACT
   drop constraint FK_PRENDRE__PRENDRE_C_EMPLOYE;

alter table SUBIR
   drop constraint FK_SUBIR_SUBIR_VEHICULE;

alter table SUBIR
   drop constraint FK_SUBIR_SUBIR2_IMMOBILI;

alter table VEHICULE
   drop constraint FK_VEHICULE_POSSEDER_AGENCE;

alter table VEHICULE
   drop constraint FK_VEHICULE_UTILISER_DOSSIER;

drop index AVOIR_FK;

drop table ABSENCE cascade constraints;

drop index AFFECTER2_FK;

drop index AFFECTER_FK;

drop table AFFECTER cascade constraints;

drop table AGENCE cascade constraints;

drop index CHARGER2_FK;

drop index CHARGER_FK;

drop table CHARGER cascade constraints;

drop table CLIENT cascade constraints;

drop index CONDUIRE2_FK;

drop index CONDUIRE_FK;

drop table CONDUIRE cascade constraints;

drop index OCCUPER_FK;

drop table DOSSIER cascade constraints;

drop index TRAVAILLER_FK;

drop table EMPLOYE cascade constraints;

drop table ENFANT cascade constraints;

drop table IMMOBILISATION cascade constraints;

drop index PRENDRE_CONTACT2_FK;

drop index PRENDRE_CONTACT_FK;

drop table PRENDRE_CONTACT cascade constraints;

drop index SUBIR2_FK;

drop index SUBIR_FK;

drop table SUBIR cascade constraints;

drop index POSSEDER_FK;

drop index UTILISER_FK;

drop table VEHICULE cascade constraints;

/*==============================================================*/
/* Table : ABSENCE                                              */
/*==============================================================*/
create table ABSENCE 
(
   IDABS                INTEGER              not null,
   IDEMPL               INTEGER              not null,
   DATEDEBABS           DATE                 not null,
   DATEFINABS           DATE                 not null,
   MOTIFABS             VARCHAR2(50)         not null,
   ETATABS              VARCHAR2(50),
   DATEDEMABS           DATE                 not null,
   DATEREPABS           DATE                 not null,
   constraint PK_ABSENCE primary key (IDABS)
);

/*==============================================================*/
/* Index : AVOIR_FK                                             */
/*==============================================================*/
create index AVOIR_FK on ABSENCE (
   IDEMPL ASC
);

/*==============================================================*/
/* Table : AFFECTER                                             */
/*==============================================================*/
create table AFFECTER 
(
   IDEMPL               INTEGER              not null,
   IDDOSS               CHAR(11)             not null,
   constraint PK_AFFECTER primary key (IDEMPL, IDDOSS)
);

/*==============================================================*/
/* Index : AFFECTER_FK                                          */
/*==============================================================*/
create index AFFECTER_FK on AFFECTER (
   IDEMPL ASC
);

/*==============================================================*/
/* Index : AFFECTER2_FK                                         */
/*==============================================================*/
create index AFFECTER2_FK on AFFECTER (
   IDDOSS ASC
);

/*==============================================================*/
/* Table : AGENCE                                               */
/*==============================================================*/
create table AGENCE 
(
   IDAG                 INTEGER              not null,
   LIBAG                VARCHAR2(30)         not null,
   CPAG                 CHAR(5)              not null,
   ADAG                 VARCHAR2(50)         not null,
   VILLEAG              VARCHAR2(30)         not null,
   TELAG                CHAR(10)             not null,
   EMAILAG              VARCHAR2(30)         not null,
   DATEOUVERT           DATE                 not null,
   DATEFERME            DATE                 not null,
   constraint PK_AGENCE primary key (IDAG)
);

/*==============================================================*/
/* Table : CHARGER                                              */
/*==============================================================*/
create table CHARGER 
(
   IDEMPL               INTEGER              not null,
   IDENF                INTEGER              not null,
   constraint PK_CHARGER primary key (IDEMPL, IDENF)
);

/*==============================================================*/
/* Index : CHARGER_FK                                           */
/*==============================================================*/
create index CHARGER_FK on CHARGER (
   IDEMPL ASC
);

/*==============================================================*/
/* Index : CHARGER2_FK                                          */
/*==============================================================*/
create index CHARGER2_FK on CHARGER (
   IDENF ASC
);

/*==============================================================*/
/* Table : CLIENT                                               */
/*==============================================================*/
create table CLIENT 
(
   IDCLT                INTEGER              not null,
   NOMCLT               VARCHAR2(30)         not null,
   PNOMCLT              VARCHAR2(30)         not null,
   ADCLT                VARCHAR2(50)         not null,
   CPCLT                CHAR(5)              not null,
   VILLECLT             VARCHAR2(30)         not null,
   TELCLT               CHAR(10)             not null,
   EMAILCLT             VARCHAR2(30)         not null,
   constraint PK_CLIENT primary key (IDCLT)
);

/*==============================================================*/
/* Table : CONDUIRE                                             */
/*==============================================================*/
create table CONDUIRE 
(
   IDEMPL               INTEGER              not null,
   IDVHC                INTEGER              not null,
   NBKMCOND             INTEGER              not null,
   TEMPSCOND            DATE                 not null,
   constraint PK_CONDUIRE primary key (IDEMPL, IDVHC)
);

/*==============================================================*/
/* Index : CONDUIRE_FK                                          */
/*==============================================================*/
create index CONDUIRE_FK on CONDUIRE (
   IDEMPL ASC
);

/*==============================================================*/
/* Index : CONDUIRE2_FK                                         */
/*==============================================================*/
create index CONDUIRE2_FK on CONDUIRE (
   IDVHC ASC
);

/*==============================================================*/
/* Table : DOSSIER                                              */
/*==============================================================*/
create table DOSSIER 
(
   IDDOSS               CHAR(11)             not null,
   IDCLT                INTEGER              not null,
   ETATDOSS             VARCHAR2(30)         not null
      constraint CKC_ETATDOSS_DOSSIER check (ETATDOSS in ('1','2','3','4')),
   DATEDMD              DATE                 not null,
   DATECLOT             DATE,
   FORM                 VARCHAR2(50)        
      constraint CKC_FORM_DOSSIER check (FORM is null or (FORM in ('1','2','3','4'))),
   DATECHARGE           DATE                 not null,
   ADCHARGE             VARCHAR2(50)         not null,
   CPCHARGE             CHAR(5)              not null,
   VILLECHARGE          VARCHAR2(30)         not null,
   LATCHARGE            FLOAT,
   LONGCHARGE           FLOAT,
   TELCHARGE            CHAR(10),
   DATELIV              DATE                 not null,
   ADLIV                VARCHAR2(50)         not null,
   CPLIV                CHAR(5)              not null,
   VILLELIV             VARCHAR2(30)         not null,
   LATLIV               FLOAT,
   LONGLIV              FLOAT,
   TELLIV               CHAR(10),
   PRIXTOTAL            FLOAT,
   NBMCUBE              INTEGER              not null,
   NBKMTOT              INTEGER              not null,
   REMARQUEDOSS         VARCHAR2(100),
   NBDMG                INTEGER,
   NBVHC                INTEGER,
   constraint PK_DOSSIER primary key (IDDOSS)
);

/*==============================================================*/
/* Index : OCCUPER_FK                                           */
/*==============================================================*/
create index OCCUPER_FK on DOSSIER (
   IDCLT ASC
);

/*==============================================================*/
/* Table : EMPLOYE                                              */
/*==============================================================*/
create table EMPLOYE 
(
   IDEMPL               INTEGER              not null,
   IDAG                 INTEGER              not null,
   IDPERMIS             CHAR(12),
   NOMEMPL              VARCHAR2(30)         not null,
   PNOMEMPL             VARCHAR2(30)         not null,
   TYPEEMPL             VARCHAR2(30)         not null
      constraint CKC_TYPEEMPL_EMPLOYE check (TYPEEMPL in ('1','2','3')),
   DATENAIS             DATE                 not null,
   SEXE                 CHAR(5)              not null
      constraint CKC_SEXE_EMPLOYE check (SEXE in ('1','2')),
   TELEMPL              CHAR(10)             not null,
   CAPACITEEMPL         SMALLINT,
   ADEMPL               VARCHAR2(50)         not null,
   CPEMPL               CHAR(5)              not null,
   VILLEEMPL            VARCHAR2(30)         not null,
   DATEEMB              DATE,
   NBDMGT               INTEGER,
   ANNEANCIEN           INTEGER,
   constraint PK_EMPLOYE primary key (IDEMPL)
);

/*==============================================================*/
/* Index : TRAVAILLER_FK                                        */
/*==============================================================*/
create index TRAVAILLER_FK on EMPLOYE (
   IDAG ASC
);

/*==============================================================*/
/* Table : ENFANT                                               */
/*==============================================================*/
create table ENFANT 
(
   IDENF                INTEGER              not null,
   NOMENF               VARCHAR2(30)         not null,
   PNOMENF              VARCHAR2(30)         not null,
   AGEENF               INTEGER              not null,
   ROLEPAR              VARCHAR2(2)          not null
      constraint CKC_ROLEPAR_ENFANT check (ROLEPAR in ('1','2','3','4','5')),
   constraint PK_ENFANT primary key (IDENF)
);

/*==============================================================*/
/* Table : IMMOBILISATION                                       */
/*==============================================================*/
create table IMMOBILISATION 
(
   IDIMMO               INTEGER              not null,
   TYPEIMMO             CHAR(20)             not null
      constraint CKC_TYPEIMMO_IMMOBILI check (TYPEIMMO in ('1','2','3')),
   NBKMIMMO             INTEGER              not null,
   DATEDEBIMMO          DATE                 not null,
   DATEFINIMMO          DATE                 not null,
   MOTIFIMMO            VARCHAR2(30),
   LIBGARAGE            VARCHAR2(30),
   ADGARAGE             VARCHAR2(50),
   CPGARAGE             CHAR(5),
   VILLEGARAGE          VARCHAR2(30),
   TELGARAGE            CHAR(10),
   constraint PK_IMMOBILISATION primary key (IDIMMO)
);

/*==============================================================*/
/* Table : PRENDRE_CONTACT                                      */
/*==============================================================*/
create table PRENDRE_CONTACT 
(
   IDCLT                INTEGER              not null,
   IDEMPL               INTEGER              not null,
   DATEVISITE           DATE                 not null,
   VOLUMEMOB            FLOAT                not null,
   CONDITIONACCES       VARCHAR2(50),
   constraint PK_PRENDRE_CONTACT primary key (IDCLT, IDEMPL)
);

/*==============================================================*/
/* Index : PRENDRE_CONTACT_FK                                   */
/*==============================================================*/
create index PRENDRE_CONTACT_FK on PRENDRE_CONTACT (
   IDCLT ASC
);

/*==============================================================*/
/* Index : PRENDRE_CONTACT2_FK                                  */
/*==============================================================*/
create index PRENDRE_CONTACT2_FK on PRENDRE_CONTACT (
   IDEMPL ASC
);

/*==============================================================*/
/* Table : SUBIR                                                */
/*==============================================================*/
create table SUBIR 
(
   IDVHC                INTEGER              not null,
   IDIMMO               INTEGER              not null,
   constraint PK_SUBIR primary key (IDVHC, IDIMMO)
);

/*==============================================================*/
/* Index : SUBIR_FK                                             */
/*==============================================================*/
create index SUBIR_FK on SUBIR (
   IDVHC ASC
);

/*==============================================================*/
/* Index : SUBIR2_FK                                            */
/*==============================================================*/
create index SUBIR2_FK on SUBIR (
   IDIMMO ASC
);

/*==============================================================*/
/* Table : VEHICULE                                             */
/*==============================================================*/
create table VEHICULE 
(
   IDVHC                INTEGER              not null,
   IDDOSS               CHAR(11),
   IDAG                 INTEGER              not null,
   ADVHC                VARCHAR2(50),
   CPVHC                CHAR(5),
   VILLEVHC             VARCHAR2(30),
   LATVHC               FLOAT,
   LONGVHC              FLOAT,
   IMMATVHC             CHAR(9)              not null,
   DATECIRC             DATE                 not null,
   VOLUTILE             FLOAT,
   NBPLACES             INTEGER,
   HAYON                SMALLINT,
   COUCHETTE            SMALLINT,
   TYPEVHC              VARCHAR2(30)         not null,
   MARQUEVHC            VARCHAR2(30)         not null,
   FREQENTR             INTEGER,
   COUTKM               FLOAT,
   PTACVHC              FLOAT,
   constraint PK_VEHICULE primary key (IDVHC)
);

/*==============================================================*/
/* Index : UTILISER_FK                                          */
/*==============================================================*/
create index UTILISER_FK on VEHICULE (
   IDDOSS ASC
);

/*==============================================================*/
/* Index : POSSEDER_FK                                          */
/*==============================================================*/
create index POSSEDER_FK on VEHICULE (
   IDAG ASC
);

alter table ABSENCE
   add constraint FK_ABSENCE_AVOIR_EMPLOYE foreign key (IDEMPL)
      references EMPLOYE (IDEMPL);

alter table AFFECTER
   add constraint FK_AFFECTER_AFFECTER_EMPLOYE foreign key (IDEMPL)
      references EMPLOYE (IDEMPL);

alter table AFFECTER
   add constraint FK_AFFECTER_AFFECTER2_DOSSIER foreign key (IDDOSS)
      references DOSSIER (IDDOSS);

alter table CHARGER
   add constraint FK_CHARGER_CHARGER_EMPLOYE foreign key (IDEMPL)
      references EMPLOYE (IDEMPL);

alter table CHARGER
   add constraint FK_CHARGER_CHARGER2_ENFANT foreign key (IDENF)
      references ENFANT (IDENF);

alter table CONDUIRE
   add constraint FK_CONDUIRE_CONDUIRE_EMPLOYE foreign key (IDEMPL)
      references EMPLOYE (IDEMPL);

alter table CONDUIRE
   add constraint FK_CONDUIRE_CONDUIRE2_VEHICULE foreign key (IDVHC)
      references VEHICULE (IDVHC);

alter table DOSSIER
   add constraint FK_DOSSIER_OCCUPER_CLIENT foreign key (IDCLT)
      references CLIENT (IDCLT);

alter table EMPLOYE
   add constraint FK_EMPLOYE_TRAVAILLE_AGENCE foreign key (IDAG)
      references AGENCE (IDAG);

alter table PRENDRE_CONTACT
   add constraint FK_PRENDRE__PRENDRE_C_CLIENT foreign key (IDCLT)
      references CLIENT (IDCLT);

alter table PRENDRE_CONTACT
   add constraint FK_PRENDRE__PRENDRE_C_EMPLOYE foreign key (IDEMPL)
      references EMPLOYE (IDEMPL);

alter table SUBIR
   add constraint FK_SUBIR_SUBIR_VEHICULE foreign key (IDVHC)
      references VEHICULE (IDVHC);

alter table SUBIR
   add constraint FK_SUBIR_SUBIR2_IMMOBILI foreign key (IDIMMO)
      references IMMOBILISATION (IDIMMO);

alter table VEHICULE
   add constraint FK_VEHICULE_POSSEDER_AGENCE foreign key (IDAG)
      references AGENCE (IDAG);

alter table VEHICULE
   add constraint FK_VEHICULE_UTILISER_DOSSIER foreign key (IDDOSS)
      references DOSSIER (IDDOSS);

