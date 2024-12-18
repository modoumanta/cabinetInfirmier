using System;
using System.Collections.Generic;
using System.IO;
using System.Xml.Serialization;

namespace CabinetMedical
{
    [XmlRoot("cabinet", Namespace = "http://www.univ-grenoble-alpes.fr/l3miage/medical/cabinet")]
    public class Cabinet
    {
        [XmlAttribute("nom")]
        public string Nom { get; set; }

        [XmlElement("adresse")]
        public Adresse Adresse { get; set; }

        [XmlElement("infirmiers")]
        public Infirmiers Infirmiers { get; set; }

        [XmlElement("patients")]
        public Patients Patients { get; set; }
    }

    public class Adresse
    {
        [XmlElement("numero")]
        public int Numero { get; set; }

        [XmlElement("rue")]
        public string Rue { get; set; }

        [XmlElement("codePostal")]
        public string CodePostal { get; set; }

        [XmlElement("ville")]
        public string Ville { get; set; }

        [XmlElement("etage")]
        public int Etage { get; set; }
    }

    public class Infirmiers
    {
        [XmlElement("infirmier")]
        public List<Infirmier> InfirmierList { get; set; } = new();
    }

    public class Infirmier
    {
        [XmlAttribute("id")]
        public String Id { get; set; }

        [XmlElement("nom")]
        public string Nom { get; set; }

        [XmlElement("prenom")]
        public string Prenom { get; set; }

        [XmlElement("photo")]
        public string Photo { get; set; }
    }

    public class Patients
    {
        [XmlElement("patient")]
        public List<Patient> PatientList { get; set; } = new();
    }

    public class Patient
    {
        [XmlElement("nom")]
        public string Nom { get; set; }

        [XmlElement("prenom")]
        public string Prenom { get; set; }

        [XmlElement("sexe")]
        public string Sexe { get; set; }

        [XmlElement("numeroSecu")]
        public string NumeroSecu { get; set; }

        [XmlElement("naissance")]
        public DateTime Naissance { get; set; }

        [XmlElement("adresse")]
        public Adresse Adresse { get; set; }

        [XmlElement("visite")]
        public List<Visite> Visites { get; set; } = new();
    }

    public class Visite
    {
        [XmlElement("date")]
        public string Date { get; set; }

        [XmlElement("intervenant")]
        public Intervenant Intervenant { get; set; }

        [XmlAttribute("acte")]
        public string Acte { get; set; }
    }

    public class Intervenant
    {
        [XmlAttribute("id")]
        public int Id { get; set; }
    }
    
    public static class CabinetManager
    {
        public static void AddInfirmier(string filePath, Infirmier newInfirmier)
        {
            Cabinet cabinet = XmlHandler.DeserializeFromFile(filePath);

            // Vérifier si l'infirmier existe déjà
            if (cabinet.Infirmiers.InfirmierList.Any(i => i.Id == newInfirmier.Id))
            {
                throw new InvalidOperationException($"Un infirmier avec l'ID {newInfirmier.Id} existe déjà.");
            }

            cabinet.Infirmiers.InfirmierList.Add(newInfirmier);
            XmlHandler.SerializeToFile(cabinet, filePath);
        }

        public static void AddPatient(string filePath, Patient newPatient)
        {
            Cabinet cabinet = XmlHandler.DeserializeFromFile(filePath);

            // Vérifier si le patient existe déjà
            if (cabinet.Patients.PatientList.Any(p => p.NumeroSecu == newPatient.NumeroSecu))
            {
                throw new InvalidOperationException($"Un patient avec le numéro de sécurité sociale {newPatient.NumeroSecu} existe déjà.");
            }

            cabinet.Patients.PatientList.Add(newPatient);
            XmlHandler.SerializeToFile(cabinet, filePath);
        }
    }
    
    public static class FileInitializer
    {
        public static void EnsureFileExists(string filePath)
        {
            if (!File.Exists(filePath))
            {
                Cabinet newCabinet = new()
                {
                    Nom = "Cabinet Médical",
                    Adresse = new Adresse
                    {
                        Numero = 1,
                        Rue = "Rue Principale",
                        CodePostal = "00000",
                        Ville = "Ville Exemple",
                        Etage = 0
                    },
                    Infirmiers = new Infirmiers(),
                    Patients = new Patients()
                };

                XmlHandler.SerializeToFile(newCabinet, filePath);
            }
        }
    }
}
