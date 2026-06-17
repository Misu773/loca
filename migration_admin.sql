-- EXÉCUTE CE SCRIPT DANS LE SQL EDITOR DE SUPABASE DASHBOARD
-- Après avoir exécuté migration.sql

-- Fonction pour vérifier le mot de passe admin
CREATE OR REPLACE FUNCTION verifier_mot_de_passe_admin(password text)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN password = 'Kutz_Industrie';
END;
$$;

-- Fonction pour supprimer un commentaire (admin seulement)
CREATE OR REPLACE FUNCTION supprimer_commentaire_admin(commentaire_id uuid, password text)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  IF NOT verifier_mot_de_passe_admin(password) THEN
    RAISE EXCEPTION 'Mot de passe incorrect';
  END IF;
  DELETE FROM commentaires WHERE id = commentaire_id;
  RETURN FOUND;
END;
$$;
