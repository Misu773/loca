-- EXÉCUTE CE SCRIPT DANS LE SQL EDITOR DE SUPABASE DASHBOARD

-- Ajouter la colonne user_token à la table commentaires
ALTER TABLE commentaires ADD COLUMN IF NOT EXISTS user_token text DEFAULT '';

-- Fonction pour supprimer son propre commentaire (vérification par jeton)
CREATE OR REPLACE FUNCTION supprimer_mon_commentaire(commentaire_id uuid, token text)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  DELETE FROM commentaires WHERE id = commentaire_id AND user_token = token;
  RETURN FOUND;
END;
$$;
