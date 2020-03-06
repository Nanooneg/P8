
CREATE SEQUENCE public.adresse_id_seq;

CREATE TABLE public.adresse (
                id INTEGER NOT NULL DEFAULT nextval('public.adresse_id_seq'),
                numero_voie INTEGER NOT NULL,
                voie VARCHAR(30) NOT NULL,
                code_postal INTEGER NOT NULL,
                ville VARCHAR(30) NOT NULL,
                CONSTRAINT adresse_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.adresse_id_seq OWNED BY public.adresse.id;

CREATE SEQUENCE public.pointdevente_id_seq;

CREATE TABLE public.pointDeVente (
                id INTEGER NOT NULL DEFAULT nextval('public.pointdevente_id_seq'),
                nom VARCHAR(30) NOT NULL,
                adresse_id INTEGER NOT NULL,
                CONSTRAINT pointdevente_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.pointdevente_id_seq OWNED BY public.pointDeVente.id;

CREATE SEQUENCE public.produit_id_seq;

CREATE TABLE public.produit (
                id INTEGER NOT NULL DEFAULT nextval('public.produit_id_seq'),
                nom VARCHAR(30) NOT NULL,
                prix_unitaire NUMERIC(4,2) NOT NULL,
                procedure VARCHAR(300) NOT NULL,
                CONSTRAINT produit_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.produit_id_seq OWNED BY public.produit.id;

CREATE SEQUENCE public.ingredient_id_seq;

CREATE TABLE public.ingredient (
                id INTEGER NOT NULL DEFAULT nextval('public.ingredient_id_seq'),
                nom VARCHAR(30) NOT NULL,
                unite_mesure VARCHAR(30) NOT NULL,
                CONSTRAINT ingredient_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.ingredient_id_seq OWNED BY public.ingredient.id;

CREATE TABLE public.listeIngredient (
                produit_id INTEGER NOT NULL,
                ingredient_id INTEGER NOT NULL,
                quantite INTEGER,
                CONSTRAINT listeingredient_pk PRIMARY KEY (produit_id, ingredient_id)
);


CREATE TABLE public.stock (
                point_de_vente_id INTEGER NOT NULL,
                ingredient_id INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT stock_pk PRIMARY KEY (point_de_vente_id, ingredient_id)
);


CREATE SEQUENCE public.utilisateur_id_seq;

CREATE TABLE public.utilisateur (
                id INTEGER NOT NULL DEFAULT nextval('public.utilisateur_id_seq'),
                nom VARCHAR(30) NOT NULL,
                prenom VARCHAR(30) NOT NULL,
                mail VARCHAR(100) NOT NULL,
                telephone VARCHAR(10) NOT NULL,
                password VARCHAR NOT NULL,
                date_creation TIMESTAMP NOT NULL,
                date_maj_compte TIMESTAMP NOT NULL,
                CONSTRAINT utilisateur_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.utilisateur_id_seq OWNED BY public.utilisateur.id;

CREATE SEQUENCE public.client_numero_client_seq;

CREATE TABLE public.client (
                client_id INTEGER NOT NULL,
                numero_client INTEGER NOT NULL DEFAULT nextval('public.client_numero_client_seq'),
                CONSTRAINT client_pk PRIMARY KEY (client_id)
);


ALTER SEQUENCE public.client_numero_client_seq OWNED BY public.client.numero_client;

CREATE SEQUENCE public.adresselivraison_adresse_livraison_id_seq;

CREATE TABLE public.adresseLivraison (
                adresse_livraison_id INTEGER NOT NULL DEFAULT nextval('public.adresselivraison_adresse_livraison_id_seq'),
                adresse_id INTEGER NOT NULL,
                client_id INTEGER NOT NULL,
                nom VARCHAR(30) NOT NULL,
                CONSTRAINT adresselivraison_pk PRIMARY KEY (adresse_livraison_id)
);


ALTER SEQUENCE public.adresselivraison_adresse_livraison_id_seq OWNED BY public.adresseLivraison.adresse_livraison_id;

CREATE SEQUENCE public.commande_id_seq;

CREATE SEQUENCE public.commande_numero_commande_seq;

CREATE TABLE public.commande (
                id INTEGER NOT NULL DEFAULT nextval('public.commande_id_seq'),
                numero_commande INTEGER NOT NULL DEFAULT nextval('public.commande_numero_commande_seq'),
                date_commande TIMESTAMP NOT NULL,
                date_maj_commande TIMESTAMP NOT NULL,
                prix_total INTEGER NOT NULL,
                type_paiemant VARCHAR(30) NOT NULL,
                statut VARCHAR(30) NOT NULL,
                client_id INTEGER NOT NULL,
                adresse_livraison_id INTEGER NOT NULL,
                CONSTRAINT commande_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.commande_id_seq OWNED BY public.commande.id;

ALTER SEQUENCE public.commande_numero_commande_seq OWNED BY public.commande.numero_commande;

CREATE TABLE public.ligneCommande (
                commande_id INTEGER NOT NULL,
                produit_id INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT lignecommande_pk PRIMARY KEY (commande_id, produit_id)
);


CREATE SEQUENCE public.employe_numero_employe_seq;

CREATE TABLE public.employe (
                employe_id INTEGER NOT NULL,
                numero_employe INTEGER NOT NULL DEFAULT nextval('public.employe_numero_employe_seq'),
                poste VARCHAR(30) NOT NULL,
                numero_ss NUMERIC(13) NOT NULL,
                point_de_vente_id INTEGER NOT NULL,
                adresse_id INTEGER NOT NULL,
                CONSTRAINT employe_pk PRIMARY KEY (employe_id)
);


ALTER SEQUENCE public.employe_numero_employe_seq OWNED BY public.employe.numero_employe;

CREATE TABLE public.listeEmployes (
                commande_id INTEGER NOT NULL,
                employe_id INTEGER NOT NULL,
                heure_prestation TIMESTAMP NOT NULL,
                CONSTRAINT listeemployes_pk PRIMARY KEY (commande_id, employe_id)
);


ALTER TABLE public.pointDeVente ADD CONSTRAINT adresse_pointdevente_fk
FOREIGN KEY (adresse_id)
REFERENCES public.adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.adresseLivraison ADD CONSTRAINT adresse_adresselivraison_fk
FOREIGN KEY (adresse_id)
REFERENCES public.adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.employe ADD CONSTRAINT adresse_employe_fk
FOREIGN KEY (adresse_id)
REFERENCES public.adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.stock ADD CONSTRAINT pointdevente_stock_fk
FOREIGN KEY (point_de_vente_id)
REFERENCES public.pointDeVente (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.employe ADD CONSTRAINT pointdevente_employe_fk
FOREIGN KEY (point_de_vente_id)
REFERENCES public.pointDeVente (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ligneCommande ADD CONSTRAINT produit_lignecommande_fk
FOREIGN KEY (produit_id)
REFERENCES public.produit (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.listeIngredient ADD CONSTRAINT produit_ficheproduit_fk
FOREIGN KEY (produit_id)
REFERENCES public.produit (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.stock ADD CONSTRAINT ingredient_lignedestock_fk
FOREIGN KEY (ingredient_id)
REFERENCES public.ingredient (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.listeIngredient ADD CONSTRAINT ingredient_listeingredient_fk
FOREIGN KEY (ingredient_id)
REFERENCES public.ingredient (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.employe ADD CONSTRAINT utilisateur_employe_fk
FOREIGN KEY (employe_id)
REFERENCES public.utilisateur (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.client ADD CONSTRAINT utilisateur_client_fk
FOREIGN KEY (client_id)
REFERENCES public.utilisateur (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT client_commande_fk
FOREIGN KEY (client_id)
REFERENCES public.client (client_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.adresseLivraison ADD CONSTRAINT client_adresselivraison_fk
FOREIGN KEY (client_id)
REFERENCES public.client (client_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT adresselivraison_commande_fk
FOREIGN KEY (adresse_livraison_id)
REFERENCES public.adresseLivraison (adresse_livraison_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ligneCommande ADD CONSTRAINT commande_lignecommande_fk
FOREIGN KEY (commande_id)
REFERENCES public.commande (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.listeEmployes ADD CONSTRAINT commande_listeemployes_fk
FOREIGN KEY (commande_id)
REFERENCES public.commande (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.listeEmployes ADD CONSTRAINT employe_listeemployes_fk
FOREIGN KEY (employe_id)
REFERENCES public.employe (employe_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
