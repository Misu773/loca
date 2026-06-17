-- EXÉCUTE CE SCRIPT DANS LE SQL EDITOR DE SUPABASE DASHBOARD
-- https://app.supabase.com/project/cvskoyqlreuckynebwdv/sql/new

-- Table principale des commentaires avec système de réponses
CREATE TABLE IF NOT EXISTS commentaires (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  parent_id uuid REFERENCES commentaires(id) ON DELETE CASCADE,
  nom text NOT NULL,
  lieu text NOT NULL,
  commentaire text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Index pour accélérer les requêtes de réponses
CREATE INDEX IF NOT EXISTS idx_commentaires_parent_id ON commentaires(parent_id);

-- Activer Row Level Security
ALTER TABLE commentaires ENABLE ROW LEVEL SECURITY;

-- Supprimer les politiques existantes (pour pouvoir réexécuter le script)
DROP POLICY IF EXISTS "Tout le monde peut lire les commentaires" ON commentaires;
DROP POLICY IF EXISTS "Tout le monde peut ajouter un commentaire" ON commentaires;

-- Permettre à tout le monde de lire les commentaires
CREATE POLICY "Tout le monde peut lire les commentaires"
  ON commentaires FOR SELECT
  USING (true);

-- Permettre à tout le monde d'insérer des commentaires (avec la clé anon)
CREATE POLICY "Tout le monde peut ajouter un commentaire"
  ON commentaires FOR INSERT
  WITH CHECK (true);
