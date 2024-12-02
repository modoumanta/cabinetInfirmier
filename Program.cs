using System;

namespace CabinetMedical
{
    class Program
    {
        static void Main(string[] args)
        {
            string filePath = "C:\\Users\\utilisateur\\OneDrive\\Documents\\L3MIAGE\\XML\\CabinetInfirmier\\Data\\xml\\cabinet.xml";

            try
            {
                // Assurer que le fichier existe
                FileInitializer.EnsureFileExists(filePath);

                // Exemple : Ajouter un infirmier
                Infirmier newInfirmier = new()
                {
                    Id = "003",
                    Nom = "Dupont",
                    Prenom = "Marie",
                    Photo = "photo_marie.jpg"
                };

                CabinetManager.AddInfirmier(filePath, newInfirmier);

                // Exemple : Ajouter un patient
                Patient newPatient = new()
                {
                    Nom = "Martin",
                    Prenom = "Paul",
                    Sexe = "M",
                    NumeroSecu = "1234567890123",
                    Naissance = new DateTime(1985, 5, 20),
                    Adresse = new Adresse
                    {
                        Numero = 10,
                        Rue = "Rue de Paris",
                        CodePostal = "75001",
                        Ville = "Paris",
                        Etage = 2
                    }
                };

                //CabinetManager.AddPatient(filePath, newPatient);
                Console.WriteLine("Données ajoutées avec succès.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Une erreur s'est produite : {ex.Message}");
            }
        }
    }
}